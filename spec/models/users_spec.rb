require 'rails_helper'

RSpec.describe Users, type: :model do
    
    before do
        @user = build(:user)
    end
    
    it "ユーザーネーム、パスワードがあれば登録できる" do
        expect(build(:user)).to be_valid
    end
    
    it "ユーザーネームが無いと登録できない" do
    end
    
    it "ユーザーネームが重複すると登録できない"
    
    it "ユーザーネームが11文字以上だと登録できない"
    
    it "メールアドレスが無いと登録できない"
    
    it "メールアドレスが重複すると登録できない"
    
    it "メールアドレスが256文字以上だと登録できない"
    
end