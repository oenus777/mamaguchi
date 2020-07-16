require 'rails_helper'

RSpec.describe 'Comment', type: :request do
    let!(:post1) { create(:post) }
    
    describe 'POST #create' do
        context 'ログイン時' do
            it '１０００文字以内だとリクエスト成功' do
                sign_in(post1.user)
                params = {
                    comment: {
                        post_id: 1,
                        comment: "a"*255
                    }
                }
                expect do
                    post comments_path,params: params
                end.to change(Comment, :count).by(1)
                expect(response).to have_http_status 302
                expect(response).to redirect_to post_path(post1)
            end
            it '１０００文字以上だとリクエスト不成功' do
                sign_in(post1.user)
                params = {
                    comment: {
                        post_id: 1,
                        comment: "a"*256
                    }
                }
                expect do
                    post comments_path,params: params
                end.to change(Comment, :count).by(0)
                expect(response).to have_http_status 302
                expect(response).to redirect_to post_path(post1)
            end
        end
    end
end