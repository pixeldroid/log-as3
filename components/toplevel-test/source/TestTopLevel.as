
package
{
	import flash.display.Sprite;
	
	import pixeldroid.logging.LogDispatcher;
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
			
			var c:ConsoleAppender = new ConsoleAppender();
			addChild(c);
			LogDispatcher.addAppender(c);
			
			fatal(this, "{0} log message (top level)", "fatal");
			error(this, "{0} log message (top level)", "error");
			warn(this, "{0} log message (top level)", "warn");
			info(this, "{0} log message (top level)", "info");
			debug(this, "{0} log message (top level)", "debug");
		}
	}
}
