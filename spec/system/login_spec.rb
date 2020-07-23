require 'rails_helper'

RSpec.feature 'login', type: :system do
    given!(:user) { create(:user) }
    
    scenario 'ログインページの要素検証' do
        #ログインページへアクセス
        visit new_user_session_path
        
        #ログインページの各項目を確認
        expect(page).to have_selector 'h1', text: 'ログイン'
        expect(page).to have_selector 'label', text: 'Eメール'
        expect(page).to have_selector 'label', text: 'パスワード'
        expect(page).to have_selector 'label', text: 'ログインを記憶する'
        expect(page).to have_button 'ログイン'
        expect(page).to have_link '新規登録'
        expect(page).to have_link 'パスワードを忘れた場合'
    end
    
    scenario 'ログイン成功した場合' do
        #ログインページへアクセス
        visit new_user_session_path
        
        #ログインページの各フィールドに入力
        fill_in 'user_email', with: 'test@test.com'
        fill_in 'user_password', with: 'password3'
        
        #ログインボタンをクリック
        click_button 'ログイン'
        
        #マイページへリダイレクト
        expect(page).to have_content 'ログインしました。'
    end
    
    scenario 'Eメールが空白の場合' do
        #ログインページへアクセス
        visit new_user_session_path
        
        #ログインページの各フィールドに入力
        fill_in 'user_email', with: ''
        fill_in 'user_password', with: 'password3'
        
        #ログインボタンをクリック
        click_on 'commit'
        
        #Eメールのエラーメッセージ表示
        expect(page).to have_content 'Eメールまたはパスワードが違います。'
    end
    
    scenario 'パスワードが空白の場合' do
        #ログインページへアクセス
        visit new_user_session_path
        
        #ログインページの各フィールドに入力
        fill_in 'user_email', with: 'test@test.com'
        fill_in 'user_password', with: ''
        
        #ログインボタンをクリック
        click_on 'commit'
        
        #Eメールのエラーメッセージ表示
        expect(page).to have_content 'Eメールまたはパスワードが違います。'
    end
    
    scenario 'Eメールまたはパスワードが違う場合。' do
        #ログインページへアクセス
        visit new_user_session_path
        
        #ログインページの各フィールドに入力
        fill_in 'user_email', with: 'test1@test.com'
        fill_in 'user_password', with: 'password3'
        
        #ログインボタンをクリック
        click_on 'commit'
        
        #エラーメッセージ表示
        expect(page).to have_content 'Eメールまたはパスワードが違います。'
    end
end