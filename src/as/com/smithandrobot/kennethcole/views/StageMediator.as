

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
    import flash.events.*;

	import com.greensock.TweenNano;
	
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.mediator.Mediator;

	import com.smithandrobot.kennethcole.ApplicationFacade;
	import com.smithandrobot.kennethcole.views.*;
	import com.smithandrobot.kennethcole.views.uicomponents.*;
	
	public class StageMediator extends Mediator implements IMediator
	{


        public static const NAME:String 	= "StageMediator";
		private var _scope 					: Sprite;
		private var _loader					: UILoaders;
		private var _objectsFile			: String;
		private var _framesFile				: String;
		
		public function StageMediator( sprite )
		{
            super( NAME, sprite );
			var tile = stage.addChildAt(new BKGTile(stage.stage.stageWidth, stage.stage.stageHeight), 0);
			_loader = new UILoaders();
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onStageClick);
			stage.addEventListener(KeyboardEvent.KEY_UP,keyUpListener);
		}

		
		private function keyUpListener(e)
		{
			trace("stge heard jey")
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
					initializeSite(note.getBody());
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
		
		
        private function initializeSite(o:Object):void
        {
			_objectsFile = o.getFile("objectPalette");
			_framesFile	= o.getFile("framePalette");
			
			var u = new UIBuildAnimation(stage);
			u.addEventListener("onUIAnimatedIn", onStageIn, false, 0, true)
			u.start();
			
			//canvas
			var canvas = stage.getChildByName("canvas");
			var cm		= new CanvasMediator( canvas );
			facade.registerMediator( cm );
			
			// printing
			var pSprite = stage.getChildByName("printBtn");
			var pController = new PrintBtn(pSprite)
			var p = new PrintMediator(pController);
			facade.registerMediator( p );
        }


		private function onStageIn(e:Event)
		{
			_loader.addEventListener("onObjectsPaletteLoaded", onObjectsPaletteLoaded);
			_loader.addEventListener("onFramesLoaded", onFramesLoaded);
			_loader.loadFrames(stage, _framesFile);
			_loader.loadObjects(stage, _objectsFile);
		}
		
		
		private function onObjectsPaletteLoaded(e:Event) : void
		{
			var canvas = stage.getChildByName("canvas");
			var palette = e.target.objectPalette;
			palette.x = 724;
			palette.y = 119;
			palette.canvas = canvas;
			stage.addChild(palette);
			var om = new ObjectPaletteMediator(palette);
			bringCanvasToTop();
		}
		
		
		private function onFramesLoaded(e:Event) : void
		{
			var canvas = stage.getChildByName("canvas");
			var frames = e.target.framesPanel;
			frames.x = 9;
			frames.y = 304;
			frames.canvas = canvas;
			stage.addChild(frames);
			var fm = new FramesPanelMediator(frames);
			bringCanvasToTop();
		}
		
		private function bringCanvasToTop()
		{
			var canvas = stage.getChildByName("canvas");
			var p	   = stage.getChildByName("printBtn")
			stage.setChildIndex(canvas, stage.numChildren-1);
			stage.setChildIndex(p, stage.numChildren-1);
		}
		
		private function onStageClick(e:MouseEvent) : void
		{
			trace("stage clicked");
			sendNotification(ApplicationFacade.STAGE_CLICKED, {x:e.stageX,y:e.stageY});
		}

	}

}

