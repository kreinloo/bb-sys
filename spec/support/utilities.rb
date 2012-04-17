
# Helper which signs in the test user
def sign_in(user)
  visit signin_path
  fill_in "Username", :with => user.name
  fill_in "Password", :with => user.password
  click_button "Sign in"
  post sessions_path, :session => { :username => user.name,
                                   :password => user.password }
end
