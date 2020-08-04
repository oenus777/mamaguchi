require 'rails_helper'

RSpec.feature 'posts', type: :system do
    given!(:user) { create(:user) }
    given!(:post1) { create(:post,:other) }
    given!(:category) { create(:category) }
    
    #投稿一覧のテストケース
    scenario '投稿一覧ページの要素検証' do
        #ログイン
        login(user)
        
        #投稿一覧ページへアクセスしインスタンスへセット
        visit posts_path
        @post = Post.find(2)
        
        #投稿一覧ページの各項目を確認
        expect(page).to have_selector 'h1', text: 'みんなの投稿'
        expect(page).to have_link '投稿する'
        expect(page).to have_selector 'h2', text: '新着投稿一覧'
        #投稿カードの項目を確認
        expect(all('.card')[0]).to have_selector 'img'
        expect(find('.card-title')).to have_content 'other'
        expect(find('.card-text')).to have_content 'otherother'
        expect(page).to have_css '.fa-clock'
        expect(page).to have_selector 'span', text: @post.created_at.strftime('%Y/%m/%d %H:%M')
        expect(page).to have_css '.fa-tag'
        expect(page).to have_selector 'span', text: 'testtest'
        expect(find('.user-info')).to have_selector 'img'
        expect(find('.user-info')).to have_content 'othermama'
        expect(find('.button-info')).to have_css '.fa-heart'
        expect(all('.button-info span')[0]).to have_content "0"
        expect(find('.button-info')).to have_css '.fa-comment'
        expect(all('.button-info span')[1]).to have_content "0"
        #カテゴリー一覧の項目を確認
        expect(find('#category_list .card-header')).to have_content 'カテゴリ一覧'
        expect(find('#category_list .category-lists')).to have_link 'testtest'
        #最も共感された投稿（１か月間）
        expect(find('#all_for_month .card-header')).to have_content '最も共感された投稿(１か月間)'
    end
    
    scenario '最も共感された投稿（一か月間）に反映される', js: true do
        #ログイン
        login(user)

        #投稿詳細ページへアクセス
        visit post_path(2)
        
        #イイねボタンをクリックし投稿一覧へアクセス
        find('.fa-heart').click
        visit posts_path
        
        #最も共感された投稿（１か月間）に反映されていることを確認
        expect(find('#all_for_month .title-header')).to have_content "タイトル"
        expect(find('#all_for_month .card-title')).to have_link "other"
        expect(all('#all_for_month .card-title span')[1]).to have_content "1"
    end
    
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
    
    #投稿詳細機能のテストケース
    scenario 'ユーザーが投稿した投稿詳細ページの要素検証' do
        #ログイン
        login(user)
        
        #新規投稿しインスタンスにセット
        create_post
        @post = Post.find(3)
        
        #投稿詳細ページへアクセス
        visit post_path(3)
        
        #投稿詳細ページの各項目を確認
        expect(page).to have_selector 'h1', text: '投稿内容'
        expect(page).to have_selector 'h2', text: 'test'
        expect(page).to have_css '.fa-tag'
        expect(page).to have_selector 'span', text: 'test'
        expect(page).to have_css '.fa-clock'
        expect(page).to have_selector 'span', text: @post.created_at.strftime('%Y/%m/%d %H:%M')
        expect(page).to have_selector 'p', text: 'testtest'
        expect(page).to have_link '編集'
        expect(page).to have_link '削除'
        expect(page).to have_css '.profile_image_small'
        expect(page).to have_link 'testmama'
        expect(page).to have_selector 'label', text: 'コメント一覧'
        expect(page).to have_selector 'p', text: 'コメントがありません。'
        expect(page).to have_selector 'label', text: 'コメントを書く'
        expect(page).to have_field("コメントを書く", placeholder: "コメントを１０００文字以内で入力")
        expect(page).to have_button '書き込み'
        expect(page).to have_selector 'div', text: 'カテゴリ内で共感された投稿(１か月間)'
    end
    
    scenario '他ユーザーが投稿した投稿詳細ページの要素検証' do
        #ログイン
        login(user)
        
        #他ユーザーの投稿をインスタンスにセット
        @post = Post.find(2)
        
        #投稿詳細ページへアクセス
        visit post_path(2)
        
        #投稿詳細ページの各項目を確認
        expect(page).to have_selector 'h1', text: '投稿内容'
        expect(page).to have_selector 'h2', text: 'other'
        expect(page).to have_css '.fa-tag'
        expect(page).to have_selector 'span', text: 'test'
        expect(page).to have_css '.fa-clock'
        expect(page).to have_selector 'span', text: @post.created_at.strftime('%Y/%m/%d %H:%M')
        expect(page).to have_selector 'p', text: 'otherothe'
        expect(page).to have_css '.fa-heart'
        expect(page).to have_css '.fa-star'
        expect(page).to have_css '.profile_image_small'
        expect(page).to have_link 'testmama'
        expect(page).to have_selector 'label', text: 'コメント一覧'
        expect(page).to have_selector 'p', text: 'コメントがありません。'
        expect(page).to have_selector 'label', text: 'コメントを書く'
        expect(page).to have_field("コメントを書く", placeholder: "コメントを１０００文字以内で入力")
        expect(page).to have_button '書き込み'
        expect(page).to have_selector 'div', text: 'カテゴリ内で共感された投稿(１か月間)'
    end
    
    scenario 'コメントを書くとコメント一覧に反映される' do
        #ログイン
        login(user)
        
        #新規投稿
        create_post
        
        #投稿詳細ページへアクセス
        visit post_path(3)
        
        #コメントが無いことを確認
        expect(page).to have_selector 'p', text: 'コメントがありません。'
        expect(page).to have_no_css '.comment'
        expect(page).to have_no_css '#comment_area'
        
        #コメントを入力し書き込みボタンをクリック
        fill_in 'comment_comment', with: 'comment'
        click_button '書き込み'
        
        #コメントが反映されていることを確認
        expect(page).to have_css '.comment'
        expect(page).to have_css '#comment_area'
    end
    
    scenario 'イイねボタンを押すと増減が反映される', js: true do
        #ログイン
        login(user)

        #投稿詳細ページへアクセス
        visit post_path(2)
        
        #イイねボタンのカウントが０であることを確認
        expect(find('.like span')).to have_content "0"
        
        #イイねボタンをクリックしカウントが１であることを確認
        find('.fa-heart').click
        expect(find('.like span')).to have_content "1"
    end
    
    scenario 'イイねボタンをクリックするとカテゴリ内で共感された投稿（一か月間）に反映される', js: true do
        #ログイン
        login(user)

        #投稿詳細ページへアクセス
        visit post_path(2)
        
        #イイねボタンをクリックし再度アクセスするとサイドバーに反映されていることを確認
        find('.fa-heart').click
        visit post_path(2)
        expect(find('.title-header')).to have_content "タイトル"
        expect(find('.card-title')).to have_link "other"
        expect(all('.card-title span')[1]).to have_content "1"
    end
    
    scenario 'お気に入りボタンを押すと増減が反映される', js: true do
        #ログイン
        login(user)

        #投稿詳細ページへアクセス
        visit post_path(2)
        
        #お気に入りボタンのカウントが０であることを確認
        expect(find('.favorite span')).to have_content "0"
        
        #お気に入りボタンをクリックしカウントが１であることを確認
        find('.fa-star').click
        expect(find('.favorite span')).to have_content "1"
    end
    
    #投稿編集機能のテストケース
    scenario '編集画面の要素検証' do
        #ログイン
        login(user)
        
        #新規投稿
        create_post
        
        #投稿詳細ページへアクセス
        visit post_path(3)
        
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
        visit post_path(3)
        
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
        visit post_path(3)
        
        #編集リンクをクリック
        click_on '削除'
        
        #正しく削除後の画面が表示されているか確認
        expect(page).to have_content 'testを削除しました'
        expect(page).to have_content 'タイムライン'
    end
    
    #投稿検索機能のテストケース
    scenario '検索キーワードが合致した検索結果の要素検証' do
        #ログイン
        login(user)

        #検索結果に入力し検索ボタンをクリック、インスタンスにセット
        fill_in 'q_title_or_content_cont', with: 'other'
        click_button '検索'
        @post = Post.find(2)
        
        #検索結果ページの各項目を確認
        expect(all('.card')[0]).to have_selector 'img'
        expect(find('.card-title')).to have_content 'other'
        expect(find('.card-text')).to have_content 'otherother'
        expect(page).to have_css '.fa-clock'
        expect(page).to have_selector 'span', text: @post.created_at.strftime('%Y/%m/%d %H:%M')
        expect(page).to have_css '.fa-tag'
        expect(page).to have_selector 'span', text: 'testtest'
        expect(find('.user-info')).to have_selector 'img'
        expect(find('.user-info')).to have_content 'othermama'
        expect(find('.button-info')).to have_css '.fa-heart'
        expect(all('.button-info span')[0]).to have_content "0"
        expect(find('.button-info')).to have_css '.fa-comment'
        expect(all('.button-info span')[1]).to have_content "0"
    end
    
    scenario '検索キーワードが合致しない検索結果の要素検証' do
        #ログイン
        login(user)

        #検索結果に入力し検索ボタンをクリック
        fill_in 'q_title_or_content_cont', with: 'a'
        click_button '検索'
        
        #検索結果ページの各項目を確認
        expect(page).to have_selector 'p', text: "該当する投稿内容がありません。"
    end
end