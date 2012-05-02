
package pixeldroid.logging
{
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;


	// TODO: move to namespace?
	public class LogDispatcher
	{
		private static var _numAppenders:uint = 0;
		private static var appenders:Dictionary = new Dictionary();
		private static var nameMap:Dictionary = new Dictionary();
		private static var logEntry:ILogEntry = new LogEntry();

		public static function addAppender(appender:ILogAppender):ILogAppender
		{
			if (!appenders[appender])
				_numAppenders++;
			appenders[appender] = appender;
			return appender;
		}

		public static function dispatchLogMessage(level:LogLevel, messageOwner:Object, message:String, messageArguments:Array, config:ILogConfig):void
		{
			if (level < config.level)
				return;

			var category:String = getName(messageOwner);
			if (!LogUtils.passesFilter(category, config.filters))
				return;

			logEntry.setEntry(level, LogUtils.expandString(message, messageArguments), category);

			var appender:ILogAppender;
			for each (var item:Object in appenders)
			{
				appender = item as ILogAppender;
				appender.append(logEntry, config);
			}
		}

		public static function get numAppenders():uint  { return _numAppenders; }

		public static function removeAppender(appender:ILogAppender):ILogAppender
		{
			var removed:ILogAppender;
			if (appenders[appender])
			{
				_numAppenders--;
				removed = appenders[appender];
				appenders[appender] = null;
			}
			return removed;
		}


		private static function getName(object:Object):String
		{
			if (!nameMap[object])
			{
				var packages:Array = getQualifiedClassName(object).split("::");
				nameMap[object] = String(packages[packages.length - 1]);
			}

			return nameMap[object];
		}
	}
}
