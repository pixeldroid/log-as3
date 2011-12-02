
package pixeldroid.logging.appenders.trace
{
	import flash.display.Sprite;

	import pixeldroid.logging.ILogAppender;
	import pixeldroid.logging.ILogEntry;
	import pixeldroid.logging.LogUtils;

	public class TraceAppender extends Sprite implements ILogAppender
	{

		// ILogAppender

		/**
		* Append a message to flashlog.txt file.
		*
		* <p><i>note:</i> works only in debug player.</p>
		*
		* @param logEntry Entry to log
		*/
		public function append(logEntry:ILogEntry):void
		{
			var msg:String = LogUtils.formatString("", logEntry);
			//throw new Error(logEntry.message);
			trace(msg);
		}
	}
}
