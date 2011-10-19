
package
{
	import pixeldroid.logging.LogDispatcher;
	import pixeldroid.logging.LogLevel;
	import pixeldroid.logging.Logger;
	
	public function info(messageOwner:Object, message:String, ... messageArguments):void
	{
		LogDispatcher.dispatchLogMessage(LogLevel.INFO, messageOwner, message, messageArguments, Logger.configProxy.config);
	}
}
