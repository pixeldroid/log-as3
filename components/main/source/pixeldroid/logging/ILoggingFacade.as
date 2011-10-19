
package pixeldroid.logging
{
	import pixeldroid.logging.LogLevel;
	
	public interface ILoggingFacade
	{
		function fatal(messageOwner:Object, message:String, ... messageArguments):void;
		
		function error(messageOwner:Object, message:String, ... messageArguments):void;
		
		function warn(messageOwner:Object, message:String, ... messageArguments):void;
		
		function info(messageOwner:Object, message:String, ... messageArguments):void;
		
		function debug(messageOwner:Object, message:String, ... messageArguments):void;
		
		function log(level:LogLevel, messageOwner:Object, message:String, ... messageArguments):void;
		
		function get isDebugEnabled():Boolean;
		
		function get isInfoEnabled():Boolean;
		
		function get isWarnEnabled():Boolean;
		
		function get isErrorEnabled():Boolean;
		
		function get isFatalEnabled():Boolean;
	}
}
