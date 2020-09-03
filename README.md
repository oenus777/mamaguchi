# ママぐち
[![CircleCI](https://circleci.com/gh/suneosama1/mamaguchi.svg?style=svg)](https://circleci.com/gh/suneosama1/mamaguchi)
![Website](https://img.shields.io/website?url=https%3A%2F%2Fwww.mamaguchi.xyz)  
![GitHub commit activity](https://img.shields.io/github/commit-activity/m/suneosama1/mamaguchi?style=plastic)  
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/suneosama1/mamaguchi?style=plastic)  
![GitHub repo size](https://img.shields.io/github/repo-size/suneosama1/mamaguchi)  
  
テストログイン  
E-mail:test@test.com  
Password:testtest3  

## URL
https://www.mamaguchi.xyz/

![mamaguchi](https://user-images.githubusercontent.com/30628476/90847333-36fed200-e3a5-11ea-9950-ee2bf8f406f0.png)

## 概要
少しでもママの負担を軽くし、ママが生きやすい社会を実現するSNSサービスです。

下記のルールを徹底することにより、ママの自己肯定感を高くします。  
・投稿してはいけない内容は無い  
・誹謗中傷、荒らし行為はしない  
・投稿されてる内容を受け止める  
・コメントは共感できる場合のみ  
・アドバイスは求められてるなら  

## 重点
・細かいテストケースで不具合を解消  
　ー細かい様々なケースのテストを記述し大きな不具合を無くしました。  
・開発、検証、リリースといったサイクルの効率化  
　ーWebサービスではスピードと品質の担保が重要だと思いCircleCIを導入し開発後の検証、リリースフェーズを自動化。  
・コンテナ基盤で軽量化、サーバーダウンの低下  
　ーDockerを使用し処理の軽量化と環境要因でのトラブル減少、またECSを使用しスケーラブルなリソース運用でサーバーダウンの低下を実現。  
・SEO対策の実装  
　ー前々職がSEO分析業務だった為、その時の知見を活かし開発に反映。(タイトルやh1タグにキーワードを含めるなど）  
　　対策キーワードも調査しボリュームがありサービスに適したキーワードの選定。  
・

## 構成
### インフラ
![aws](https://img.shields.io/badge/-Amazon%20AWS-232F3E.svg?logo=amazon-aws&style=flat)  
 VPC/ALB/ACM/Route53/ECS(EC2)/ECR/RDS/S3  
 
### フロントエンド
![html](https://img.shields.io/badge/-HTML5-333.svg?logo=html5&style=plastic)  
![css](https://img.shields.io/badge/-CSS3-1572B6.svg?logo=css3&style=plastic)  
![jquery](https://img.shields.io/badge/-jQuery-0769AD.svg?logo=jquery&style=plastic)  

### バックエンド
![rails](https://img.shields.io/badge/-Rails-CC0000.svg?logo=rails&style=plastic)  
 6.0.3.2  
![ruby](https://img.shields.io/badge/-Ruby-CC342D.svg?logo=ruby&style=plastic)  
 2.6.3  

### Webサーバー
![nginx](https://img.shields.io/badge/-Nginx-bfcfcf.svg?logo=nginx&style=plastic)  
 
### APサーバー
![puma](https://img.shields.io/badge/-Puma-FF00FF.svg?logo=puma&style=plastic)  

### データベース
![mysql](https://img.shields.io/badge/-MySQL-f29221.svg?logo=mysql&style=plastic)  
 
## クラウドアーキテクチャー
・常時SSL化、またHTTPS有無、WWW有無関わらず全てhttps://www.mamaguchi.xyz へリダイレクト  
・ロードバランサーで負荷分散  
・アプリケーションはコンテナ運用、ECS上で起動しオートスケーリングでタスク数を常に最適化  
・データーベースはRDS(MySQL)、ストレージはS3を使用  
・githubへpush requestするとCircleCIで自動テスト実行、テストをパスしたらdockerイメージをビルドしECRへpush、push完了後はTaskDefinitionを更新しECSのサービスも同時に更新され本番環境へデプロイされる。
  
![mamaguchi (1)](https://user-images.githubusercontent.com/30628476/90980874-dfc15300-e598-11ea-9f1b-fa92ad87cde0.png)


## 機能
・ユーザー認証機能（deviseで実装）  
　ーメール認証機能も有り  
・ユーザー情報編集機能  
　ープロフィール画像やユーザー名の変更、プロフィール画像のプレビュー表示  
・ログアウト機能（deviseで実装）  
・フォロー機能(ajax)
・新規投稿機能  
　ー画像を３枚までアップロード可能、タイトルとコンテンツを投稿できる、またカテゴリーも選択可能  
・投稿編集機能  
　ー投稿画像、タイトル、コンテンツを編集可能  
・投稿削除機能  
・イイね機能(ajax)  
・お気に入り登録機能(ajax)  
・コメント機能
・検索機能（ransuckで実装）  
　ータイトル、コンテンツを検索対象  
・カテゴリー機能  
・ランキング機能  
　ー直近１ヶ月間の全ての投稿、またカテゴリ内のイイね数が最も多い３つの投稿を表示  
・ページネーション機能（kaminariで実装）  


