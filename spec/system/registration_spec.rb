require 'rails_helper'

RSpec.feature 'Registration', type: :system do
    given!(:user) { create(:user) }
    
    scenario '新規登録ページの要素検証' do
        #新規登録ページへアクセス
        visit new_user_registration_path
        
        #新規登録ページの各項目を確認
        expect(page).to have_selector 'h1', text: '新規ユーザー登録'
        expect(page).to have_selector 'label', text: 'ユーザーネーム'
        expect(page).to have_selector 'label', text: 'Eメール'
        expect(page).to have_selector 'label', text: 'パスワード'
        expect(page).to have_selector 'label', text: 'パスワード（確認用）'
        expect(page).to have_button '新規登録'
        expect(page).to have_link 'ログイン'
    end
    
    scenario '新規登録に成功した場合' do
        #新規登録ページへアクセス
        visit new_user_registration_path
        
        #新規登録ページの各フィールド入力
        fill_in 'user_name', with: 'othermama'
        fill_in 'user_email', with: 'other@other.com'
        fill_in 'user_password', with: 'password3'
        fill_in 'user_password_confirmation', with: 'password3'
        
        #新規登録ボタンをクリック
        click_button '新規登録'
        
        #トップページへリダイレクト
        expect(page).to have_content '育児の孤独感やママ友の悩みを抱え込まず共有しましょう'
        expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'
    end
    
    scenario 'ユーザーネームがブランクの場合' do
        #新規登録ページへアクセス
        visit new_user_registration_path
        
        #新規登録ページの各フィールド入力
        fill_in 'user_name', with: ''
        fill_in 'user_email', with: 'other@other.com'
        fill_in 'user_password', with: 'password3'
        fill_in 'user_password_confirmation', with: 'password3'
        
        #新規登録ボタンをクリック
        click_button '新規登録'
        
        #エラーメッセージを表示
        expect(page).to have_content 'ユーザーネームを入力してください'
    end
    
    scenario 'Eメールがブランクの場合' do
        #新規登録ページへアクセス
        visit new_user_registration_path
        
        #新規登録ページの各フィールド入力
        fill_in 'user_name', with: 'othermama'
        fill_in 'user_email', with: ''
        fill_in 'user_password', with: 'password3'
        fill_in 'user_password_confirmation', with: 'password3'
        
        #新規登録ボタンをクリック
        click_button '新規登録'
        
        #エラーメッセージを表示
        expect(page).to have_content 'Eメールを入力してください'
    end
    
    scenario 'Eメールにドメインが入力されていない場合' do
        #新規登録ページへアクセス
        visit new_user_registration_path
        
        #新規登録ページの各フィールド入力
        fill_in 'user_name', with: 'othermama'
        fill_in 'user_email', with: 'other'
        fill_in 'user_password', with: 'password3'
        fill_in 'user_password_confirmation', with: 'password3'
        
        #新規登録ボタンをクリック
        click_button '新規登録'
        
        #エラーメッセージを表示
        expect(page).to have_content 'Eメールが正しく入力されていません'
    end
    
    scenario 'パスワードがブランクの場合' do
        #新規登録ページへアクセス
        visit new_user_registration_path
        
        #新規登録ページの各フィールド入力
        fill_in 'user_name', with: 'othermama'
        fill_in 'user_email', with: 'other@other.com'
        fill_in 'user_password', with: ''
        fill_in 'user_password_confirmation', with: 'password3'
        
        #新規登録ボタンをクリック
        click_button '新規登録'
        
        #エラーメッセージを表示
        expect(page).to have_content 'パスワードを入力してください'
    end
    
    scenario 'パスワードが英数字混在の６文字以上ではない場合' do
        #新規登録ページへアクセス
        visit new_user_registration_path
        
        #新規登録ページの各フィールド入力
        fill_in 'user_name', with: 'othermama'
        fill_in 'user_email', with: 'other@other.com'
        fill_in 'user_password', with: 'pass'
        fill_in 'user_password_confirmation', with: ''
        
        #新規登録ボタンをクリック
        click_button '新規登録'
        
        #エラーメッセージを表示
        expect(page).to have_content 'パスワードは６文字以上の英数混在で入力してください。'
    end
    
    scenario 'パスワードと確認用パスワードが一致しない場合' do
        #新規登録ページへアクセス
        visit new_user_registration_path
        
        #新規登録ページの各フィールド入力
        fill_in 'user_name', with: 'othermama'
        fill_in 'user_email', with: 'other@other.com'
        fill_in 'user_password', with: 'password3'
        fill_in 'user_password_confirmation', with: ''
        
        #新規登録ボタンをクリック
        click_button '新規登録'
        
        #エラーメッセージを表示
        expect(page).to have_content 'パスワード（確認用）とパスワードの入力が一致しません'
    end
end