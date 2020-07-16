require 'rails_helper'

RSpec.describe 'Follower', type: :request do
    let!(:user) { create(:user) }
    
    describe 'GET #indes' do
        context '未ログイン時' do
            it 'アクセスできない' do
                get followers_path(user)
                expect(response).to have_http_status 302
                expect(response).to redirect_to new_user_session_path
            end
        end
        context 'ログイン時' do
            it 'リクエストが成功' do
                sign_in(user)
                get followers_path(user)
                expect(response).to have_http_status 200
                expect(response.body).to include 'フォロワー一覧'
            end
        end
    end
end