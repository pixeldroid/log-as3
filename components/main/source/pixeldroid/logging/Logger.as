
package pixeldroid.logging
{
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	final public class Logger implements ILoggingFacade, IConfigurableLogger
	{
		static public const instance:Logger = new Logger();
		static private var sealed:Boolean = false;
		
		{
			// static code block executes after static members are set, 
			// but before external call to constructor
			sealed = true;
		}
		
		
		private var logLevel:LogLevel = LogLevel.ALL;
		private var nameMap:Dictionary = new Dictionary();
		private var logEntry:ILogEntry = new LogEntry();
		
		
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
		*/
		
		/** @private */
		public function dispatchLogMessage(level:LogLevel, messageOwner:Object, message:String, messageArguments:Array):void
		{
			if (level < logLevel) return; // config.level
			
			var category:String = getName(messageOwner);
			if (!LogUtils.passesFilter(category, '*')) return; // config.filter
			
			logEntry.setEntry(level, LogUtils.expandString(message, messageArguments), category);
			LogDispatcher.dispatchLogEntry(logEntry);
		}
		
		// IConfigurableLogger
		public function setConfig():void
		{
		}
		
		// public function get config():IConfig { return _config; }
		
		// ILoggingFacade		
		public function fatal(messageOwner:Object, message:String, ... messageArguments):void
		{
			dispatchLogMessage(LogLevel.FATAL, messageOwner, message, messageArguments);
		}
		
		public function error(messageOwner:Object, message:String, ... messageArguments):void
		{
			dispatchLogMessage(LogLevel.ERROR, messageOwner, message, messageArguments);
		}
		
		public function warn(messageOwner:Object, message:String, ... messageArguments):void
		{
			dispatchLogMessage(LogLevel.WARN, messageOwner, message, messageArguments);
		}
		
		public function info(messageOwner:Object, message:String, ... messageArguments):void
		{
			dispatchLogMessage(LogLevel.INFO, messageOwner, message, messageArguments);
		}
		
		public function debug(messageOwner:Object, message:String, ... messageArguments):void
		{
			dispatchLogMessage(LogLevel.DEBUG, messageOwner, message, messageArguments);
		}
		
		public function log(level:LogLevel, messageOwner:Object, message:String, ... messageArguments):void
		{
			dispatchLogMessage(level, messageOwner, message, messageArguments);
		}
		
		
		
		private function getName(object:Object):String
		{
			if (!nameMap[object])
			{
				var packages:Array = getQualifiedClassName(object).split("::");
				nameMap[object] = String(packages[packages.length-1]);
			}
			
			return nameMap[object];
		}
	}
}

