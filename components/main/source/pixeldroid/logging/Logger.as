
package pixeldroid.logging
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;


	public final class Logger implements ILoggingFacade, IConfigurableLogger
	{
		private static const instance:Logger = new Logger(); // need instance for interface implementation
		private static var sealed:Boolean = false; // not using lazy instantiation so need isConstructed flag

		public static function get configProxy():IConfigurableLogger  { return instance as IConfigurableLogger; }

		public static function get loggingFacade():ILoggingFacade  { return instance as ILoggingFacade; }

		{
			// static code block runs the first time a property or method of a static class is called
			// executes after static members are set, 
			// but before any property value is returned or function executed
			// http://kaioa.com/node/100
			sealed = true;
		}

		private var logLevel:LogLevel;
		private var _config:ILogConfig;


		public function Logger()
		{
			if (sealed)
				throw new ArgumentError("Singleton may not be instantiated directly. Use static instance for access.");

			logLevel = LogLevel.ALL;
			_config = new LogConfig(logLevel);
		}

		public function get config():ILogConfig  { return _config; }

		public function debug(messageOwner:Object, message:String, ... messageArguments):void
		{
			LogDispatcher.dispatchLogMessage(LogLevel.DEBUG, messageOwner, message, messageArguments, _config);
		}

		public function error(messageOwner:Object, message:String, ... messageArguments):void
		{
			LogDispatcher.dispatchLogMessage(LogLevel.ERROR, messageOwner, message, messageArguments, _config);
		}

		public function fatal(messageOwner:Object, message:String, ... messageArguments):void
		{
			LogDispatcher.dispatchLogMessage(LogLevel.FATAL, messageOwner, message, messageArguments, _config);
		}

		public function info(messageOwner:Object, message:String, ... messageArguments):void
		{
			LogDispatcher.dispatchLogMessage(LogLevel.INFO, messageOwner, message, messageArguments, _config);
		}

		public function get isDebugEnabled():Boolean  { return LogLevel.DEBUG >= logLevel; }

		public function get isErrorEnabled():Boolean  { return LogLevel.ERROR >= logLevel; }

		public function get isFatalEnabled():Boolean  { return LogLevel.FATAL >= logLevel; }

		public function get isInfoEnabled():Boolean  { return LogLevel.INFO >= logLevel; }

		public function get isWarnEnabled():Boolean  { return LogLevel.WARN >= logLevel; }

		public function log(level:LogLevel, messageOwner:Object, message:String, ... messageArguments):void
		{
			LogDispatcher.dispatchLogMessage(level, messageOwner, message, messageArguments, _config);
		}

		public function setConfig(value:ILogConfig):void
		{
			_config = value;
			logLevel = _config.level;
			loadAppenders(config.appenders);
		}

		public function setConfigLoader(value:ILogConfigLoader):void
		{
			value.load(this); // ask loader to execute and return results to this instance (via setConfig() )
		}

		public function warn(messageOwner:Object, message:String, ... messageArguments):void
		{
			LogDispatcher.dispatchLogMessage(LogLevel.WARN, messageOwner, message, messageArguments, _config);
		}

		/*
		// TODO: add to toplevel:
		public function get debugEnabled():Boolean { return Logger.loggingFacade.isDebugEnabled; }
		// allows guard:
		debugEnabled && debug(this, "calculation: {0}", expensiveCall());
		*/

		private function loadAppenders(appenders:Vector.<URLRequest>):void
		{
			// TODO: queue? what is max number of loaders that can be active at once?
			for (var i:uint = 0; i < appenders.length; i++)
			{
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onAppenderLoaded);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onAppenderLoadError);

				// TODO: support appender use across domains?
				// a) add Security.allowDomain() to appenders to allow use across domains
				// b) don't access loader.content; communicate via loaderInfo.sharedEvents
				//   http://www.senocular.com/flash/tutorials/contentdomains/#SWFCommunicationWithoutTrust
				//   http://code.google.com/p/maashaack/wiki/ApplicationDomain
				loader.load(appenders[i]); // using default context to load into child app domain of current security domain
			}
		}

		private function onAppenderLoadError(event:IOErrorEvent):void
		{
			warn(this, "unable to load appender: {0}", event);
			removeAppenderLoadListeners(Loader(event.target));
		}

		private function onAppenderLoaded(event:Event):void
		{
			var loaderInfo:LoaderInfo = LoaderInfo(event.target);
			var loader:Loader = loaderInfo.loader;
			removeAppenderLoadListeners(loader);

			try
			{
				var appender:ILogAppender = ILogAppender(loader.content);
				info(this, "loaded appender: {0}", appender);
				LogDispatcher.addAppender(appender);
			}
			catch (error:SecurityError)
			{
				warn(this, "unable to access loaded content for appender: {0}", error);
			}
		}

		private function removeAppenderLoadListeners(loader:Loader):void
		{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onAppenderLoaded);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onAppenderLoadError);
		}
	}
}
