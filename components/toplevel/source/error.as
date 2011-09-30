
package
{
	import pixeldroid.logging.Logger;
	import pixeldroid.logging.LogLevel;
	
	public function error(messageOwner:Object, message:String, ... messageArguments):void
	{
		Logger.instance.dispatchLogMessage(LogLevel.ERROR, messageOwner, message, messageArguments);
	}
}
