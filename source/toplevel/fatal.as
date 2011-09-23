
package
{
	import pixeldroid.logging.Logger;
	import pixeldroid.logging.LogLevel;
	
	public function fatal(messageOwner:Object, message:String, ... messageArguments):void
	{
		Logger.instance.logWithArgs(LogLevel.FATAL, messageOwner, message, messageArguments);
	}
}
