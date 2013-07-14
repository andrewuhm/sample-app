require 'spec_helper'

describe "User pages" do
	subject { page }

  describe "signup page" do
  	before { visit signup_path }

  	it { should have_selector('h1', text: 'Sign up') }
  	it { should have_title(full_title('Sign up')) }
  end

  describe "profile_page" do
  	let(:user) { FactoryGirl.create(:user) }
  	before { visit user_path(user) }
  	
  	it { should have_selector('h1', text: user.name) }
  	it { should have_title(user.name) }
  end

  describe "signup" do
    before { visit signup_path }
    let(:submit) { "Create my account" }

    describe "with invalid information" do
      before { click_button submit }
      it "should not create a user" do
        expect { not_to change(User, :count) }
      end

      describe "after submission" do
        it { should have_title('Sign up') }
        it { should have_content('error', text: 'Password') }
        it { should have_content('error', text: 'Password can\'t be blank') }
        it { should have_content('error', text: 'Password is too short') }
        it { should have_content('error', text: 'Email is invalid') }
      end

    end

    describe "with valid information" do
      #before do
      #  fill_in "Name",   with: "Example User"
       # fill_in "Email",  with: "user@example.com"
      #  fill_in "Password", with: "foobar"
      #  fill_in "Confirmation", with: "foobar"
      #end
      before { valid_reg }

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email('user@example.com') }

        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
        it { should have_link('Sign out') }
      end
    end
  end
end
