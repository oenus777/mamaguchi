require 'rails_helper'

RSpec.describe 'Category', type: :request do
    let!(:post1) { create(:post) }
    
    describe 'GET #show' do
        context '未ログイン時' do
            it 'アクセスできない' do
                get categories_show_path
                expect(response).to have_http_status 302
                expect(response).to redirect_to new_user_session_path
            end
        end
        context 'ログイン時' do
            it 'リクエストが成功' do
                sign_in(post1.user)
                get category_path(1)
                expect(response).to have_http_status 200
                expect(response.body).to include 'カテゴリ別の投稿一覧'
            end
        end
    end
end