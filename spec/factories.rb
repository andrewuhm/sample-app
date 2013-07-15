FactoryGirl.define do
	factory :user do
		#name		"Andrew Uhm"
		#email		"andrewuhm1@gmail.com"
		sequence(:name)		{ |n| "Person #{n}" }
		sequence(:email)	{ |n| "person_#{n}@example.com" }
		password	"foobar1"
		password_confirmation "foobar1"

		factory :admin do
			admin true
		end
	end
end
