require 'twilio-ruby'

class Text

	account_sid = 'ENV[TWILIO-ACCOUNT]'
	auth_token = 'ENV[TWILIO-AUTH]'

	@client = Twilio::REST::Client.new account_sid, auth_token

	def assign_body= (body_text)
		@body = body_text
	end

	def assign_recipient= (recipient)
		@recipient = recipient
	end

	def text_chiara
		@client = Twilio::REST::Client.new 'ENV[TWILIO-ACCOUNT]', 'ENV[TWILIO-AUTH]'

		@client.account.messages.create(
		  :from => 'ENV[TWILIO-NUMBER]',
		  :to => 'ENV[PERMANENT-NUMBER]',
		  :body => @body
		)
	end

	def texting(recipient = @recipient)
		@client = Twilio::REST::Client.new 'ENV[TWILIO-ACCOUNT]', 'ENV[TWILIO-AUTH]'

		@client.account.messages.create(
		  :from => 'ENV[TWILIO-NUMBER]',
		  :to => recipient,
		  :body => @body
		)
	end
end