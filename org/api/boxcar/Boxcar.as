package org.api.boxcar
{
	/**
	 * Boxcar ActionScript API by Pedram Pourhossein (i[at]pedram.mp - http://pedram.mp), May 12 2011
	 * @author Pedram Pourhossein
	 */
	public class Boxcar
	{
		private var _providerKey:String;
		private var _providerSecret:String;
		
		/**
		 * Boxcar's default API address
		 */
		public static const API_PATH : String = 'http://boxcar.io/devices/providers/{1}/notifications'; 
		
		
		/**
		 * Boxcar ActionScript API is a simple way to using Boxcar notification service
		 * <br />
		 * this class has simple rule and you can use it as simple as eating a frog! :D 
		 * <br />
		 * here we have just three method to sending notification to a user OR to many user or to subscribe user.
		 * 
		 * @example however we have three simple classes that you can work with them directly., just for example if you want send a message to a user:
		 * <listing version="3.0">
var n:INotification = new NotifyToOne('my_provider_key', 'receiver_email_address', 'my message!');
n.message = 'Test API';
n.sourceURL = 'http://example.com';
n.send();</listing>
		 * <br />
		 * and you can handle all HTTP requestes by default <code>URLLoader</code> events 
		 * 
		 * @param key Provider Key
		 * @param secret Provider Secret, 
		 * 
		 * <p>
		 * SecterKey is optional when you want send a notify to direct user but for broadcasting and subscription you should fil it.  
		 * </p>
		 * 
		 * @see org.api.boxcar.Subscribe
		 * @see org.api.boxcar.NotifyToMany
		 * @see flash.net.URLLoader
		 * @see flash.events.HTTPStatusEvent
		 * @see flash.events.IEventDispatcher
		 * @see flash.events.IOErrorEvent
		 * @see flash.events.SecurityErrorEvent
		 */
		public function Boxcar(key:String, secret:String = '')
		{
			_providerKey = key;
			_providerSecret = secret;
		}
		
		/**
		 *  This is your Provider key. 
		 * @return provider key
		 * 
		 */
		public function get providerKey():String
		{
			return _providerKey;
		}
		
		/**
		 * This is your Provider secret. 
		 * @return  provider key
		 * 
		 */
		public function get providerSecret():String
		{
			return _providerSecret;
		}
		
		
		/**
		 * send a message to a specific user
		 * @param email receiver email address
		 * @param message The message to display to the user. This message should be at a maximum somewhere around 140 characters in length. Longer messages will be truncated depending on the client receiving it. This is a required field.  
		 * @return <code>INotification</code> is your request instance 
		 * @see org.api.boxcar.INotification
		 * @see org.api.boxcar.NotifyToOne
		 * 
		 * @example you can send 
		 * <listing version="3.0">
// setting my provider key
var box:Boxcar = new Boxcar('fKJ9a8x9Q8QXSwzADwhy');
box.notify('receiver_email_address', 'Hello!').send();</listing>
		 * 
		 * @example also you can config other optioal keys like <code>fromScreenName</code>, <code>iconURL</code> or...
		 * <listing version="3.0">
// setting my provider key
var box:Boxcar = new Boxcar('fKJ9a8x9Q8QXSwzADwhy');
var notify:INotification = box.notify('i[at]pedram.mp', 'Hello!');
notify.iconURL = 'http://example.com/57x57.png';
notify.fromScreenName = 'Sample!';
notify.send();

// adding event to getting http-status
notify.addEventListener(HTTPStatusEvent.HTTP_STATUS, onEvent);
function onEvent(e:HTTPStatusEvent):void
{
	trace(e.status);
}</listing>
		 * 
		 */
		public function notify(email:String, message:String):INotification
		{
			return new NotifyToOne(providerKey, email, message);
		}
		
		/**
		 *This sends the user with the matching e-mail address a push notification which requests that they add your service. This will ease integration with your website, as you will have already registered them on your system and can identify whom they are based on their Boxcar e-mail address.
		 *  
		 * @param email The Boxcar users e-mail address
		 * @return <code>INotification</code> is your request instance 
		 * @see org.api.boxcar.INotification
		 * @see org.api.boxcar.Subscribe
		 * 
		 * @example you can send 
		 * <listing version="3.0">
// setting my provider key
var box:Boxcar = new Boxcar('fKJ9a8x9Q8QXSwzADwhy', '9k2lcHom55WwMa7qQzoErftR7fBGpLyLuvrp1LtG');
box.subscribe('i[at]pedram.mp').send();</listing>		 
		 */
		public function subscribe(email:String):INotification
		{
			return new Subscribe(providerKey, providerSecret, email);
		}
		
		/**
		 * @param message The message to display to the user. This message should be at a maximum somewhere around 140 characters in length. Longer messages will be truncated depending on the client receiving it.
		 * @return   <code>INotification</code> is your request instance 
		 * 
		 * @see org.api.boxcar.INotification
		 * @see org.api.boxcar.NotifyToMany
		 * 
		 */
		public function broadcast(message:String):INotification
		{
			return new NotifyToMany(providerKey, providerSecret, message);
		}
	}
}