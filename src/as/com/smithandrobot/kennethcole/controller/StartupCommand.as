package com.smithandrobot.kennethcole.controller
{
    import flash.display.Sprite;
    import org.puremvc.as3.interfaces.ICommand;
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;
    
    import com.smithandrobot.kennethcole.ApplicationFacade;
	import com.smithandrobot.kennethcole.model.ApplicationDataProxy;
	import com.smithandrobot.kennethcole.views.StageMediator;
	
    public class StartupCommand extends SimpleCommand implements ICommand
    {
        override public function execute( note:INotification ) : void    
        {
	    	var scope:Sprite = note.getBody() as Sprite;
            facade.registerMediator( new StageMediator( scope ) );
			facade.registerProxy( new ApplicationDataProxy() );
        }
    }
}