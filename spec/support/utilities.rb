include ApplicationHelper

def valid_signin(user)
	fill_in "Email", 		with: user.email
	fill_in "Password", 	with: user.password
	click_button "Sign in"
	# Sign in when not using Capybara as well.
	cookies[:remember_token] = user.remember_token
end

def sign_in(user, options={})
	if options[:no_capybara]
		# Sign in when not using Capybara.
		remember_token = User.new_remember_token
		cookies[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.encrypt(remember_token))
	else
		visit signin_path
		fill_in "Email", 		with: user.email
		fill_in "Password", 	with: user.password
		click_button "Sign in"
		# Sign in when not using Capybara as well.
	end
end

def valid_reg
	fill_in "Name", 		with: "Example User"
	fill_in "Email", 	with: "user@example.com"
	fill_in "Password", 	with: "foobar"
    fill_in "Confirm Password", with: "foobar"
end

RSpec::Matchers.define :have_error_message do |message|
	match do |page|
		page.should have_selector('div.alert.alert-error', text: message)
	end
end
