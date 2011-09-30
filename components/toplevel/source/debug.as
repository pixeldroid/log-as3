
package
{
	import pixeldroid.logging.Logger;
	import pixeldroid.logging.LogLevel;
	
	public function debug(messageOwner:Object, message:String, ... messageArguments):void
	{
		Logger.instance.dispatchLogMessage(LogLevel.DEBUG, messageOwner, message, messageArguments);
	}
}
