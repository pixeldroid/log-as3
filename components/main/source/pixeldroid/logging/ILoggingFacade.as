
package pixeldroid.logging
{
	import pixeldroid.logging.LogLevel;


	public interface ILoggingFacade
	{

		function debug(messageOwner:Object, message:String, ... messageArguments):void;

		function error(messageOwner:Object, message:String, ... messageArguments):void;

		function fatal(messageOwner:Object, message:String, ... messageArguments):void;

		function info(messageOwner:Object, message:String, ... messageArguments):void;

		function get isDebugEnabled():Boolean;

		function get isErrorEnabled():Boolean;

		function get isFatalEnabled():Boolean;

		function get isInfoEnabled():Boolean;

		function get isWarnEnabled():Boolean;

		function log(level:LogLevel, messageOwner:Object, message:String, ... messageArguments):void;

		function warn(messageOwner:Object, message:String, ... messageArguments):void;
	}
}
