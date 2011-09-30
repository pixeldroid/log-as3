
package pixeldroid.logging
{
	
	public interface ILogAppender
	{
		/**
		* Log in appender-specific way.
		*
		* @param message Message to log
		*/
		function append(logEntry:ILogEntry):void;
	}
}
