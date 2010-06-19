package com.smithandrobot.kennethcole.views 
{
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	import flash.events.Event;
	
	import com.smithandrobot.kennethcole.ApplicationFacade;
	import com.smithandrobot.kennethcole.views.uicomponents.PrintBtn;
	
	public class PrintMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "PrintMediator";
		
		/**
		 * Constructor function
		 * 
		 * @param viewComponent  Display view mediated by this class
		 * @return void
		 */
		public function PrintMediator(viewComponent:Object):void 
		{
			super(NAME, viewComponent);
			printBtn.addEventListener("onPrint", onPrintBtnClicked)
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
				case ApplicationFacade.CANVAS_OBJECT_ADDED:
					handleCanvasChange(notification.getBody());
					break;
				case ApplicationFacade.CANVAS_OBJECT_REMOVED:
					handleCanvasChange(notification.getBody());
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
			return [
			ApplicationFacade.CANVAS_OBJECT_ADDED
			];
		}
		
		private function onPrintBtnClicked(e:Event)
		{
			
		}
		
		protected function get printBtn() : PrintBtn
		{
			return viewComponent as PrintBtn;
		}
		
		private function handleCanvasChange(c:Object) : void
		{
			trace("canvas object changed count"+c);
			if(c > 0) printBtn.enabled = true;
			if(c <= 0) printBtn.enabled = false;
		}

	}
}