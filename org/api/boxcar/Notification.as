package org.api.boxcar
{
	import com.adobe.crypto.MD5;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	/**
	 * Basic/Abstract Notification class to handle basic things  
	 */
	public class Notification extends EventDispatcher implements INotification
	{
		
		/**
		 *  This is your Provider key.
		 */
		protected var providerKey:String;
		
		
		/**
		 *  URLVariables property to sending serialized parameters to server
		 */
		protected var vars:URLVariables = new URLVariables();
		
		
		/**
		 * basic URLLoader property 
		 */
		protected var urlLoader:URLLoader = new URLLoader();
		
		
		/**
		 * basic URLRequest property 
		 */
		protected var urlRequest:URLRequest = new URLRequest();
		
		private var _secret:String;
		private var _email:String;
		private var _message:String;
		private var _fromScreenName:String;
		private var _fromRemoteServiceID:String;
		private var _sourceURL:String;
		private var _iconURL:String;
		private var _redirectPayload:String;
		
		public function Notification(key:String, secret:String = '')
		{
			providerKey = key;
			
			if(secret != '') 
				this.secret = secret;
			//
			urlRequest.data = vars;
			urlRequest.method = URLRequestMethod.POST;
			urlRequest.url = Boxcar.API_PATH.replace('{1}', providerKey);;
		}
		
		/**
		 * @inheritDoc
		 */
		public function send():void
		{
			setupEvents(urlLoader, true);
			urlLoader.load( urlRequest );
		}
		
		
		private function completeHandler(e:Event):void 
		{
			dispatchEvent(e);
			setupEvents(urlLoader);
		}
		
		private function securityErrorHandler(e:SecurityErrorEvent):void 
		{
			dispatchEvent(e);
			setupEvents(urlLoader);
		}
		
		private function httpStatusHandler(e:HTTPStatusEvent):void 
		{
			dispatchEvent(e);
			setupEvents(urlLoader);
		}
		
		private function ioErrorHandler(e:IOErrorEvent):void 
		{
			dispatchEvent(e);
			setupEvents(urlLoader);
		}
		
		/**
		 * @inheritDoc
		 */
		public function set secret(value:String):void
		{
			_secret = value;
			vars['secret'] = _secret;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set email(value:String):void
		{
			_email = md5Email(value);
			vars['email'] = _email;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set message(value:String):void
		{
			_message = value;
			vars['notification[message]'] = _message;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set fromScreenName(value:String):void
		{
			_fromScreenName = value;
			vars['notification[from_screen_name]'] = _fromScreenName;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set fromRemoteServiceID(value:String):void
		{
			_fromRemoteServiceID = value;
			vars['notification[from_remote_service_id]'] = _fromRemoteServiceID;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set sourceURL(value:String):void
		{
			_sourceURL = value;
			vars['notification[source_url]'] = _sourceURL;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set iconURL(value:String):void
		{
			_iconURL = value;
			vars['notification[icon_url]'] = _iconURL;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set redirectPayload(value:String):void
		{
			_redirectPayload = value;
			vars['notification[redirect_payload]'] = _redirectPayload;
		}
		
		public function get email():String
		{
			return _email;
		}
		
		public function get secret():String
		{
			return _secret;
		}
		
		public function get message():String
		{
			return _message;
		}
		
		public function get fromScreenName():String
		{
			return null;
		}
		
		public function get fromRemoteServiceID():String
		{
			return _fromRemoteServiceID;
		}
		
		public function get sourceURL():String
		{
			return _sourceURL;
		}
		
		public function get iconURL():String
		{
			return _iconURL;
		}
		
		public function get redirectPayload():String
		{
			return _redirectPayload;
		}
		
		private function md5Email(value:String):String
		{
			if(value.indexOf('@') == -1 && value.length == 32) return value;
			return MD5.hash( value );
		}
		
		private function setupEvents(base:IEventDispatcher, add:Boolean = false):void
		{
			if(add)
			{
				base.addEventListener(Event.COMPLETE, completeHandler);
				base.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
				base.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
				base.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			}else
			{
				base.removeEventListener(Event.COMPLETE, completeHandler);
				base.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
				base.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
				base.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			}
		}
	}
}