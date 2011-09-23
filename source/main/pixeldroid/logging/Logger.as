
package pixeldroid.logging
{
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import pixeldroid.logging.ILogger;
	import pixeldroid.logging.ILogAppender;
	import pixeldroid.logging.LogLevel;
	import pixeldroid.logging.LogUtils;
	
	final public class Logger implements ILoggingFacade, ILogger, IConfigurableLogger
	{
		private var logLevel:LogLevel = LogLevel.ALL;
		private var nameMap:Dictionary = new Dictionary();
		private var appenders:Dictionary = new Dictionary();
		private var numAppenders:uint = 0;
		
		static public const instance:Logger = new Logger();
		static private var sealed:Boolean = false;
		
		{
			// static code block executes after static members are set, 
			// but before external call to constructor
			sealed = true;
		}
		
		public function Logger()
		{
			if (sealed) throw new ArgumentError("Singleton may not be instantiated directly. Use static instance for access.");
		}
		
		
		public function logWithArgs(level:LogLevel, messageOwner:Object, message:String, messageArguments:Array):void
		{
			if (level < logLevel) return;
			if (numAppenders == 0) return;
			
			var appender:ILogAppender;
			var category:String = getName(messageOwner);
			var expandedMessage:String = LogUtils.expandString(message, messageArguments)
			
			for each(var value:Object in appenders)
			{
				appender = value as ILogAppender;
				appender.log(level, category, expandedMessage);
			}
		}
		
		// ILogger
		public function addAppender(appender:ILogAppender):void
		{
			if (!appenders[appender]) numAppenders++;
			appenders[appender] = appender;
		}
		
		public function removeAppender(appender:ILogAppender):void
		{
			if (appenders[appender])
			{
				numAppenders--;
				appenders[appender] = null;
			}
		}
		
		public function get showFatal():Boolean { return LogLevel.FATAL >= logLevel; }
		public function get showError():Boolean { return LogLevel.ERROR >= logLevel; }
		public function get showWarn():Boolean { return LogLevel.WARN >= logLevel; }
		public function get showInfo():Boolean { return LogLevel.INFO >= logLevel; }
		public function get showDebug():Boolean { return LogLevel.DEBUG >= logLevel; }
		
		
		// IConfigurableLogger
		public function setConfig():void
		{
		}
		
		// ILoggingFacade		
		public function fatal(messageOwner:Object, message:String, ... messageArguments):void
		{
			logWithArgs(LogLevel.FATAL, messageOwner, message, messageArguments);
		}
		
		public function error(messageOwner:Object, message:String, ... messageArguments):void
		{
			logWithArgs(LogLevel.ERROR, messageOwner, message, messageArguments);
		}
		
		public function warn(messageOwner:Object, message:String, ... messageArguments):void
		{
			logWithArgs(LogLevel.WARN, messageOwner, message, messageArguments);
		}
		
		public function info(messageOwner:Object, message:String, ... messageArguments):void
		{
			logWithArgs(LogLevel.INFO, messageOwner, message, messageArguments);
		}
		
		public function debug(messageOwner:Object, message:String, ... messageArguments):void
		{
			logWithArgs(LogLevel.DEBUG, messageOwner, message, messageArguments);
		}
		
		public function log(level:LogLevel, messageOwner:Object, message:String, ... messageArguments):void
		{
			logWithArgs(level, messageOwner, message, messageArguments);
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

