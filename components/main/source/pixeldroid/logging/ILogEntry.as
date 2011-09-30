package pixeldroid.logging
{
	public interface ILogEntry
	{
		function setEntry(level:LogLevel, message:String, category:String=null):void;
		
		function get timeStamp():int;
		
		function get category():String;
		
		function get message():String;
		
		function get level():LogLevel;
		
		function clear():void;
	}
}