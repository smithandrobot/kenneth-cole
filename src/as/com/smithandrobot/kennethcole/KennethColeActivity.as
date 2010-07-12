package com.smithandrobot.kennethcole 
{
	import flash.events.Event;
	import flash.display.Sprite;
	import com.smithandrobot.kennethcole.ApplicationFacade;
	
	public class KennethColeActivity extends Sprite 
	{
		
		private var facade:ApplicationFacade;
		
		public function KennethColeActivity()
		{
			super();
			setUpUI();
			facade = ApplicationFacade.getInstance();
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event) : void
		{
			facade.startup( this );
		}
		
		private function setUpUI()
		{
			var i = 0;
			var total = numChildren-1;
			for(i; i<= total; i++)
			{
				var c = getChildAt(i)
				if(c.hasOwnProperty("alpha") && c.name != "ad") c.alpha = 0;
			}
		}
		
	}

}

