
package pixeldroid.logging
{
	import flash.utils.Dictionary;
	
	final public class Logger implements ILoggingFacade, IConfigurableLogger
	{
		static public const instance:Logger = new Logger(); // need instance for interface implementation
		static private var sealed:Boolean = false; // not using lazy instantiation so need isConstructed flag
		
		{
			// static code block runs the first time a property or method of a static class is called
			// executes after static members are set, 
			// but before any property value is returned or function executed
			// http://kaioa.com/node/100
			sealed = true;
		}
		
		
		private var logLevel:LogLevel = LogLevel.ALL;
		private var _config:ILogConfig;
		
		
		public function Logger()
		{
			if (sealed) throw new ArgumentError("Singleton may not be instantiated directly. Use static instance for access.");
		}
		
		public function get isDebugEnabled():Boolean { return LogLevel.DEBUG >= logLevel; }
		public function get isInfoEnabled():Boolean  { return LogLevel.INFO  >= logLevel; }
		public function get isWarnEnabled():Boolean  { return LogLevel.WARN  >= logLevel; }
		public function get isErrorEnabled():Boolean { return LogLevel.ERROR >= logLevel; }
		public function get isFatalEnabled():Boolean { return LogLevel.FATAL >= logLevel; }
		/*
		public function get debugWillLog():Boolean { return Logger.instance.isDebugEnabled; }
		debugWillLog && debug(this, "calculation: {0}", expensiveCall());
		debugEnabled && debug(...
		debugLevel && debug(...
		*/
		
		
		// IConfigurableLogger
		public function setConfig(value:ILogConfig):void
		{
			_config = value;
			logLevel = _config.level;
		}
		
		public function get config():ILogConfig { return _config; }
		
		// ILoggingFacade		
		public function fatal(messageOwner:Object, message:String, ... messageArguments):void
		{
			LogDispatcher.dispatchLogMessage(LogLevel.FATAL, messageOwner, message, messageArguments, _config);
		}
		
		public function error(messageOwner:Object, message:String, ... messageArguments):void
		{
			LogDispatcher.dispatchLogMessage(LogLevel.ERROR, messageOwner, message, messageArguments, _config);
		}
		
		public function warn(messageOwner:Object, message:String, ... messageArguments):void
		{
			LogDispatcher.dispatchLogMessage(LogLevel.WARN, messageOwner, message, messageArguments, _config);
		}
		
		public function info(messageOwner:Object, message:String, ... messageArguments):void
		{
			LogDispatcher.dispatchLogMessage(LogLevel.INFO, messageOwner, message, messageArguments, _config);
		}
		
		public function debug(messageOwner:Object, message:String, ... messageArguments):void
		{
			LogDispatcher.dispatchLogMessage(LogLevel.DEBUG, messageOwner, message, messageArguments, _config);
		}
		
		public function log(level:LogLevel, messageOwner:Object, message:String, ... messageArguments):void
		{
			LogDispatcher.dispatchLogMessage(level, messageOwner, message, messageArguments, _config);
		}
		
	}
}

