require 'rails_helper'

RSpec.describe Post, type: :model do
    
    before do
        @post = build(:post)
    end
    
    it "投稿することができる（全てのバリデーション条件に当てはまる）" do
        expect(build(:post)).to be_valid
    end
    
describe "バリデーションテスト" do
    it "ユーザーidが無いと投稿できない" do
        @post.user_id = nil
        @post.valid?
        expect(@post.errors).to be_added(:user_id,:blank)
    end
    
    it "タイトルが無いと投稿できない" do
        @post.title = nil
        @post.valid?
        expect(@post.errors).to be_added(:title,:blank)
    end
    
    it "タイトルが３１文字以上だと投稿できない" do
        @post.title = "a" * 31
        @post.valid?
        expect(@post.errors).to be_added(:title,:too_long,count: 30)
    end
    
    it "コンテンツが無いと投稿できない" do
        @post.content = nil
        @post.valid?
        expect(@post.errors).to be_added(:content,:blank)
    end
    
    it "コンテンツが１００１文字以上だと投稿できない" do
        @post.content = "a" * 1001
        @post.valid?
        expect(@post.errors).to be_added(:content,:too_long,count: 1000)
    end
    
    it "ユーザーが削除された場合、ユーザーに紐付く投稿も削除される" do
        @post.save
        user = User.find(1)
        expect(user.posts.present?).to eq true
        user.destroy
        expect(user.posts.present?).to eq false
    end
    
    it "イイね、取り消しができる" do
        @post.save
        user = User.find(1)
        @post.like(user)
        expect(@post.like?(user)).to eq true
        @post.unlike(user)
        expect(@post.like?(user)).to eq false
    end
    
    it "イイねした投稿が削除された場合、イイねも削除される" do
        post = create(:post)
        user = User.find(1)
        post.like(user)
        expect(post.like?(user)).to eq true
        post.destroy
        expect(post.like?(user)).to eq false
    end
    
    it "イイねしたユーザーが削除された場合、イイねも削除される" do
        @post.save
        user = User.find(1)
        @post.like(user)
        expect(@post.like?(user)).to eq true
        user.destroy
        expect(@post.like?(user)).to eq false
    end
    
    it "お気に入り登録、取り消しができる" do
        @post.save
        user = User.find(1)
        @post.favorite(user)
        expect(@post.favorite?(user)).to eq true
        @post.unfavorite(user)
        expect(@post.favorite?(user)).to eq false
    end

end
  
end
