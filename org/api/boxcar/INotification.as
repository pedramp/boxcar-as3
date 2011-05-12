package org.api.boxcar
{
	import flash.events.IEventDispatcher;
	
	/**
	 * Interface of all requestes  
	 */
	public interface INotification extends IEventDispatcher
	{
		/**
		 * The Boxcar users e-mail address 
		 * @param value
		 * 
		 */
		function set email(value:String):void;
		
		
		/**
		 * The message to display to the user. This message should be at a maximum somewhere around 140 characters in length. Longer messages will be truncated depending on the client receiving it.
		 * @param value
		 * 
		 */
		function set message(value:String):void;
		
		
		/**
		 * The user or application sending the notification. This is matched for the redirect performed by Boxcar (if set by the user). 
		 * @param value
		 * 
		 */
		function set fromScreenName(value:String):void;
		
		
		/**
		 *  An integer value that will uniquely identify the notification, and prevent duplicate notifications about the same event from being created. This is an optional field, but it is strongly recommended that you use it.
		 * @param value
		 * 
		 */
		function set fromRemoteServiceID(value:String):void;
		
		
		/**
		 * Optional; This is a URL that may be used for future devices. It will replace the redirect payload.
		 * @param value
		 * 
		 */
		function set sourceURL(value:String):void;
		
		
		/**
		 * Optional; This is the URL of the icon that will be shown to the user. Standard size is 57x57.
		 * @param value
		 * 
		 */
		function set iconURL(value:String):void;
		
		
		/**
		 * Optional; The payload to be passed in as part of the redirection URL. Keep this as short as possible. If your redirection URL contains "::user::" in it, this will replace it in the URL. An example payload would be the users username, to take them to the appropriate page when redirecting.
		 * @param value
		 * 
		 */
		function set redirectPayload(value:String):void;
		
		function get email():String;
		function get message():String;
		function get fromScreenName():String;
		function get fromRemoteServiceID():String;
		function get sourceURL():String;
		function get iconURL():String;
		function get redirectPayload():String;
		
		/**
		 * start to sending request to Boxcar server
		 */
		function send():void;
	}
}