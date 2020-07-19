require 'rails_helper'

RSpec.describe 'Favorite', type: :request do
    let!(:post1) { create(:post) }

    describe 'POST #create' do
        context '未ログイン時' do
            it 'リクエストが不成功' do
                expect do
                    post favorites_path,params: { post_id: 1 }
                end.to change(Favorite, :count).by(0)
                expect(response).to have_http_status 302
                expect(response).to redirect_to new_user_session_path
            end
        end
        context 'ログイン時' do
            it 'リクエストが成功' do
                sign_in(post1.user)
                expect do
                    post favorites_path,params: { post_id: 1 }
                end.to change(Favorite, :count).by(1)
                expect(response).to have_http_status 302
                expect(response).to redirect_to root_path
            end
        end
    end
    describe 'DELETE #destroy' do
        context '未ログイン時' do
            it 'リクエストが不成功' do
                expect do
                    delete favorite_path(post1), params: { post_id: 1 }
                end.to change(Favorite, :count).by(0)
                expect(response).to have_http_status 302
                expect(response).to redirect_to new_user_session_path
            end
        end
        context 'ログイン時' do
            it 'リクエストが成功' do
                sign_in(post1.user)
                expect do
                    post favorites_path,params: { post_id: 1 }
                end.to change(Favorite, :count).by(1)
                expect do
                    delete favorite_path(post1),params: { post_id: 1 }
                end.to change(Favorite, :count).by(-1)
                expect(response).to have_http_status 302
                expect(response).to redirect_to root_path
            end
        end
    end
end