module AuthMacros
  def login(user = nil)
    visit new_user_session_url
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_on "Connexion"
  end
end
