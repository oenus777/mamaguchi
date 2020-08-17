require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user) { create(:user) }
  let!(:user1) { create(:user,:other) }
  
  describe 'GET #show' do
    context 'マイページの場合' do
      it 'リスエスト成功' do
        sign_in(user)
        get user_path(user)
        expect(response).to have_http_status 200
        expect(response.body).to include 'マイページ' 
      end
    end
      
    context 'ユーザーページの場合' do
      it 'リクエスト成功' do
        sign_in(user)
        get user_path(user1)
        expect(response).to have_http_status 200
        expect(response.body).to include 'ユーザーページ'
      end
    end
  end
  
  describe 'GET #edit' do
    context 'ログインユーザーの場合' do
      it 'ログインユーザー情報の編集は成功' do
        sign_in(user)
        get edit_user_path(user)
        expect(response).to have_http_status 200
      end
      
      it '他のユーザー情報の編集は不成功' do
        sign_in(user)
        get edit_user_path(user1)
        expect(response).to have_http_status 302
        expect(response).to redirect_to root_path
      end
    end
  end
  
  describe 'PATCH #update' do
    context 'ログインユーザーの場合' do
      it 'ユーザー名変更リクエストが成功' do
        sign_in(user)
        params = {
          user: {
            name: "testmama1"
          }
        }
        patch user_path(user),params: params
        expect(response).to redirect_to user_path(user)
      end
    end
  end
  
  describe 'GET #login' do
    context '未ログイン時' do
      it 'リクエストが成功' do
        get new_user_session_path
        expect(response).to have_http_status 200
        expect(response.body).to include 'ログイン'
      end
    end
    
    context 'ログイン時' do
      it 'アクセスできない' do
        sign_in(user)
        get new_user_session_path
        expect(response).to redirect_to user_path(user)
      end
    end
  end
  
  describe 'POST #login' do
    context '未ログイン時' do
      it 'ログインが成功' do
        params = {
          user: {
            email: "test@test.com",
            password: "password3"
          }
        }
        post login_path, params: params
        expect(response).to have_http_status 302
        expect(response).to redirect_to user_path(user)
      end
        
      it 'POST #loginが不成功、メールアドレスまたはパスワードが見当たらないため' do
        params = {
          user: {
            email: "test1@test.com",
            password: "password3"
          }
        }
        post login_path, params: params
        expect(response.body).to include 'Eメールまたはパスワードが違います。'
      end
    end
  end
  
  describe 'GET #sign_up' do
    context '未ログイン時' do
      it 'リクエストが成功' do
        get new_user_registration_path
        expect(response).to have_http_status 200
        expect(response.body).to include '新規ユーザー登録'
      end
    end
    
    context 'ログイン時' do
      it 'アクセスできない' do
        sign_in(user)
        get new_user_registration_path
        expect(response).to redirect_to user_path(user)
      end
    end
  end
  
  describe 'POST #create'do
    context '未ログイン時' do
      it '新規登録成功' do
        params = {
          user: {
            name: "testmama4",
            email: "test1@test.com",
            password: "password3",
            password_confirmation: "password3"
          }
        }
        post user_registration_path, params: params
        expect(response).to redirect_to root_path
      end
    end
  end
end