include ApplicationHelper

def valid_signin(user)
	fill_in "Email", 		with: user.email
	fill_in "Password", 	with: user.password
	click_button "Sign in"
	# Sign in when not using Capybara as well.
	cookies[:remember_token] = user.remember_token
end

def sign_in(user)
	cookies[:remember_token] = user.remember_token
	self.current_user = user
end

def current_user=(user)
	@current_user = user
end


	def current_user
		@current_user ||= User.find_by_remember_token(cookies[:remember_token])
	end

=begin
	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end
=end


def valid_reg
	fill_in "Name", 		with: "Example User"
	fill_in "Email", 	with: "user@example.com"
	fill_in "Password", 	with: "foobar"
    fill_in "Confirmation", with: "foobar"
end

RSpec::Matchers.define :have_error_message do |message|
	match do |page|
		page.should have_selector('div.alert.alert-error', text: message)
	end
end
