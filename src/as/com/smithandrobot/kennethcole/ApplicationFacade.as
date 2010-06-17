package com.smithandrobot.kennethcole
{
	import flash.display.Sprite;
    import org.puremvc.as3.interfaces.IFacade;
    import org.puremvc.as3.patterns.facade.Facade;
	
	import com.smithandrobot.kennethcole.controller.StartupCommand;
	
	public class ApplicationFacade extends Facade implements IFacade
	{

        public static const STARTUP:String  			= "startup";
        public static const INITIALIZE_SITE:String  	= "initializeApplication";

        public static function getInstance() : ApplicationFacade 
        {
            if ( instance == null ) instance = new ApplicationFacade();
            return instance as ApplicationFacade;
        }

	
        public function startup( scope:Sprite ):void
        {
        	sendNotification( STARTUP, scope );
        }
		
        override protected function initializeController() : void 
        {
            super.initializeController(); 
            registerCommand( STARTUP, StartupCommand );
        };

	}

}