
package
{
	import pixeldroid.logging.Logger;
	import pixeldroid.logging.LogLevel;
	
	public function info(messageOwner:Object, message:String, ... messageArguments):void
	{
		Logger.instance.logWithArgs(LogLevel.INFO, messageOwner, message, messageArguments);
	}
}
