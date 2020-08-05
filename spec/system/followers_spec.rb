require 'rails_helper'

RSpec.feature 'followers', type: :system do
    given!(:user1) { create(:user) }
    given!(:user2) { create(:user,:other) }
    
    #フォロワー一覧ページのテストケース
    scenario 'フォローされているユーザーがいない場合のフォロワー一覧ページの要素検証' do
        #ログイン
        login(user1)
        
        #フォロー数をクリック
        click_on 'フォロワー数'
        
        #フォロー一覧ページの各項目を確認
        expect(page).to have_selector 'h1', text: 'フォロワー一覧'
        expect(page).to have_selector 'img'
        expect(page).to have_selector 'h2', text: 'testmama'
        expect(page).to have_selector 'label', text: 'フォロワー'
        expect(page).to have_selector 'p', text: 'フォローされていません'
    end
    
    scenario 'フォローされるとフォロワー一覧に追加、フォロー解除されるとフォロワー一覧から削除' do
        #ログイン
        login(user1)
        
        #他ユーザーへアクセスしフォローをクリック、またフォオワー数をクリック
        visit user_path(2)
        click_on 'フォロー'
        click_on 'フォロワー数'
        
        #フォロワー一覧ページに追加されている事を確認
        expect(page).to have_selector 'h1', text: 'フォロワー一覧'
        expect(page).to have_selector 'img'
        expect(page).to have_selector 'h2', text: 'othermama'
        expect(page).to have_selector 'label', text: 'フォロワー'
        expect(find('.follow')).to have_css '.profile_image'
        expect(page).to have_css '.font', text: 'testmama'
        
        #他ユーザーへアクセスしフォロー解除をクリック、またフォロワー数をクリック
        visit user_path(2)
        click_on 'フォロー解除'
        click_on 'フォロワー数'
        
        #フォロー一覧ページから削除されている事を確認
        expect(page).to have_selector 'h1', text: 'フォロワー一覧'
        expect(page).to have_selector 'img'
        expect(page).to have_selector 'h2', text: 'othermama'
        expect(page).to have_selector 'label', text: 'フォロワー'
        expect(page).to have_no_css '.follow'
        expect(page).to have_no_css '.font', text: 'testmama'
    end
end