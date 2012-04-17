FactoryGirl.define do

  factory :user do
    name      "testUser"
    email     "mail@example.org"
    password  "very_good_password"
    password_confirmation "very_good_password"
  end

end
