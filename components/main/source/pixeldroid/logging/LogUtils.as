
package pixeldroid.logging
{
	import flash.system.Capabilities;


	public class LogUtils
	{

		public static function expandString(template:String, args:Array):String
		{
			var tmp:String, msg:String = template;
			var i:uint = 0;
			const n:uint = args.length;
			while (i < n)
			{
				tmp = msg.replace(new RegExp("\\{" + i + "\\}", 'g'), args[i]);
				if (tmp == msg)
					break; // short-circuit if no more matches

				msg = tmp;
				i++;
			}

			return msg;
		}

		public static function formatString(pattern:String, logEntry:ILogEntry):String
		{
			// http://logback.qos.ch/manual/layouts.html#conversionWord
			// http://en.wikipedia.org/wiki/ISO_8601#Dates
			/*
			%level{} - log level
			%date{Y:M:D:h:m:s.S} - configurable date stamp
			%elapsed{padding} - time elapsed since app start, in ms
			%class{} - class from which log request originated
			%message{} - log message
			*/
			if (pattern.length == 0)
				return logEntry.message;

			var token:String, peek:String, command:String, params:String, string:String = "";
			var i:uint = 0;
			var seeking:Boolean;
			const n:uint = pattern.length;
			while (i < n)
			{
				token = pattern.charAt(i);

				// handle conversion word sequences: %word{params}
				if (token == "%")
				{
					// read command until {
					command = "";
					seeking = true;
					while (i + 1 < n && seeking)
					{
						peek = pattern.charAt(i + 1);
						if (peek == "{")
							seeking = false;
						else
							command += peek;
						i++;
					}
					// read params until }
					params = "";
					seeking = true;
					while (i + 1 < n && seeking)
					{
						peek = pattern.charAt(i + 1);
						if (peek == "}")
							seeking = false;
						else
							params += peek;
						i++;
					}
					// convert command and params into token
					token = getConversion(command, params, logEntry);
				}

				// append current token to string
				string += token;
				i++;
			}
			return string;
		}

		public static function pad(string:String, places:int, char:String = ' ', prepend:Boolean = true):String
		{
			if (prepend)
			{
				while (string.length < places)
					string = char + string;
			}
			else
			{
				while (string.length < places)
					string = string + char;
			}

			return string;
		}

		public static function passesFilter(category:String, filters:Vector.<String>):Boolean
		{
			// TODO: test against filters
			return true;
		}

		public static function get stackTrace():String
		{
			var stackTrace:String = "stack trace unavailable";

			if (Capabilities.isDebugger)
			{
				try
				{
					throw new Error("");
				}
				catch (e:Error)
				{
					var debuggerData:RegExp = /\[.*?\]/msgi;
					var errorTitle:RegExp = /^Error.*?at\s/msi;

					stackTrace = e.getStackTrace().replace(debuggerData, "").replace(errorTitle, "current method stack:\n\t");
				}
			}

			return stackTrace;
		}

		private static function getConversion(command:String, params:String, logEntry:ILogEntry):String
		{
			var string:String = "";

			switch (command)
			{
				case "level":
					string = pad(logEntry.level.toString(), 5, " ", false);
					break;

				case "date":
					const d:Date = new Date(logEntry.timeStamp);
					const n:uint = params.length;
					var i:uint = 0;
					var token:String;
					while (i < n)
					{
						token = params.charAt(i);
						switch (token)
						{
							case "Y":
								token = d.fullYear.toString();
								break;
							case "M":
								token = pad(d.month.toString(), 2, "0");
								break;
							case "D":
								token = pad(d.date.toString(), 2, "0");
								break;
							case "h":
								token = pad(d.hours.toString(), 2, "0");
								break;
							case "m":
								token = pad(d.minutes.toString(), 2, "0");
								break;
							case "s":
								token = pad(d.seconds.toString(), 2, "0");
								break;
							case "S":
								token = pad(d.milliseconds.toString(), 3, "0");
								break;
						}
						string += token;
						i++;
					}
					break;

				case "elapsed":
					const places:uint = parseInt(params) || 8;
					string = pad(logEntry.elapsed.toString(), places, "0");
					break;

				case "class":
					string = logEntry.category;
					break;

				case "message":
					string = logEntry.message;
					break;
			}

			return string;
		}
	}
}

