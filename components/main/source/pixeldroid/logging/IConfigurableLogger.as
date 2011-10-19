
package pixeldroid.logging
{
	public interface IConfigurableLogger
	{
		function setConfigLoader(value:ILogConfigLoader):void;
		
		function setConfig(value:ILogConfig):void;
		
		function get config():ILogConfig;
	}
}
