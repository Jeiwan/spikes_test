module FeatureMacros
  def sign_in *args
    if args.size == 2
      username = args[0]
      password = args[1]
    else
      username = args[0].username
      password = args[0].password
    end
    
    visit new_user_session_path
    fill_in "Username", with: username
    fill_in "Password", with: password
    click_button "Log in"
  end
end
