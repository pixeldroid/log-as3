
package pixeldroid.logging
{
	import flash.utils.getTimer;


	public class LogEntry implements ILogEntry
	{
		protected var _elapsed:int;
		protected var _timeStamp:Number;
		protected var _level:LogLevel;
		protected var _message:String;
		protected var _category:String;

		public function get category():String  { return _category; }

		public function clear():void
		{
			_elapsed = 0;
			_timeStamp = 0;
			_level = null;
			_message = null;
			_category = null;
		}

		public function get elapsed():int  { return _elapsed; }

		public function get level():LogLevel  { return _level; }

		public function get message():String  { return _message; }


		public function setEntry(level:LogLevel, message:String, category:String = null):void
		{
			_elapsed = getTimer();
			_timeStamp = new Date().time;
			_level = level;
			_message = message;
			_category = category;
		}

		public function get timeStamp():Number  { return _timeStamp; }
	}
}
