package org.api.boxcar
{
	/**
	 * to send a message to bunch of people 
	 */
	public class NotifyToMany extends Notification
	{
		/**
		 * to broadcasting and sending a message to group of users you can use this class
		 * 
		 * @param key your provider key
		 * @param secret your provider secret key
		 * @param message your message!
		 * 
		 * @example just make a instance, set your optional parameters and send!
		 * <listing version="3.0">
new NotifyToMany('my_provider_key', 'my_provider_secret', 'my message!').send();</listing>
		 * 
		 * @see org.api.boxcar.INotification
		 * 
		 */
		public function NotifyToMany(key:String, secret:String, message:String)
		{
			super(key, secret);
			this.message = message;
			urlRequest.url += '/broadcast';
		}
	}
}