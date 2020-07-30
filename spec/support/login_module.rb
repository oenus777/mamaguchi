module LoginModule
  def login(user)
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: 'password3'
    click_button 'ログイン'
  end
end