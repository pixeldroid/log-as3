
package pixeldroid.logging
{
	import pixeldroid.logging.ILogger;
	import pixeldroid.logging.ILogAppender;
	
	final public class LogLevel
	{
		static public const OFF_INT:int   = int.MAX_VALUE;
		static public const FATAL_INT:int = 50000;
		static public const ERROR_INT:int = 40000;
		static public const WARN_INT:int  = 30000;
		static public const INFO_INT:int  = 20000;
		static public const DEBUG_INT:int = 10000;
		static public const ALL_INT:int   = int.MIN_VALUE;
		
		static public const OFF:LogLevel = new LogLevel(OFF_INT, "OFF");
		static public const FATAL:LogLevel = new LogLevel(FATAL_INT, "FATAL");
		static public const ERROR:LogLevel = new LogLevel(ERROR_INT, "ERROR");
		static public const WARN:LogLevel = new LogLevel(WARN_INT, "WARN");
		static public const INFO:LogLevel = new LogLevel(INFO_INT, "INFO");
		static public const DEBUG:LogLevel = new LogLevel(DEBUG_INT, "DEBUG");
		static public const ALL:LogLevel = new LogLevel(ALL_INT, "ALL");
		
		static public function fromInt(value:int):LogLevel
		{
			var level:LogLevel;
			
			if (value > FATAL_INT) level = OFF;
			else if (value > ERROR_INT) level = FATAL;
			else if (value > WARN_INT) level = ERROR;
			else if (value > INFO_INT) level = WARN;
			else if (value > DEBUG_INT) level = INFO;
			else if (value > ALL_INT) level = DEBUG;
			else level = ALL;
			
			return level;
		}
		
		static public function fromString(value:String):LogLevel
		{
			var level:LogLevel;
			
			switch(value.toUpperCase())
			{
				case OFF.toString()   : level = OFF;   break;
				case FATAL.toString() : level = FATAL; break;
				case ERROR.toString() : level = ERROR; break;
				case WARN.toString()  : level = WARN;  break;
				case INFO.toString()  : level = INFO;  break;
				case DEBUG.toString() : level = DEBUG; break;
				
				default : level = ALL; break;
			}
			
			return level;
		}
		
		
		private var rank:int;
		private var label:String;
		
		public function LogLevel(rank:int, label:String)
		{
			this.rank = rank;
			this.label = label;
		}
		
		public function toString():String { return label; }
		public function valueOf():int { return rank; }
	}
}
