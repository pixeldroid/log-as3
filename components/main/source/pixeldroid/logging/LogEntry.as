package pixeldroid.logging
{
	import flash.utils.getTimer;

	public class LogEntry implements ILogEntry
	{
		protected var _timeStamp:int;
		protected var _level:LogLevel;
		protected var _message:String;
		protected var _category:String;
		
		
		public function setEntry(level:LogLevel, message:String, category:String=null):void
		{
			_timeStamp = getTimer();
			_level = level;
			_message = message;
			_category = category;
		}
		
		public function get timeStamp():int { return _timeStamp; }
		
		public function get level():LogLevel { return _level; }
		
		public function get message():String { return _message; }
		
		public function get category():String { return _category; }
		
		public function clear():void
		{
			_timeStamp = 0;
			_level = null;
			_message = null;
			_category = null;
		}
		
	}
}