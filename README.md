# [焼鳥情報コミュニティ 〜とりコミュ〜](https://yakitori-community.tk/)
- テスト用ユーザーでログインできます。(詳細は`「機能」`項目に記載)
[![Image from Gyazo](https://i.gyazo.com/bd762912ba7a389042e637b83e4a8d47.jpg)](https://gyazo.com/bd762912ba7a389042e637b83e4a8d47)

## 概要
---
### このアプリは、焼き鳥情報共有アプリです。
 ユーザーが実際に行かれた 焼鳥店についての感想、おすすめの焼き鳥、店舗情報を確認することが出来ます。

## 制作背景
---
 焼き鳥について情報共有出来るアプリを作ってみたいと思い、制作致しました。以前勤めていました焼鳥屋で、お客様から度々「この焼き鳥、どこの部位？」と聞かれることが多く、最初から焼き鳥について知っていたら、お店の良さをより感じてくれるのではと思い、構想し、制作に至りました。



## 開発・本番環境
---
**Ruby/Ruby on Rails/Mysql/html・scss(FW: Bulma)/JavaScript・jQuery/AWS(EC2)**

## 機能
---
- ユーザー登録機能（メール、Google・twitter認証）
  - メール、Google・twitter認証の３種類でアカウントを作成できます。
  - ログインページにテストユーザー用ログインを配置しています。
[![Image from Gyazo](https://i.gyazo.com/7cdbc35aa44edf6c33c422f3182e7ba3.jpg)](https://gyazo.com/7cdbc35aa44edf6c33c422f3182e7ba3)
>
- 記事一覧表示機能(ページネーション)
- 記事詳細表示機能（モーダル）
- コメント機能（非同期対応）
  　- 未ログインでも操作可能です。
  　- コメントの打ち込みはログインしないと出来ません。
[![Image from Gyazo](https://i.gyazo.com/bc8c61f1c68e732ca9b945b5f7930135.gif)](https://gyazo.com/bc8c61f1c68e732ca9b945b5f7930135)
>
- ぐるなびAPIでの飲食店名、ぐるなび店舗詳細リンクの登録機能
- カテゴリー（焼き鳥の種類別）機能
  - テストユーザーでログイン後、トップページ左上の「投稿ボタン」をクリックして頂くと、機能をご覧になれます。
[![Image from Gyazo](https://i.gyazo.com/6cd2b4a45db81198f9337c2060fbdfce.gif)](https://gyazo.com/6cd2b4a45db81198f9337c2060fbdfce)
>
- freenomでドメイン取得、EC2と結びつけ
- AWSでroutes53・SSL・LoadBalancer・S3の設定

## これから実装したい機能
---
- いいね機能
- 検索機能
- ランキング機能（店舗、カテゴリー別）
## ER図
---
[![Image from Gyazo](https://i.gyazo.com/808233974000b2631aaf11366eb11c86.png)](https://gyazo.com/808233974000b2631aaf11366eb11c86)