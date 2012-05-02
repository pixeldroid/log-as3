
package pixeldroid.logging
{


	public interface ILogEntry
	{

		function get category():String;

		function clear():void;

		function get elapsed():int;

		function get level():LogLevel;

		function get message():String;

		function setEntry(level:LogLevel, message:String, category:String = null):void;

		function get timeStamp():Number
	}
}
