
package
{
	import pixeldroid.logging.LogDispatcher;
	import pixeldroid.logging.LogLevel;
	import pixeldroid.logging.Logger;
	
	public function debug(messageOwner:Object, message:String, ... messageArguments):void
	{
		LogDispatcher.dispatchLogMessage(LogLevel.DEBUG, messageOwner, message, messageArguments, Logger.configProxy.config);
	}
}
