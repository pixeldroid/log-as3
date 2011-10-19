
package
{
	import pixeldroid.logging.LogDispatcher;
	import pixeldroid.logging.LogLevel;
	import pixeldroid.logging.Logger;
	
	public function error(messageOwner:Object, message:String, ... messageArguments):void
	{
		LogDispatcher.dispatchLogMessage(LogLevel.ERROR, messageOwner, message, messageArguments, Logger.configProxy.config);
	}
}
