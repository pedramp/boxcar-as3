package org.api.boxcar
{
	/**
	 * to send a message to direct user
	 */
	public class NotifyToOne extends Notification
	{
		/**
		 *  you can use this class to sending a message to specific user.
		 * @param key  provider key
		 * @param email receiver email address
		 * @param message final message
		 * 
		 * @example just make a instance, set your optional parameters and send!
		 * <listing version="3.0">
var n:INotification = new NotifyToOne('my_provider_key', 'receiver_email_address', 'my message!');
n.fromScreenName = 'Test API';
n.sourceURL = 'http://example.com';
n.send();</listing>
		 * 
		 * @see org.api.boxcar.INotification
		 */
		
		public function NotifyToOne(key:String, email:String, message:String)
		{
			super(key);
			this.email = email;
			this.message = message;
		}
		
	}
}