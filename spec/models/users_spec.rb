require 'rails_helper'

RSpec.describe Users, type: :model do
    
    before do
        @user = build(:user)
    end
    
    it "ユーザー登録できる" do
        expect(build(:user)).to be_valid
    end
    
describe "バリデーションテスト" do
    it "ユーザーネーム、メールアドレス、パスワード、パスワード確認があると登録できる" do
        user = User.new(
            name: "test",
            email: "test@test.com",
            password: "password3",
            password_confirmation: "password3")
        expect(user).to be_valid
    end

    it "ユーザーネームが無いと登録できない" do
        @user.name = nil
        @user.valid?
        expect(@user.errors).to be_added(:name,:blank)
    end
    
    it "ユーザーネームが重複すると登録できない" do
        user1 = create(:user)
        user2 = build(:user, name: "testmama")
        user2.valid?
        expect(user2.errors).to be_added(:name,:taken,value: "testmama")
    end
    
    it "ユーザーネームが15文字以内だと登録できる" do
        @user.name = "a" * 15
        expect(@user).to be_valid
    end
    
    it "ユーザーネームが16文字以上だと登録できない" do
        @user.name = "a" * 16
        @user.valid?
        expect(@user.errors).to be_added(:name,:too_long,count: 15)
    end
    
    it "ユーザーネームの大文字小文字は区別し登録できる" do
        user1 = create(:user)
        user2 = build(:user, name: "TestMama",email: "test1@test.com")
        expect(user2).to be_valid
    end
    
    it "メールアドレスが無いと登録できない" do
        @user.email = nil
        @user.valid?
        expect(@user.errors).to be_added(:email,:blank)
    end
    
    it "メールアドレスが重複すると登録できない" do
        user1 = create(:user)
        user2 = build(:user,email: "test@test.com")
        user2.valid?
        expect(user2.errors).to be_added(:email,:taken,value: "test@test.com")
    end
    
    it "メールアドレスが255文字以内だと登録できる" do
        @user.email = "a" * 246 + "@test.com"
        expect(@user).to be_valid
    end
    
    it "メールアドレスが256文字以上だと登録できない" do
        @user.email = "a" * 256 + "@test.com"
        @user.valid?
        expect(@user.errors).to be_added(:email,:too_long,count: 255)
    end
    
    it "パスワードが無いと登録できない" do
        @user.password = nil
        @user.valid?
        expect(@user.errors).to be_added(:password,:blank)
    end
    
    it "パスワードが英数混在だと登録できる" do
        @user.password = "a" * 3 + "123"
        @user.password_confirmation = "a" * 3 + "123"
        expect(@user).to be_valid
    end
    
    it "パスワードが英数混在ではないと登録できない" do
        @user.password = "a" * 8
        @user.password_confirmation = "a" * 8
        @user.valid?
        expect(@user.errors).to be_added(:password,:invalid,value: "aaaaaaaa")
    end
    
    it "パスワードが6文字以上128以下だと登録できる" do
        @user.password = "a" * 10 + "123"
        @user.password_confirmation = "a" * 10 + "123"
        expect(@user).to be_valid
    end
    
    it "パスワードが5文字以下だと登録できない" do
        @user.password = "a1234"
        @user.valid?
        expect(@user.errors).to be_added(:password,:too_short,count: 6)
    end
    
    it "パスワードが129文字以上だと登録できない" do
        @user.password = "a" * 128 + "1"
        @user.valid?
        expect(@user.errors).to be_added(:password,:too_long,count: 128)
    end

    it "パスワードと確認パスワードが一致していないと登録できない" do
        @user.password = "12345abc"
        @user.password_confirmation = "12345abcde"
        @user.valid?
        expect(@user.errors).to be_added(:password_confirmation,:confirmation,attribute: "パスワード")
    end
    
    it "フォローする、フォロー解除ができる" do
        user1 = create(:user)
        user2 = create(:user, :other)
        user1.follow(user2)
        expect(user1.following?(user2)).to eq true
        user1.unfollow(user2)
        expect(user1.following?(user2)).to eq false
    end
    
    it "フォローしているユーザーが削除された時、フォロー情報から削除される" do
        user1 = create(:user)
        user2 = create(:user, :other)
        user1.follow(user2)
        expect(user1.following?(user2)).to eq true
        user2.destroy
        expect(user1.following?(user2)).to eq false
    end
    
    it "フォローされているユーザーが削除された時、フォロワー情報から削除される" do
        user1 = create(:user)
        user2 = create(:user, :other)
        user2.follow(user1)
        expect(user1.followers.include?(user2)).to eq true
        user2.destroy
        expect(user1.followers.include?(user2)).to eq false
    end
    
end

end