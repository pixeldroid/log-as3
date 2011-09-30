
package pixeldroid.logging.appenders.console
{

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.AntiAliasType;
	import flash.text.GridFitType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.Keyboard;
	
	import pixeldroid.logging.ILogAppender;
	import pixeldroid.logging.ILogEntry;
	import pixeldroid.logging.LogUtils;
	import pixeldroid.logging.appenders.console.ConsoleAppenderProperties;
	
	/**
	Implements a simple on-screen display for viewing run-time text messages.
	
	<p>
	New messages accumulate at the bottom of the console, 
	old messages roll off the top.
	</p>
	
	<p>
	The console can be hidden, shown, paused, resumed, and cleared. Text in the console is selectable 
	so it can be copied to the clipboard. Text in the console may be saved to file via the context menu.
	</p>
	
	<p>
	The buffer size is also configurable. As the buffer fills up, oldest lines are discarded first. 
	</p>
	
	<p>
	The console is scrollable by dragging a selection inside it with the cursor, 
	or clicking to give it focus and using the arrow keys, but does not provide a scrollbar.
	</p>
	
	<p>
	This class embeds a distributable font named "ProggyTiny.ttf",
	Copyright 2004 by Tristan Grimmer.
	</p>
	
	@see http://proggyfonts.com/index.php?menu=download
	
	@example The following code shows a simple console instantiation; 
	see the constructor documentation for more options:
<listing version="3.0" >
package {
   import com.pixeldroid.logging.appenders.console.ConsoleAppender;
   import flash.display.Sprite;

   public class MyConsoleExample extends Sprite {
	  public var console:ConsoleAppender = new ConsoleAppender();
	  public function MyConsoleExample() {
		 super();
		 addChild(console);
		 info("Hello World");
	  }
   }
}
</listing>
	*/
	public class ConsoleAppender extends Sprite implements ILogAppender
	{
		
		[Embed(mimeType="application/x-font", source="ProggyTiny.ttf", fontName="FONT_CONSOLE", embedAsCFF="false")]
		protected static var FONT_CONSOLE:Class;
		
		protected var background:Shape;
		protected var console:TextField;
		protected var properties:ConsoleAppenderProperties;
		protected var loggingPaused:Boolean;
		protected var bufferMax:int;
	
		/**
		* Create a new Console with optional parameters.
		* 
		* @param properties Optional instance of ConsoleAppenderProperties for custom settings
		*
		* @see com.pixeldroid.logging.appender.console.ConsoleAppenderProperties
		*/
		public function ConsoleAppender(properties:ConsoleAppenderProperties=null)
		{
			super();
			
			this.properties = (properties == null) ? new ConsoleAppenderProperties() : properties;
			loggingPaused = true;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		
		// ILogAppender
		
		/**
		* Append a message to the bottom of the console, scrolling older content up.
		*
		* @param logEntry Entry to log
		*/
		public function append(logEntry:ILogEntry):void
		{
			consoleAppend(LogUtils.formatString("", logEntry));
		}

		
		/**
		* Retrieve human readable instructions for manipulating the console.
		*/
		public function get usage():String
		{
			var s:String = "";
			s += "Console Usage :\n";
			s += "  tick (`) toggles hide\n";
			s += "  ctrl-tick toggles pause\n";
			s += "  ctrl-bkspc clears";
			return s;
		}
	
	
		/**
		* Clear all messages from the console.
		*/
		public function clear():void
		{
			console.replaceText(0, console.length, "");
		}
	
	
		/**
		* Pause the console. Messages received while paused are ignored.
		*/
		public function pause():void
		{
			consoleAppend("<PAUSE>");
			loggingPaused = true;
		}
	
	
		/**
		* Resume the console.
		*/
		public function resume():void
		{
			loggingPaused = false;
			consoleAppend("<RESUME>");
		}
	
	
		/**
		* Hide the console. Messages are still received.
		*/
		public function hide():void
		{
			visible = false;
		}
	
	
		/**
		* Show the console.
		*/
		public function show():void
		{
			visible = true;
		}

		
		protected function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		
			background = new Shape();
			background.graphics.beginFill(properties.backColor, properties.backAlpha);
			background.graphics.drawRect(0, 0, properties.width, properties.height);
			background.graphics.endFill();
			addChild(background);

			var format:TextFormat = new TextFormat();
			format.font = "FONT_CONSOLE";
			format.color = properties.foreColor;
			format.size = properties.fontSize;
			format.align = TextFormatAlign.LEFT;
			format.leading = properties.leading;
			
			console = new TextField();
			console.antiAliasType = (format.size > 24) ? AntiAliasType.NORMAL : AntiAliasType.ADVANCED;
			console.gridFitType = GridFitType.PIXEL;
			console.embedFonts = true;
			console.defaultTextFormat = format;
			console.multiline = true;
			console.selectable = true;
			console.wordWrap = true;
			addChild(console);
			
			console.width = properties.width;
			console.height = properties.height;
			
			bufferMax = properties.bufferSize;
			
			loggingPaused = false;
			
			consoleAppend("");
			consoleAppend(usage);
			consoleAppend("");
		}
		
		/**
		 * Do the actual work of adding text to the end of the textfield and 
		 * keeping scrolled to the bottom 
		 * */
		protected function consoleAppend(message:String):void
		{
			if (loggingPaused == false)
			{
				console.appendText(message +"\n");
				var overage:int = console.numLines - bufferMax;
				if (overage > 0) console.replaceText(0, console.getLineOffset(overage), "");
				console.scrollV = console.maxScrollV;
			}
		}
		
		/**
		* Override to change keyboard shortcuts.
		* By default:
		* <ul>
		* <li>tick (`) toggles hide</li>
		* <li>ctrl-tick toggles pause</li>
		* <li>ctrl-bkspc clears</li>
		* </ul>
		*
		* <p>
		* If you overide this method, consider overriding the usage getter as well.
		* </p>
		*/
		protected function keyDownHandler(e:KeyboardEvent):void
		{
			if ("`" == String.fromCharCode(e.charCode))
			{
				if (e.ctrlKey == true) toggleLog();
				else                   toggleVis();
			}
			else if ((e.keyCode == Keyboard.BACKSPACE) && (e.ctrlKey == true)) clear();
		}
		
		protected function toggleLog():void { (loggingPaused == true) ? resume() : pause(); }
		
		protected function toggleVis():void { (visible == false) ? show() : hide(); }
		
	}

}
