
package
{
	import pixeldroid.logging.LogDispatcher;
	import pixeldroid.logging.LogLevel;
	import pixeldroid.logging.Logger;
	
	public function warn(messageOwner:Object, message:String, ... messageArguments):void
	{
		LogDispatcher.dispatchLogMessage(LogLevel.WARN, messageOwner, message, messageArguments, Logger.configProxy.config);
	}
}
