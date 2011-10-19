package pixeldroid.logging
{
	import flash.net.URLRequest;
	
	public class LogConfig implements ILogConfig
	{
		protected var _level:LogLevel = LogLevel.ALL;
		protected var _filters:Vector.<String> = new Vector.<String>();
		protected var _appenders:Vector.<URLRequest> = new Vector.<URLRequest>();
		
		public function LogConfig(level:LogLevel, appenders:Vector.<URLRequest>=null, filters:Vector.<String>=null)
		{
			_level = level;
			if (filters) _filters = filters;
			if (appenders) _appenders = appenders;
		}
		
		public function get level():LogLevel
		{
			return _level;
		}
		
		public function get filters():Vector.<String>
		{
			return _filters;
		}
		
		public function get appenders():Vector.<URLRequest>
		{
			return _appenders;
		}
	}
}