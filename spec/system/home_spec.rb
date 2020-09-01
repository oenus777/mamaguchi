require 'rails_helper'

RSpec.feature 'home', type: :system do
    given!(:post1) { create(:post) }
    given!(:user) { create(:user,:other) }
    
    #トップページのテストケース
    scenario '未ログイン時、トップページの要素検証' do
        #トップページへアクセス
        visit root_path
        
        #トップページの各項目を確認
        expect(page).to have_selector 'img'
        expect(page).to have_selector 'h1', text: '人に言えない悩みや愚痴がある子育て中のママへ'
        expect(page).to have_link '投稿する'
        expect(page).to have_selector 'h2', text: '新着投稿一覧'
        expect(page).to have_selector 'p', text: '投稿一覧を全て見たい方はログインしてください。'
        expect(page).to have_link 'ログイン'
        #投稿カードの項目を確認
        expect(all('.card')[0]).to have_selector 'img'
        expect(find('.card-title')).to have_content 'test'
        expect(find('.card-text')).to have_content 'testtest'
        expect(page).to have_css '.fa-clock'
        expect(page).to have_selector 'span', text: post1.created_at.strftime('%Y/%m/%d %H:%M')
        expect(page).to have_css '.fa-tag'
        expect(page).to have_selector 'span', text: 'test'
        expect(find('.button-info')).to have_css '.fa-heart'
        expect(all('.button-info span')[0]).to have_content "0"
        expect(find('.button-info')).to have_css '.fa-comment'
        expect(all('.button-info span')[1]).to have_content "0"
    end
    
    scenario 'ログイン時、トップページの要素検証（ユーザーをフォローしていない場合）' do
        #ログイン
        login(post1.user)
        
        #トップページへアクセス
        visit root_path
        
        #トップページの各項目を確認
        expect(page).to have_selector 'h1', text: 'ホーム画面'
        expect(page).to have_css '.profile_image'
        expect(page).to have_selector 'p'
        expect(page).to have_selector 'h2', text: 'タイムライン'
        expect(page).to have_selector 'p', text: 'ユーザーをフォローしていません'
        #カテゴリー一覧の項目を確認
        expect(find('#category_list .card-header')).to have_content 'カテゴリ一覧'
        expect(find('#category_list .category-lists')).to have_link 'test'
        #最も共感された投稿（１か月間）
        expect(find('#all_for_month .card-header')).to have_content '最も共感された投稿(１か月間)'
    end
    
    scenario 'ログイン時、トップページの要素検証（ユーザーをフォローしている場合）' do
        #ログインしユーザーをフォロー
        login(user)
        visit user_path(1)
        click_on 'フォロー'
        
        #トップページへアクセス
        visit root_path
        
        #トップページの各項目を確認
        expect(page).to have_selector 'h1', text: 'ホーム画面'
        expect(page).to have_css '.profile_image'
        expect(page).to have_selector 'p'
        expect(page).to have_selector 'h2', text: 'タイムライン'
        #投稿カードの項目を確認
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
        #最も共感された投稿（１か月間）
        expect(find('#all_for_month .card-header')).to have_content '最も共感された投稿(１か月間)'
    end
    
    scenario '最も共感された投稿（一か月間）に反映される', js: true do
        #ログイン
        login(user)

        #投稿詳細ページへアクセス
        visit post_path(1)
        
        #イイねボタンをクリックし投稿一覧へアクセス
        find('.fa-heart').click
        visit root_path
        
        #最も共感された投稿（１か月間）に反映されていることを確認
        expect(find('#all_for_month .title-header')).to have_content "タイトル"
        expect(find('#all_for_month .card-title')).to have_link "test"
        expect(all('#all_for_month .card-title span')[1]).to have_content "1"
    end
    
    #aboutページのテストケース
    scenario 'アバウトページの要素検証' do
        #アバウトページへアクセス
        visit about_path
        
        #アバウトページの各項目を確認
        expect(page).to have_selector 'h1', text: '投稿者の心理的安全を第一に'
        expect(page).to have_selector 'img'
        expect(page).to have_selector 'h2', text: '自分に溜め込んでいませんか？'
        expect(page).to have_selector 'p', text: '子育てをしていて抱える悩みや愚痴 人に話したいけど話してもどうせ分かってもらえない twitterやfacebook、その他SNSサービスに投稿しても 見ず知らずの人に叩かれたり、炎上しちゃうかも だったら自分一人で抱え込めば良い。。とか こんな考えを抱く私が親として失格なんだ。。と 上の写真のように自分を自分で否定したり 悩みや愚痴を溜め込んでいませんか。'
        expect(page).to have_selector 'h2', text: '投稿から繋がるお世話の原動力'
        expect(page).to have_selector 'p', text: '子供が可愛いからこそ抱えている悩みのギャップに苦しんでいるはず だからといって溜め込むのは精神的にも不健康。 ママぐちでは匿名での書き込み、リアルの繋がりも無いので人目を気にせず投稿できます。 少しでもママの負担を減らし笑顔が増え、楽しい家庭が増えたら良いなと思っています。'
        expect(page).to have_selector 'h2', text: 'サイト利用者の心構え'
        expect(page).to have_selector 'li', text: '投稿してはいけない内容は無い'
        expect(page).to have_selector 'li', text: '誹謗中傷、荒らし行為はしない'
        expect(page).to have_selector 'li', text: '投稿されてる内容を受け止める'
        expect(page).to have_selector 'li', text: 'コメントは共感できる場合のみ'
        expect(page).to have_selector 'li', text: 'アドバイスは求められてるなら'
        expect(page).to have_selector 'h2', text: '運営側の方針'
        expect(page).to have_selector 'p', text: '上記、サイト利用者の心構えに適さない投稿などを発見した場合 直ちに投稿、またはコメントを削除させて頂きます。 サイト利用者の心理的安全を守る為の判断と ご理解頂けますと幸いでございます。'
        expect(page).to have_selector 'h2', text: '運営者より'
        expect(page).to have_selector 'p', text: '妻の話を聞く中で世間の母親に対する母親像と 妻が抱える悩みとのギャップが母親の孤立感を増やすのでは無いかと思い 人に言えないどんな悩みや愚痴も投稿できるサービスを始めました。 旦那さん、両親や友達、SNSなどに言えないママさんの孤立感を少しでも 和らげることが出来たら良いなと考えています。 改善してほしい点などありましたら随時、受け付けております。 どうぞ宜しくお願い致します。'
    end
end