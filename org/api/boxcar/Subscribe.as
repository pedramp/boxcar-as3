package org.api.boxcar
{
	/**
	 * to send subscribe message to specific user
	 */
	public class Subscribe extends Notification
	{
		/**
		 * This sends the user with the matching e-mail address a push notification which requests that they add your service. This will ease integration with your website, as you will have already registered them on your system and can identify whom they are based on their Boxcar e-mail address.
		 * 
		 * @param key your provicer key
		 * @param secret your provider secret key
		 * @param email receiver email address
		 * 
		 * @see org.api.boxcar.INotification
		 * 
		 * @example just make a instance, set your optional parameters and send!
		 * <listing version="3.0">
new Subscribe('my_provider_key', 'my_provider_secret', 'user_email_address').send();</listing>
		 */
		public function Subscribe(key:String, secret:String, email:String)
		{
			super(key, secret);
			this.email = email;
			urlRequest.url += '/subscribe';
		}
	}
}