require 'twilio-ruby'

class Text

	account_sid = 'ACe330ba04d082392df4cb3511dcb72cec'
	auth_token = '2008ea097713e401a16c54029058da82'

	@client = Twilio::REST::Client.new account_sid, auth_token

	def assign_body= (body_text)
		@body = body_text
	end

	def assign_recipient= (recipient)
		@recipient = recipient
	end

	def text_chiara
		@client = Twilio::REST::Client.new 'ACe330ba04d082392df4cb3511dcb72cec', '2008ea097713e401a16c54029058da82'

		@client.account.messages.create(
		  :from => '+18152642023',
		  :to => '+19174341595',
		  :body => @body
		)
	end

	def texting(recipient = @recipient)
		@client = Twilio::REST::Client.new 'ACe330ba04d082392df4cb3511dcb72cec', '2008ea097713e401a16c54029058da82'

		@client.account.messages.create(
		  :from => '+18152642023',
		  :to => recipient,
		  :body => @body
		)
	end
end