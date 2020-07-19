require 'rails_helper'

RSpec.describe 'Relationship', type: :request do
    let!(:user1) { create(:user) }
    let!(:user2) { create(:user,:other) }
    
    describe 'POST #create' do
        context '未ログイン時' do
            it 'リクエストが不成功' do
                expect do
                    post relationships_path,params: { follow_id: 2 }
                end.to change(Relationship, :count).by(0)
                expect(response).to have_http_status 302
                expect(response).to redirect_to new_user_session_path
            end
        end
        context 'ログイン時' do
            it 'リクエストが成功' do
                sign_in(user1)
                expect do
                    post relationships_path,params: { follow_id: 2 }
                end.to change(Relationship, :count).by(1)
                expect(response).to have_http_status 302
                expect(response).to redirect_to user_path(user2)
            end
        end
    end
    describe 'DELETE #destroy' do
        context '未ログイン時' do
            it 'リクエストが不成功' do
                expect do
                    delete relationship_path(user2), params: { follow_id: 2 }
                end.to change(Relationship, :count).by(0)
                expect(response).to have_http_status 302
                expect(response).to redirect_to new_user_session_path
            end
        end
        context 'ログイン時' do
            it 'リクエストが成功' do
                sign_in(user1)
                expect do
                    post relationships_path,params: { follow_id: 2 }
                end.to change(Relationship, :count).by(1)
                expect do
                    delete relationship_path(user2),params: { follow_id: 2 }
                end.to change(Relationship, :count).by(-1)
                expect(response).to have_http_status 302
                expect(response).to redirect_to user_path(user2)
            end
        end
    end
end