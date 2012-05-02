
package pixeldroid.logging
{


	public final class LogLevel
	{
		public static const OFF_INT:int = int.MAX_VALUE;
		public static const FATAL_INT:int = 50000;
		public static const ERROR_INT:int = 40000;
		public static const WARN_INT:int = 30000;
		public static const INFO_INT:int = 20000;
		public static const DEBUG_INT:int = 10000;
		public static const ALL_INT:int = int.MIN_VALUE;

		public static const OFF:LogLevel = new LogLevel(OFF_INT, "OFF");
		public static const FATAL:LogLevel = new LogLevel(FATAL_INT, "FATAL");
		public static const ERROR:LogLevel = new LogLevel(ERROR_INT, "ERROR");
		public static const WARN:LogLevel = new LogLevel(WARN_INT, "WARN");
		public static const INFO:LogLevel = new LogLevel(INFO_INT, "INFO");
		public static const DEBUG:LogLevel = new LogLevel(DEBUG_INT, "DEBUG");
		public static const ALL:LogLevel = new LogLevel(ALL_INT, "ALL");

		public static const DEFAULT:LogLevel = ALL;

		public static function fromInt(value:int):LogLevel
		{
			var level:LogLevel;

			if (value > FATAL_INT)
				level = OFF;
			else if (value > ERROR_INT)
				level = FATAL;
			else if (value > WARN_INT)
				level = ERROR;
			else if (value > INFO_INT)
				level = WARN;
			else if (value > DEBUG_INT)
				level = INFO;
			else if (value > ALL_INT)
				level = DEBUG;

			else
				level = DEFAULT;

			return level;
		}

		public static function fromString(value:String):LogLevel
		{
			var level:LogLevel;

			switch (value.toUpperCase())
			{
				case OFF.toString():
					level = OFF;
					break;
				case FATAL.toString():
					level = FATAL;
					break;
				case ERROR.toString():
					level = ERROR;
					break;
				case WARN.toString():
					level = WARN;
					break;
				case INFO.toString():
					level = INFO;
					break;
				case DEBUG.toString():
					level = DEBUG;
					break;

				default:
					level = DEFAULT;
					break;
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

		public function toString():String  { return label; }

		public function valueOf():int  { return rank; }
	}
}
