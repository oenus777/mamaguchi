require 'rails_helper'

RSpec.feature 'categories', type: :system do
    given!(:post1) { create(:post) }
    given!(:user) { create(:user,:other) }
    
    #カテゴリ別ページのテストケース
    scenario 'カテゴリ別ページの要素検証' do
        #ログイン
        login(user)
        
        #カテゴリ別ページへアクセス
        visit category_path(1)
        
        #カテゴリ別ページの各項目を確認
        expect(page).to have_selector 'h1', text: 'カテゴリ別の投稿一覧'
        expect(page).to have_selector 'h2', text: 'カテゴリ：test'
        expect(all('.card')[0]).to have_selector 'img'
        expect(find('.card-title')).to have_content 'test'
        expect(find('.card-text')).to have_content 'test'
        expect(page).to have_css '.fa-clock'
        expect(page).to have_selector 'span', text: post1.created_at.strftime('%Y/%m/%d %H:%M')
        expect(page).to have_css '.fa-tag'
        expect(page).to have_selector 'span', text: 'test'
        expect(find('.user-info')).to have_selector 'img'
        expect(find('.user-info')).to have_content 'testmama'
        expect(find('.button-info')).to have_css '.fa-heart'
        expect(all('.button-info span')[0]).to have_content "0"
        expect(find('.button-info')).to have_css '.fa-comment'
        expect(all('.button-info span')[1]).to have_content "0"
        #カテゴリー一覧の項目を確認
        expect(find('#category_list .card-header')).to have_content 'カテゴリ一覧'
        expect(find('#category_list .category-lists')).to have_link 'test'
        #カテゴリー内で共感された投稿（１か月間）の項目を確認
        expect(find('#likes_for_month .card-header')).to have_content 'カテゴリ内で共感された投稿(１か月間)'
    end
    
    scenario 'イイねした投稿がカテゴリ内で共感された投稿(１か月間)に反映', js: true do
        #ログイン
        login(user)
        
        #投稿詳細ページへアクセスしイイねボタンをクリック
        visit post_path(1)
        find('.fa-heart').click
        
        #カテゴリ別ページへアクセスしカテゴリ内で共感された投稿(１か月間)に反映されていることを確認
        visit category_path(1)
        expect(find('#likes_for_month .title-header')).to have_content "タイトル"
        expect(find('#likes_for_month .card-title')).to have_link "test"
        expect(all('#likes_for_month .card-title span')[1]).to have_content "1"
    end
end