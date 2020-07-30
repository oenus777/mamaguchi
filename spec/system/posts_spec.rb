require 'rails_helper'

RSpec.feature 'posts', type: :system do
    given!(:user) { create(:user) }
    given!(:category) { create(:category) }
    
    #新規投稿機能のテストケース
    scenario '新規投稿ページの要素検証' do
        #ログイン
        login(user)
        
        #新規投稿ページへアクセス
        visit new_post_path
        
        #新規投稿ページの各項目を確認
        expect(page).to have_selector 'h1', text: '新規投稿'
        expect(page).to have_selector 'label', text: '投稿画像(３枚まで)'
        expect(page).to have_selector 'pre', text: 'アップロード'
        expect(page).to have_selector 'label', text: 'タイトル'
        expect(page).to have_selector 'label', text: '投稿内容'
        expect(page).to have_selector 'label', text: 'カテゴリー'
        expect(page).to have_selector 'select', text: '選択してください'
        expect(page).to have_button '投稿'
    end
    
    scenario '投稿できる' do
        #ログイン
        login(user)
        
        #新規投稿ページへアクセス
        visit new_post_path
        
        #新規投稿ページの各入力フィールドに入力
        fill_in 'post_title', with: 'test'
        fill_in 'post_content', with: 'testtesttest'
        select 'test', from: 'post_category_id'

        #投稿ボタンをクリック
        click_button '投稿'
        
        #成功メッセージが表示
        expect(page).to have_content 'testを新規投稿しました'
    end
    
    scenario '画像（1枚）をアップロードし投稿できる', js: true do
        #ログイン
        login(user)
        
        #新規投稿ページへアクセス
        visit new_post_path
        
        #画像をアップロードしプレビューが表示されている。
        attach_file 'post_images_0', "#{Rails.root}/spec/factories/sample.jpg", make_visible: true
        expect(page).to have_css '#upload_image_0'
        #新規投稿ページの各入力フィールドに入力
        fill_in 'post_title', with: 'test'
        fill_in 'post_content', with: 'testtesttest'
        select 'test', from: 'post_category_id'

        #投稿ボタンをクリック
        click_button '投稿'
        
        #成功メッセージが表示
        expect(page).to have_content 'testを新規投稿しました'
    end
    
    scenario '画像（３枚）をアップロードし投稿できる', js: true do
        #ログイン
        login(user)
        
        #新規投稿ページへアクセス
        visit new_post_path
        
        #画像をアップロードしプレビューが表示されている。
        attach_file 'post_images_0', "#{Rails.root}/spec/factories/sample.jpg", make_visible: true
        expect(page).to have_css '#upload_image_0'
        attach_file 'post_images_1', "#{Rails.root}/spec/factories/sample.jpg", make_visible: true
        expect(page).to have_css '#upload_image_1'
        attach_file 'post_images_2', "#{Rails.root}/spec/factories/sample.jpg", make_visible: true
        expect(page).to have_css '#upload_image_2'
        #新規投稿ページの各入力フィールドに入力
        fill_in 'post_title', with: 'test'
        fill_in 'post_content', with: 'testtesttest'
        select 'test', from: 'post_category_id'

        #投稿ボタンをクリック
        click_button '投稿'
        
        #成功メッセージが表示
        expect(page).to have_content 'testを新規投稿しました'
    end
    
    scenario '画像（４枚）をアップロードし投稿できない', js: true do
        #ログイン
        login(user)
        
        #新規投稿ページへアクセス
        visit new_post_path
        
        #画像をアップロードしプレビューが表示されている。
        attach_file 'post_images_0', "#{Rails.root}/spec/factories/sample.jpg", make_visible: true
        expect(page).to have_css '#upload_image_0'
        attach_file 'post_images_1', "#{Rails.root}/spec/factories/sample.jpg", make_visible: true
        expect(page).to have_css '#upload_image_1'
        attach_file 'post_images_2', "#{Rails.root}/spec/factories/sample.jpg", make_visible: true
        expect(page).to have_css '#upload_image_2'
        #３枚アップロードするとアップロードボタンが表示されない
        expect(page).to have_no_css '#post_images_3'
        #新規投稿ページの各入力フィールドに入力
        fill_in 'post_title', with: 'test'
        fill_in 'post_content', with: 'testtesttest'
        select 'test', from: 'post_category_id'

        #投稿ボタンをクリック
        click_button '投稿'
        
        #成功メッセージが表示
        expect(page).to have_content 'testを新規投稿しました'
    end
    
    scenario 'タイトルがブランクの場合' do
        #ログイン
        login(user)
        
        #新規投稿ページへアクセス
        visit new_post_path
        
        #新規投稿ページの各入力フィールドに入力
        fill_in 'post_title', with: ''
        fill_in 'post_content', with: 'testtesttest'
        select 'test', from: 'post_category_id'

        #投稿ボタンをクリック
        click_button '投稿'
        
        #エラーメッセージが表示
        expect(page).to have_content 'タイトルを入力してください'
    end
    
    scenario '投稿内容がブランクの場合' do
        #ログイン
        login(user)
        
        #新規投稿ページへアクセス
        visit new_post_path
        
        #新規投稿ページの各入力フィールドに入力
        fill_in 'post_title', with: 'test'
        fill_in 'post_content', with: ''
        select 'test', from: 'post_category_id'

        #投稿ボタンをクリック
        click_button '投稿'
        
        #エラーメッセージが表示
        expect(page).to have_content '投稿内容を入力してください'
    end
    
    scenario 'カテゴリーが選択されていない場合' do
        #ログイン
        login(user)
        
        #新規投稿ページへアクセス
        visit new_post_path
        
        #新規投稿ページの各入力フィールドに入力
        fill_in 'post_title', with: 'test'
        fill_in 'post_content', with: 'testtesttest'

        #投稿ボタンをクリック
        click_button '投稿'
        
        #エラーメッセージが表示
        expect(page).to have_content 'カテゴリーを入力してください'
    end
    
    #投稿編集機能のテストケース
    scenario '編集画面の要素検証' do
        #ログイン
        login(user)
        
        #新規投稿
        create_post
        
        #投稿詳細ページへアクセス
        visit post_path(1)
        
        #編集リンクをクリック
        click_on '編集'
        
        #投稿編集ページの各項目を確認
        expect(page).to have_selector 'h1', text: '投稿内容を編集'
        expect(page).to have_selector 'label', text: '投稿画像(３枚まで)'
        expect(page).to have_selector 'label', text: 'タイトル'
        expect(page).to have_selector 'label', text: '投稿内容'
        expect(page).to have_button '保存'
    end
    
    scenario '投稿を編集できる' do
        #ログイン
        login(user)
        
        #新規投稿
        create_post
        
        #投稿詳細ページへアクセス
        visit post_path(1)
        
        #編集リンクをクリック
        click_on '編集'
        
        #投稿内容の各フィールドを編集
        attach_file 'post_images', "#{Rails.root}/spec/factories/after_sample.jpg"
        fill_in 'post_title', with: 'title2'
        fill_in 'post_content', with: 'content2'
        
        #保存ボタンをクリック
        click_button '保存'
        
        #正しく編集後の画面が表示されているか確認
        expect(page).to have_content 'title2の編集が完了しました'
        expect(page).to have_content 'title2'
        expect(page).to have_content 'content2'
    end
    
    #投稿削除機能のテストケース
    scenario '投稿が削除できる' do
        #ログイン
        login(user)
        
        #新規投稿
        create_post
        
        #投稿詳細ページへアクセス
        visit post_path(1)
        
        #編集リンクをクリック
        click_on '削除'
        
        #正しく削除後の画面が表示されているか確認
        expect(page).to have_content 'testを削除しました'
        expect(page).to have_content 'タイムライン'
    end
end