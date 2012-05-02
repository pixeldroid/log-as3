
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
		protected var pattern:uint = 0;
		protected var appenders:Vector.<URLRequest> = new <URLRequest>[];


		public function TestStandard()
		{
			super();

			// synchronous add (compile-time)
			const c:ConsoleAppender = new ConsoleAppender();
			addChild(c);
			LogDispatcher.addAppender(c);

			// asynchronous add (run-time)
			appenders.push(new URLRequest("../../appenders/release/as3-log.appender.browser-0.0.7.swf"));
			appenders.push(new URLRequest("../../appenders/release/as3-log.appender.trace-0.0.7.swf"));
			Logger.configProxy.setConfig(new LogConfig(LogLevel.ALL, "", appenders));

			// recurring log calls
			addEventListener(Event.ENTER_FRAME, onFrame);
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

		protected function newPattern():void
		{
			const p:Vector.<String> = new <String>["",
				" %level{} %class{} %message{}",
				"%date{Y.M.D h:m.s.S} %message{}",
				"[%level{}] %date{h:m.s#S} %class{} %message{}",
				"%elapsed{} %level{} %class{} %message{}"];
			const i:uint = pattern++ % p.length;
			Logger.configProxy.setConfig(new LogConfig(LogLevel.ALL, p[i], appenders));
		}

		protected function onFrame(event:Event):void
		{
			frame++;
			if (frame == 1)
				log();
			else if (frame % (30 * 3) == 0)
			{
				newPattern();
				log();
			}
		}
	}
}
