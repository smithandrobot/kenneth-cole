

package com.smithandrobot.kennethcole.views 
{

/**
 *	Class description.
 *
 *	@langversion ActionScript 3.0
 *	@playerversion Flash 9.0
 *	@author David Ford
 *	@since  28.07.2009
 */
    import flash.display.Stage;
    import flash.display.Sprite;
    import flash.events.Event;
	
	// import com.greensock.TweenMax;
	
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.mediator.Mediator;

	import com.smithandrobot.kennethcole.ApplicationFacade;
	import com.smithandrobot.kennethcole.views.*;
	import com.smithandrobot.kennethcole.views.uicomponents.*;
	
	public class StageMediator extends Mediator implements IMediator
	{


        public static const NAME:String 	= "StageMediator";
		private var _scope 					: Sprite;
		
		public function StageMediator( sprite )
		{
            super( NAME, sprite );
			//addEventListener("selectBlankBKG", )
			stage.addEventListener("onUIAnimatedIn", onStageIn)
		}

		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		
        override public function listNotificationInterests():Array 
        {
            return [ 
            		ApplicationFacade.INITIALIZE_SITE
                   ];
        }


        override public function handleNotification( note:INotification ):void 
        {
            switch ( note.getName() ) 
            {
                case ApplicationFacade.INITIALIZE_SITE:     	
					initializeSite();
                  	break;
                default:
                  	break;
            }
        }


		//--------------------------------------
		//  GETTER/SETTERS
		//--------------------------------------
		
		/**
		 * Retrieves the viewComponent and casting it to type Sprite
		 */
        protected function get stage():Sprite
        {
            return viewComponent as Sprite;
        }
		
		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		
		
		
		//--------------------------------------
		//  PRIVATE & PROTECTED INSTANCE METHODS
		//--------------------------------------
		
		
        private function initializeSite():void
        {
			trace("site start up scope: "+stage);
			var u = new UIBuildAnimation(stage);
			u.start();
			/*facade.registerMediator( mapMediator );*/
        }


		private function onStageIn(e:Event)
		{
			
		}

	}

}

