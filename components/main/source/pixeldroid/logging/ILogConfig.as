
package pixeldroid.logging
{
	import flash.net.URLRequest;


	public interface ILogConfig
	{
		function get appenders():Vector.<URLRequest>;

		function get filters():Vector.<String>;

		function get level():LogLevel;

		function get pattern():String;
	}
}
