/**
 * FramesPanelMediator.as
 *
 *
 *
 * @author   David Ford <>
 * @version  1.0.0
 */
package com.smithandrobot.kennethcole.views 
{
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class FramesPanelMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "FramesPanelMediator";
		
		/**
		 * Constructor function
		 * 
		 * @param viewComponent  Display view mediated by this class
		 * @return void
		 */
		public function FramesPanelMediator(viewComponent:Object):void 
		{
			super(NAME, viewComponent);
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
				default:
					break;
			}
		}
		
		protected function get frames() : *
		{
			return viewComponent;
		}
		
		/**
		 * List the <code>INotification</code> names this
		 * <code>Mediator</code> is interested in being notified of.
		 * 
		 * @return Array the list of <code>INotification</code> names 
		 */
		override public function listNotificationInterests():Array 
		{
			return [];
		}

	}
}