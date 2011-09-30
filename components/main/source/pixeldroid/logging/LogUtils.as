
package pixeldroid.logging
{
	import flash.system.Capabilities;
	import flash.utils.getTimer;
	
	public class LogUtils
	{
		
		static public function expandString(template:String, args:Array):String
		{
			var tmp:String, msg:String = template;
			var i:uint = 0, n:uint = args.length;
			
			while (i < n)
			{
				tmp = msg.replace(new RegExp("\\{"+i+"\\}", 'g'), args[i]);
				if (tmp == msg) break; // short-circuit if no more matches
				
				msg = tmp;
				i++;
			}
			
			return msg;
		}
		
		static public function passesFilter(category:String, filter:String):Boolean
		{
			return true;
		}
		
		static public function formatString(template:String, logEntry:ILogEntry):String
		{
			return logEntry.message;
		}
		
		static public function get stackTrace():String
		{
			var stackTrace:String = "stack trace unavailable";
			 
			if (Capabilities.isDebugger)
			{
				try { throw new Error(""); }
				catch (e:Error)
				{ 
					var debuggerData:RegExp = /\[.*?\]/msgi;
					var errorTitle:RegExp = /^Error.*?at\s/msi;
					
					stackTrace = e.getStackTrace().replace(debuggerData,"").replace(errorTitle,"current method stack:\n\t");
				}
			}
			
			return stackTrace;
		}
		
		static public function pad(string:String, places:int, char:String=' ', prepend:Boolean=true):String
		{
			if (prepend) while (string.length < places) string = char +string;
			else while (string.length < places) string = string +char;

			return string;
		}
		
	}
}

