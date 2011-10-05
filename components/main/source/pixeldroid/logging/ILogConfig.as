package pixeldroid.logging
{
	public interface ILogConfig
	{
		function get level():LogLevel;
		function get filters():Vector.<String>;
	}
}