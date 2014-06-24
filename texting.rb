require 'twilio-ruby'

class Text

	account_sid = 'ACe330ba04d082392df4cb3511dcb72cec'
	auth_token = '2008ea097713e401a16c54029058da82'

	@client = Twilio::REST::Client.new account_sid, auth_token

	def assign_body= (body_text)
		@body = body_text
	end

	def texting
		@client = Twilio::REST::Client.new 'ACe330ba04d082392df4cb3511dcb72cec', '2008ea097713e401a16c54029058da82'

		@client.account.messages.create(
		  :from => '+18152642023',
		  :to => '+1917434195',
		  :body => @body
		)
	end

end

my_text = Text.new
my_text.assign_body=("You are really annoying, Isaaabel Seleeeeeen")
my_text.texting