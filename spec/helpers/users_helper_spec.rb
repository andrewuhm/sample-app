require 'spec_helper'

describe UsersHelper do
	describe "gravatar_url" do
		let(:user) { FactoryGirl.create(:user) }

		it "should include default size" do
			gravatar_for(user) =~ /s=50/
		end

		it "should reflect given size" do
			gravatar_for(user, options = { size: 40 }) =~ /s=40/
		end
	end

end

