

package com.smithandrobot.utils {

/**
 *	Class description.
 *
 *	@langversion ActionScript 3.0
 *	@playerversion Flash 9.0
 *	@author David Ford
 *	@since  13.04.2009
 */
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.*
	import com.smithandrobot.utils.PathFinder;
	import com.smithandrobot.utils.Base64Encoder;
	
	import com.smithandrobot.events.XMLLoaderEvent;
	
	public class XMLLoader extends EventDispatcher 
	{

		//--------------------------------------
		//  PRIVATE VARIABLES
		//--------------------------------------
		
		private var _file : String;
		private var _loader : URLLoader;
		
		public function XMLLoader(){}

		
		//--------------------------------------
		//  GETTER/SETTERS
		//--------------------------------------
		
		public function set file(f:String) : void
		{
			_file = f;
			_loader = new URLLoader();
			_loader.addEventListener(Event.COMPLETE, xmlComplete);
			_loader.addEventListener(IOErrorEvent.IO_ERROR , onIOError);
			_loader.addEventListener(ProgressEvent.PROGRESS, progress);
			_loader.load(new URLRequest(f));
		}

		
		private function xmlComplete(e:Event)
		{
			_loader.removeEventListener(Event.COMPLETE, xmlComplete);
			var xml = new XML(e.target.data);
			dispatchEvent(new XMLLoaderEvent(XMLLoaderEvent.XML_LOADED, xml));
		}


		private function progress(e:ProgressEvent)
		{
			/*trace(e.bytesLoaded);
			trace(e.bytesTotal);*/
		}
		
		private function onIOError(e:IOErrorEvent) : void
		{
			trace("error in xml loader");
			dispatchEvent(new Event("couldNotFindFile"));
		}
		
		private function loadWithAuthentication(f)
		{
			_loader = new URLLoader();
			var _queryRequest:URLRequest = new URLRequest();
			_queryRequest.url = f;
			
			// POST is required for HTTP Auth headers to be passed
			_queryRequest.method = "POST"; 
			
			// Some type of POST data must be present for POST to happen in the first place
			_queryRequest.data = "dummy_data=needed_for_post_to_work"; 
			
			var encoder:Base64Encoder = new Base64Encoder();
			encoder.encode("jeep:tr1pc4st");
			
			var authString = "Basic " + encoder.toString();
			var _queryAuthorizationHeader:URLRequestHeader = new URLRequestHeader("Authorization", authString);
			_queryRequest.requestHeaders.push(_queryAuthorizationHeader);
			var _queryTypeHeader = new URLRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			_queryRequest.requestHeaders.push(_queryTypeHeader);
			_loader.load(_queryRequest);
			_loader.addEventListener(Event.COMPLETE, xmlComplete);
			_loader.addEventListener(IOErrorEvent.IO_ERROR , onIOError);
			_loader.addEventListener(ProgressEvent.PROGRESS, progress);
			
		}
	}

}

