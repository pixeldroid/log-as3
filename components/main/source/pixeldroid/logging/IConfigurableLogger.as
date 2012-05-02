
package pixeldroid.logging
{


	public interface IConfigurableLogger
	{

		function get config():ILogConfig;

		function setConfig(value:ILogConfig):void;

		function setConfigLoader(value:ILogConfigLoader):void;
	}
}
