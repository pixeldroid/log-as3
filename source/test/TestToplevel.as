
package
{
	import flash.display.Sprite;
	
	public class TestToplevel extends Sprite
	{
	
		public function TestToplevel()
		{
			super();
			
			fatal(this, "{0} log message (top level)", "fatal");
			error(this, "{0} log message (top level)", "error");
			warn(this, "{0} log message (top level)", "warn");
			info(this, "{0} log message (top level)", "info");
			debug(this, "{0} log message (top level)", "debug");
		}
	}
}
