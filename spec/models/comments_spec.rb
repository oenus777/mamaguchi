require 'rails_helper'

RSpec.describe Comment, type: :model do
    
    before do
        @comment = build(:comment)
    end
    
    it "コメントが投稿できる(ポストid,ユーザーid,コメント有)" do
        expect(build(:comment)).to be_valid
    end
  
describe "バリデーションテスト" do
    
    it "ポストidが無いと登録できない" do
        @comment.post_id = nil
        @comment.valid?
        expect(@comment.errors).to be_added(:post,:blank)
    end
    
    it "ユーザーidが無いと登録できない" do
        @comment.user_id = nil
        @comment.valid?
        expect(@comment.errors).to be_added(:user,:blank)
    end
    
    
    it "コメントが１０００文字以内なら投稿できる" do
        @comment.comment = "test" * 250
        expect(@comment).to be_valid
    end
    
    it "コメントが１００１文字以上なら投稿できない" do
        @comment.comment = "test" * 251
        @comment.valid?
        expect(@comment.errors).to be_added(:comment,:too_long,count: 1000) 
    end
    
    it "一人のユーザーは同記事に複数コメントが投稿できる" 
    
    it "ポストが削除されると投稿されていたコメントも全て削除される"
    
    it "ユーザーが削除されると投稿しているコメントも全て削除"
    
end

end
