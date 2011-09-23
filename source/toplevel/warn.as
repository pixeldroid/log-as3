
package
{
	import pixeldroid.logging.Logger;
	import pixeldroid.logging.LogLevel;
	
	public function warn(messageOwner:Object, message:String, ... messageArguments):void
	{
		Logger.instance.logWithArgs(LogLevel.WARN, messageOwner, message, messageArguments);
	}
}
