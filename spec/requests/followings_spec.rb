require 'rails_helper'

RSpec.describe 'Following', type: :request do
    let!(:user) { create(:user) }
    
    describe 'GET #indes' do
        context '未ログイン時' do
            it 'アクセスできない' do
                get followings_path(user)
                expect(response).to have_http_status 302
                expect(response).to redirect_to new_user_session_path
            end
        end
        context 'ログイン時' do
            it 'リクエストが成功' do
                sign_in(user)
                get followings_path(user)
                expect(response).to have_http_status 200
                expect(response.body).to include 'フォロー一覧'
            end
        end
    end
end