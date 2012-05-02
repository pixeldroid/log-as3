
package pixeldroid.logging
{
	import flash.net.URLRequest;


	public class LogConfig implements ILogConfig
	{

		protected var _appenders:Vector.<URLRequest> = new <URLRequest>[];
		protected var _filters:Vector.<String> = new <String>[];
		protected var _level:LogLevel = LogLevel.ALL;
		protected var _pattern:String = "%elapsed{8} [%class{}] %message{}";


		public function LogConfig(level:LogLevel, pattern:String = null, appenders:Vector.<URLRequest> = null, filters:Vector.<String> = null)
		{
			_level = level;
			if (pattern)
				_pattern = pattern;
			if (filters)
				_filters = filters;
			if (appenders)
				_appenders = appenders;
		}

		public function get appenders():Vector.<URLRequest>
		{
			return _appenders;
		}

		public function get filters():Vector.<String>
		{
			return _filters;
		}

		public function get level():LogLevel
		{
			return _level;
		}

		public function get pattern():String
		{
			return _pattern;
		}
	}
}
