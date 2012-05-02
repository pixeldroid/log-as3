
package pixeldroid.logging.appenders.browser
{
	import flash.display.Sprite;
	import flash.external.ExternalInterface;

	import pixeldroid.logging.ILogAppender;
	import pixeldroid.logging.ILogConfig;
	import pixeldroid.logging.ILogEntry;
	import pixeldroid.logging.LogLevel;
	import pixeldroid.logging.LogUtils;


	public class JsConsoleAppender extends Sprite implements ILogAppender
	{

		/**
		 * Append a message to the javascript console of the hosting web browser, i.e. console.log().
		 *
		 * <p>
		 * Chrome10+ (CTRL-SHFT-J) and IE8+ (F12) provide a javascript console in their built-in developer tools,
		 * and Firefox supports it through the Firebug add-on (CTRL-F12).
		 * </p>
		 *
		 * @param logEntry Entry to log
		 *
		 * @see http://getfirebug.com/
		 * @see pixeldroid.logging.ILogEntry
		 */
		public function append(logEntry:ILogEntry, config:ILogConfig):void
		{
			if (!ExternalInterface.available)
				return;

			var f:String;
			switch (logEntry.level)
			{
				case LogLevel.DEBUG:
					f = "function console_debug(msg){ if (window.console) console.debug(msg); }";
					break;

				case LogLevel.INFO:
					f = "function console_info(msg){ if (window.console) console.info(msg); }";
					break;

				case LogLevel.WARN:
					f = "function console_warn(msg){ if (window.console) console.warn(msg); }";
					break;

				case LogLevel.ERROR:
					f = "function console_error(msg){ if (window.console) console.error(msg); }";
					break;

				case LogLevel.FATAL:
					f = "function console_error(msg){ if (window.console) console.error('FATAL ' +msg); }";
					break;

				default:
					f = "function console_log(msg){ if (window.console) console.log(msg); }";
					break;
			}

			ExternalInterface.call(f, LogUtils.formatString(config.pattern, logEntry));
		}
	}
}
