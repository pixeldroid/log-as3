
package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import pixeldroid.logging.ILogConfig;
	import pixeldroid.logging.LogConfig;
	import pixeldroid.logging.LogDispatcher;
	import pixeldroid.logging.LogLevel;
	import pixeldroid.logging.Logger;
	import pixeldroid.logging.appenders.console.ConsoleAppender;
	
	public class TestStandard extends Sprite
	{
		protected var frame:uint = 0;
	
		public function TestStandard()
		{
			super();
			
			// synchronous add (compile-time)
			var c:ConsoleAppender = new ConsoleAppender();
			addChild(c);
			LogDispatcher.addAppender(c);
			
			// asynchronous add (run-time)
			var appenders:Vector.<URLRequest> = new Vector.<URLRequest>();
			appenders.push(new URLRequest("../../appenders/release/as3-log.appender.browser-0.0.5.swf"));
			appenders.push(new URLRequest("../../appenders/release/as3-log.appender.trace-0.0.5.swf"));
			var logConfig:ILogConfig = new LogConfig(LogLevel.ALL, appenders);
			Logger.configProxy.setConfig(logConfig);
			
			// recurring log calls
			addEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		protected function onFrame(event:Event):void
		{
			frame++;
			if (frame == 1) log();
			else if (frame % (30*3) == 0) log();
		}
		
		protected function log():void
		{
			Logger.loggingFacade.fatal(this, "{0}: {1} log message", frame, "fatal");
			Logger.loggingFacade.error(this, "{0}: {1} log message", frame, "error");
			Logger.loggingFacade.warn(this, "{0}: {1} log message", frame, "warn");
			Logger.loggingFacade.info(this, "{0}: {1} log message", frame, "info");
			Logger.loggingFacade.debug(this, "{0}: {1} log message", frame, "debug");
			
			Logger.loggingFacade.log(LogLevel.FATAL, this, "{0}: {1} log message", frame, "log:FATAL");
			Logger.loggingFacade.log(LogLevel.ERROR, this, "{0}: {1} log message", frame, "log:ERROR");
			Logger.loggingFacade.log(LogLevel.WARN, this, "{0}: {1} log message", frame, "log:WARN");
			Logger.loggingFacade.log(LogLevel.INFO, this, "{0}: {1} log message", frame, "log:INFO");
			Logger.loggingFacade.log(LogLevel.DEBUG, this, "{0}: {1} log message", frame, "log:DEBUG");
		}
	}
}
