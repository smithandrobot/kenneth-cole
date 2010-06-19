package com.smithandrobot.kennethcole.views 
{
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class ObjectPaletteMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "ObjectPaletteMediator";
		
		/**
		 * Constructor function
		 * 
		 * @param viewComponent  Display view mediated by this class
		 * @return void
		 */
		public function ObjectPaletteMediator(viewComponent:Object):void 
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

		/**
		 * Called when mediator is registered with the facade
		 *
		 * @return void
		 */
		override public function onRegister():void
		{
		}

	}
}