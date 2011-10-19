package pixeldroid.logging
{
	import flash.net.URLRequest;

	public interface ILogConfig
	{
		function get level():LogLevel;
		function get filters():Vector.<String>;
		function get appenders():Vector.<URLRequest>;
	}
}