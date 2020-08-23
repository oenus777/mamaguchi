# ママぐち
[![CircleCI](https://circleci.com/gh/suneosama1/mamaguchi.svg?style=svg)](https://circleci.com/gh/suneosama1/mamaguchi)
![Website](https://img.shields.io/website?url=https%3A%2F%2Fwww.mamaguchi.xyz)  
![GitHub commit activity](https://img.shields.io/github/commit-activity/m/suneosama1/mamaguchi?style=plastic)  
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/suneosama1/mamaguchi?style=plastic)  
![GitHub repo size](https://img.shields.io/github/repo-size/suneosama1/mamaguchi)  


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
 Puma  
 
### データベース
![mysql](https://img.shields.io/badge/-MySQL-f29221.svg?logo=mysql&style=plastic)  
 
## クラウドアーキテクチャー
・常時SSL化、またHTTPS有無、WWW有無関わらず全てhttps://www.mamaguchi.xyz へリダイレクト  
・ロードバランサーで負荷分散  
・アプリケーションはコンテナ運用、ECS上で起動しオートスケーリングでタスク数を常に最適化  
・データーベースはRDS(MySQL)、ストレージはS3を使用  
・githubへpush requestするとCircleCIで自動テスト実行、テストをパスしたらdockerイメージをビルドしECRへpush  
 push完了後はTaskDefinitionを更新しECSのサービスも同時に更新され本番環境へデプロイされる。

![mamaguchi (1)](https://user-images.githubusercontent.com/30628476/90980874-dfc15300-e598-11ea-9f1b-fa92ad87cde0.png)


## Usage
