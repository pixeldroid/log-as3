
package
{
	import pixeldroid.logging.LogDispatcher;
	import pixeldroid.logging.LogLevel;
	import pixeldroid.logging.Logger;
	
	public function fatal(messageOwner:Object, message:String, ... messageArguments):void
	{
		LogDispatcher.dispatchLogMessage(LogLevel.FATAL, messageOwner, message, messageArguments, Logger.instance.config);
	}
}
