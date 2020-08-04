require 'rails_helper'

RSpec.feature 'followings', type: :system do
    given!(:user1) { create(:user) }
    given!(:user2) { create(:user,:other) }
    
    #フォロー一覧ページのテストケース
    scenario 'フォローしているユーザーがいない場合のフォロー一覧ページの要素検証' do
        #ログイン
        login(user1)
        
        #フォロー数をクリック
        click_on 'フォロー数'
        
        #フォロー一覧ページの各項目を確認
        expect(page).to have_selector 'h1', text: 'フォロー一覧'
        expect(page).to have_selector 'img'
        expect(page).to have_selector 'h2', text: 'testmama'
        expect(page).to have_selector 'label', text: 'フォロー中'
        expect(page).to have_selector 'p', text: 'フォローしていません'
    end
    
    scenario 'フォローするとフォロー一覧に追加、フォロー解除するとフォロー一覧から削除' do
        #ログイン
        login(user1)
        
        #他ユーザーへアクセスしフォローをクリック
        visit user_path(2)
        click_on 'フォロー'
        
        #マイページへアクセスしフォロー数をクリック
        visit user_path(1)
        click_on 'フォロー数'
        
        #フォロー一覧ページに追加されている事を確認
        expect(page).to have_selector 'h1', text: 'フォロー一覧'
        expect(page).to have_selector 'img'
        expect(page).to have_selector 'h2', text: 'testmama'
        expect(page).to have_selector 'label', text: 'フォロー中'
        expect(find('.follow')).to have_css '.profile_image'
        expect(page).to have_css '.font', text: 'othermama'
        
        #他ユーザーへアクセスしフォロー解除をクリック
        visit user_path(2)
        click_on 'フォロー解除'
        
        #マイページへアクセスしフォロー数をクリック
        visit user_path(1)
        click_on 'フォロー数'
        
        #フォロー一覧ページから削除されている事を確認
        expect(page).to have_selector 'h1', text: 'フォロー一覧'
        expect(page).to have_selector 'img'
        expect(page).to have_selector 'h2', text: 'testmama'
        expect(page).to have_selector 'label', text: 'フォロー中'
        expect(page).to have_no_css '.follow'
        expect(page).to have_no_css '.font', text: 'othermama'
    end
end