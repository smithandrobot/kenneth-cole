/**
 * CanvasMeadiator.as
 *
 *
 *
 * @author   David Ford <>
 * @version  1.0.0
 */
package com.smithandrobot.kennethcole.views 
{
	import flash.events.Event;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import com.smithandrobot.kennethcole.ApplicationFacade;
	import com.smithandrobot.kennethcole.views.*;
	import com.smithandrobot.kennethcole.views.uicomponents.*;
	
	public class CanvasMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "CanvasMediator";
		
		/**
		 * Constructor function
		 * 
		 * @param viewComponent  Display view mediated by this class
		 * @return void
		 */
		public function CanvasMediator(viewComponent:Object):void 
		{
			super(NAME, viewComponent);
			canvas.addEventListener("onObjectAddedToCanvas", onObjectAdded);
		}

		/**
		 * Handle <code>INotification</code>s.
		 * 
		 * Typically this will be handled in a switch statement,
		 * with one 'case' entry per <code>INotification</code>
		 * the <code>Mediator</code> is interested in.
		 * 
		 * @param notiication  Notification object
		 * @return void
		 */ 
		override public function handleNotification(notification:INotification):void 
		{
			switch (notification.getName())
			{
				case ApplicationFacade.STAGE_CLICKED : 
					handleStageClick(notification.getBody());
					break;
				
				default:
					break;
			}
		}
		
		/**
		 * List the <code>INotification</code> names this
		 * <code>Mediator</code> is interested in being notified of.
		 * 
		 * @return Array the list of <code>INotification</code> names 
		 */
		override public function listNotificationInterests():Array 
		{
			return [ ApplicationFacade.STAGE_CLICKED ];
		}

		private function onObjectAdded(e:Event)
		{
			var count = canvas.objectCount;
			sendNotification(ApplicationFacade.CANVAS_OBJECT_ADDED, count);
		}
		
		
		protected function get canvas() : Canvas
		{
			return viewComponent as Canvas;
		}
		
		protected function handleStageClick(obj)
		{
			var bkg = canvas.getChildByName("bkg");
			var clickOnCanvas = bkg.hitTestPoint(obj.x, obj.y);
			if(!clickOnCanvas) canvas.hideTransformTool();
		}
		
		

	}
}