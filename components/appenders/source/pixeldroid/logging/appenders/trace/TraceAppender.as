
package pixeldroid.logging.appenders.trace
{
	import flash.display.Sprite;

	import pixeldroid.logging.ILogAppender;
	import pixeldroid.logging.ILogConfig;
	import pixeldroid.logging.ILogEntry;
	import pixeldroid.logging.LogUtils;


	public class TraceAppender extends Sprite implements ILogAppender
	{

		/**
		* Append a message to flashlog.txt file.
		*
		* <p><i>note:</i> works only in debug player.</p>
		*
		* @param logEntry Entry to log
		*/
		public function append(logEntry:ILogEntry, config:ILogConfig):void
		{
			const msg:String = LogUtils.formatString(config.pattern, logEntry);
			trace(msg);
		}
	}
}
