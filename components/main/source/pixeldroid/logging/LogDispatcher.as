
package pixeldroid.logging
{
	import flash.utils.Dictionary;
	
	import pixeldroid.logging.ILogAppender;
	import pixeldroid.logging.LogLevel;
	
	// TODO: move to namespace?
	public class LogDispatcher
	{
		static private var appenders:Dictionary = new Dictionary();
		static private var _numAppenders:uint = 0;
		
		static public function get numAppenders():uint { return _numAppenders; }
		
		static public function addAppender(appender:ILogAppender):void
		{
			if (!appenders[appender]) _numAppenders++;
			appenders[appender] = appender;
		}
		
		static public function removeAppender(appender:ILogAppender):void
		{
			if (appenders[appender])
			{
				_numAppenders--;
				appenders[appender] = null;
			}
		}
		
		static public function dispatchLogEntry(logEntry:ILogEntry):void
		{
			var appender:ILogAppender;
			for each(var item:Object in appenders)
			{
				appender = item as ILogAppender;
				appender.append(logEntry);
			}
		}
		
	}
}
