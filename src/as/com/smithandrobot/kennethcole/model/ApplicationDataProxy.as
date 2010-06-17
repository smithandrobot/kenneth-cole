package com.smithandrobot.kennethcole.model
{
    import com.smithandrobot.kennethcole.ApplicationFacade;

    import org.puremvc.as3.interfaces.IProxy;
    import org.puremvc.as3.patterns.proxy.Proxy;
	
	
    public class ApplicationDataProxy extends Proxy implements IProxy
    {
        public static const NAME:String = "ApplicationDataProxy";
		
        public function ApplicationDataProxy( )
        {
            super( NAME, new Object() );
			onModelReady();
        }
		
		private function onModelReady():void
		{
			trace("sending note from model")
			sendNotification( ApplicationFacade.INITIALIZE_SITE );
		}
    }
}