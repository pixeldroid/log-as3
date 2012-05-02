
package
{
	import flash.display.Sprite;

	import pixeldroid.logging.LogConfig;
	import pixeldroid.logging.LogDispatcher;
	import pixeldroid.logging.LogLevel;
	import pixeldroid.logging.Logger;
	import pixeldroid.logging.appenders.browser.JsConsoleAppender;
	import pixeldroid.logging.appenders.console.ConsoleAppender;
	import pixeldroid.logging.appenders.trace.TraceAppender;


	public class TestTopLevel extends Sprite
	{

		public function TestTopLevel()
		{
			super();

			LogDispatcher.addAppender(new TraceAppender());
			LogDispatcher.addAppender(new JsConsoleAppender());

			const c:ConsoleAppender = new ConsoleAppender();
			addChild(c);
			LogDispatcher.addAppender(c);

			fatal(this, "{0} log message (top level)", "fatal");
			error(this, "{0} log message (top level)", "error");
			warn(this, "{0} log message (top level)", "warn");
			info(this, "{0} log message (top level)", "info");
			debug(this, "{0} log message (top level)", "debug");

			var p:String;

			p = " %level{} %class{} %message{}";
			Logger.configProxy.setConfig(new LogConfig(LogLevel.ALL, p));

			info(this, "{0} log message in new format", "info");
			debug(this, "{0} log message in new format", "debug");

			p = "%date{Y.M.D h:m.s.S} %message{}";
			Logger.configProxy.setConfig(new LogConfig(LogLevel.ALL, p));

			info(this, "{0} log message in new format", "info");
			debug(this, "{0} log message in new format", "debug");

			p = "[%level{}] %date{h:m.s#S} %class{} %message{}";
			Logger.configProxy.setConfig(new LogConfig(LogLevel.ALL, p));

			info(this, "{0} log message in new format", "info");
			debug(this, "{0} log message in new format", "debug");
		}
	}
}
