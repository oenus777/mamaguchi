require 'rails_helper'

RSpec.describe 'Posts', type: :request do
    let!(:post1) { create(:post) }
    let!(:post2) { create(:post,:other) }
    
    describe 'GET #index'do
        context '未ログイン時' do
            it 'アクセスできない' do
                get posts_path
                expect(response).to redirect_to new_user_session_path
            end
        end
        context 'ログイン時' do
            it 'リクエストが成功' do
                sign_in(post1.user)
                get posts_path
                expect(response).to have_http_status 200
                expect(response.body).to include '新着投稿一覧'
            end
        end
    end
    describe 'GET #show' do
        context '未ログイン時' do
            it 'リクエストが成功' do
                get post_path(post1)
                expect(response).to have_http_status 200
                expect(response.body).to include 'test'
            end
        end
        context 'ログイン時' do
            it 'リクエストが成功' do
                sign_in(post1.user)
                get post_path(post1)
                expect(response).to have_http_status 200
                expect(response.body).to include 'test'
            end
        end
    end
    describe 'GET #edit' do
        context '未ログイン時' do
            it 'アクセスできない' do
                get edit_post_path(post1)
                expect(response).to have_http_status 302
            end
        end
        context 'ログイン時、自ら投稿した内容を編集する場合' do
            it 'リクエストが成功' do
                sign_in(post1.user)
                get edit_post_path(post1)
                expect(response).to have_http_status 200
                expect(response.body).to include 'test'
            end
        end
        context 'ログイン時、他人が投稿した内容を編集する場合' do
            it 'アクセスできない' do
                sign_in(post1.user)
                get edit_post_path(post2)
                expect(response).to have_http_status 302
                expect(response).to redirect_to root_path
            end
        end
    end
    describe 'PATCH #update' do
        context '未ログイン時' do
            it 'リクエストが不成功' do
                params = {
                    post: {
                        title: "aaaaa",
                        content: "aaaaaaaaaaaaaaa"
                    }
                }
                patch post_path(1),params: params
                expect(response).to have_http_status 302
                expect(response).to redirect_to new_user_session_path
            end
        end
        context 'ログイン時' do
            it '投稿したユーザーの場合、リクエストが成功する' do
                sign_in(post1.user)
                params = {
                    post: {
                        title: "aaaaa",
                        content: "aaaaaaaaaaaaaaa"
                    }
                }
                patch post_path(1),params: params
                expect(response).to have_http_status 302
                expect(response).to redirect_to post_path(1)
            end
        end
    end
    describe 'GET #new' do
        context '未ログイン時' do
            it 'アクセスできない' do
                get new_post_path
                expect(response).to have_http_status 302
                expect(response).to redirect_to new_user_session_path
            end
        end
        context 'ログイン時' do
            it 'リクエストが成功' do
                sign_in(post1.user)
                get new_post_path
                expect(response).to have_http_status 200
                expect(response.body).to include '新規投稿'
            end
        end
    end
    describe 'POST #create' do
        context '未ログイン時' do
            it 'リクエストが不成功' do
                params = {
                    post: {
                        title: "new",
                        content: "newnew",
                        user_id: 1,
                        category_id: 1
                    }
                }
                expect do
                    post posts_path, params: params
                end.to change(Post, :count).by(0)
                expect(response).to have_http_status 302
                expect(response).to redirect_to new_user_session_path
            end
        end
        context 'ログイン時' do
            it 'リクエストが成功' do
                sign_in(post1.user)
                params = {
                    post: {
                        title: "new",
                        content: "newnew",
                        user_id: 1,
                        category_id: 1
                    }
                }
                expect do
                    post posts_path, params: params
                end.to change(Post, :count).by(1)
                expect(response).to have_http_status 302
                expect(response).to redirect_to post_path(3) 
            end
        end
    end
    describe 'DELETE #destroy' do
        context '未ログイン時' do
            it 'リクエストが不成功' do
                expect do
                    delete post_path(post1),params: { id: post1 }
                end.to change(Post, :count).by(0)
                expect(response).to have_http_status 302
                expect(response).to redirect_to new_user_session_path
            end
        end
        context 'ログイン時' do
            it '投稿したユーザーの場合、リクエストが成功' do
                sign_in(post1.user)
                expect do
                    delete post_path(post1),params: { id: post1 }
                end.to change(Post, :count).by(-1)
                expect(response).to have_http_status 302
                expect(response).to redirect_to root_path
            end
            it '投稿していないユーザーの場合、リクエストが不成功' do
                sign_in(post2.user)
                expect do
                    delete post_path(post1),params: { id: post1 }
                end.to change(Post, :count).by(0)
            end
        end
    end
    describe 'GET #search' do
        context '未ログイン時' do
            it 'アクセスできない' do
                get search_path
                expect(response).to have_http_status 302
                expect(response).to redirect_to new_user_session_path
            end
        end
        context 'ログイン時' do
            it 'リクエストが成功' do
                sign_in(post1.user)
                params = {
                    q: {
                        title_or_content_cont: "aaa"
                    }
                }
                get search_path,params: params
                expect(response).to have_http_status 200
                expect(response.body).to include '検索結果'
            end
        end
    end
end