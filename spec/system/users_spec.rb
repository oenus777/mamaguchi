require 'rails_helper'

RSpec.feature 'users', type: :system do
    given!(:user1) { create(:user) }
    given!(:post1) { create(:post,:other) }
    given!(:category) { create(:category) }
    
    #ユーザー詳細ページのテストケース
    scenario 'マイページの要素検証' do
        #ログイン
        login(user1)
        
        #マイページの各項目を確認
        expect(page).to have_selector 'h1', text: 'マイページ'
        expect(page).to have_selector 'h2', text: user1.name
        expect(page).to have_css 'img.profile_image'
        expect(page).to have_link 'フォロー数'
        expect(page).to have_link 'フォロワー数'
        expect(page).to have_selector 'a', text: '編集'
        expect(page).to have_selector 'label', text: '投稿'
        expect(page).to have_selector 'label', text: 'イイね'
        expect(page).to have_selector 'label', text: 'お気に入り'
    end
    
    scenario 'ユーザーページの要素検証（フォローしていない場合）' do
        #ログイン
        login(user1)
        
        #他のユーザーページへアクセス
        visit user_path(2)
        
        #マイページの各項目を確認
        expect(page).to have_selector 'h1', text: 'ユーザーページ'
        expect(page).to have_selector 'h2', text: 'othermama'
        expect(page).to have_css 'img.profile_image'
        expect(page).to have_button 'フォロー'
        expect(page).to have_link 'フォロー数'
        expect(page).to have_link 'フォロワー数'
        expect(page).to have_selector 'label', text: '投稿'
        expect(page).to have_selector 'label', text: 'イイね'
        expect(page).to have_selector 'label', text: 'お気に入り'
    end
    
    scenario 'ユーザーページの要素検証（フォローしている場合）' do
        #ログイン
        login(user1)
        
        #他のユーザーページへアクセス
        visit user_path(2)
        
        #フォローをクリック
        click_button 'フォロー'
        
        #マイページの各項目を確認
        expect(page).to have_selector 'h1', text: 'ユーザーページ'
        expect(page).to have_selector 'h2', text: 'othermama'
        expect(page).to have_css 'img.profile_image'
        expect(page).to have_button 'フォロー解除'
        expect(page).to have_link 'フォロー数'
        expect(page).to have_link 'フォロワー数'
        expect(page).to have_selector 'label', text: '投稿'
        expect(page).to have_selector 'label', text: 'イイね'
        expect(page).to have_selector 'label', text: 'お気に入り'
    end
    
    scenario 'フォローするとマイページのフォロー数が増える' do
        #ログイン
        login(user1)
        
        #フォローする前のフォロー数を確認
        expect(page).to have_content 'フォロー数 0'
        
        #他のユーザーページへアクセス
        visit user_path(2)
        
        #フォローをクリック
        click_button 'フォロー'
        
        #マイページへアクセス
        click_on 'マイページ'
        
        #フォロー数が増えていることを確認
        expect(page).to have_content 'フォロー数 1'
    end
    
    scenario 'フォローされるとユーザーページのフォロワー数が増える' do
        #ログイン
        login(user1)
        
        #他のユーザーページへアクセス
        visit user_path(2)
        
        #フォローする前のフォロー数を確認
        expect(page).to have_content 'フォロワー数 0'
        
        #フォローをクリック
        click_button 'フォロー'
        
        #フォロワー数が増えていることを確認
        expect(page).to have_content 'フォロワー数 1'
    end
    
    scenario '投稿すると投稿タブに反映される' do
        #ログイン
        login(user1)
        
        #投稿タブの中に投稿が無いことを確認
        expect(find_by_id('like_content')).to have_no_css '.card'
        
        #投稿する
        create_post
        
        #マイページへアクセス
        click_on 'マイページ'
        
        #投稿タブの中に投稿した投稿があることを確認
        expect(find_by_id('post_content')).to have_css '.card'
    end
    
    scenario '投稿をイイねするとイイねタブに反映される' do
        #ログイン
        login(user1)
        
        #イイねタブの中に投稿が無いことを確認
        expect(find_by_id('like_content')).to have_no_css '.card'
        
        #他のユーザーの投稿ページへアクセスしイイねボタンをクリック
        visit post_path(2)
        all('button')[1].click
        
        #マイページへアクセス
        click_on 'マイページ'
        
        #投稿タブの中に投稿した投稿があることを確認
        expect(find_by_id('like_content')).to have_css '.card'
    end
    
    scenario '投稿をお気に入りするとお気に入りタブに反映される' do
        #ログイン
        login(user1)
        
        #イイねタブの中に投稿が無いことを確認
        expect(find_by_id('favorite_content')).to have_no_css '.card'
        
        #他のユーザーの投稿ページへアクセスしイイねボタンをクリック
        visit post_path(2)
        all('button')[2].click
        
        #マイページへアクセス
        click_on 'マイページ'
        
        #投稿タブの中に投稿した投稿があることを確認
        expect(find_by_id('favorite_content')).to have_css '.card'
    end
    
    #ユーザー編集機能のテストケース
    scenario 'ユーザー情報ページの要素検証' do
        #ログイン
        login(user1)
        
        #編集リンクをクリック
        click_on '編集'
        
        #ユーザー編集ページの各項目を確認
        expect(page).to have_selector 'h1', text: 'ユーザー情報編集'
        expect(page).to have_selector 'label', text: 'プロフィール画像'
        expect(page).to have_css 'img.profile_image'
        expect(page).to have_selector 'label', text: 'ユーザーネーム(15文字以内)'
        expect(page).to have_button '更新'
    end
    
    scenario '編集ができる', js: true do
        #ログイン
        login(user1)
        
        #編集リンクをクリック
        click_on '編集'
        
        #各フィールドを入力
        attach_file 'user[image]', "#{Rails.root}/spec/factories/sample.jpg", make_visible: true
        fill_in 'user_name', with: 'updatemama'
        
        #更新ボタンをクリック
        click_button '更新'
        
        #正しく編集が完了した場合が表示される
        expect(page).to have_content 'updatemamaさんのユーザー情報を更新しました'
    end
    
end