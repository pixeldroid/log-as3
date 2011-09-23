
package pixeldroid.logging
{
	import pixeldroid.logging.ILogAppender;
	
	public interface ILogger
	{
		function addAppender(appender:ILogAppender):void;
		function removeAppender(appender:ILogAppender):void;
	}
}
