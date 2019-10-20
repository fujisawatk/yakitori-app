# 焼鳥情報コミュニティ 〜とりコミュ〜
https://yakitori-community.tk/
- テスト用ユーザーでログインできます。(詳細は`「機能」`項目に記載)
[![Image from Gyazo](https://i.gyazo.com/80b0d29fc2fe5bba37de99789cada7eb.jpg)](https://gyazo.com/80b0d29fc2fe5bba37de99789cada7eb)

## 概要
---
### このアプリは、焼き鳥情報共有アプリです。
 ユーザーが実際に行かれた 焼鳥店についての感想、おすすめの焼き鳥、店舗情報を確認することが出来ます。

## 制作背景
---
 焼き鳥について情報共有出来るアプリを作ってみたいと思い、制作致しました。以前勤めていました焼鳥屋で、お客様から度々「この焼き鳥、どこの部位？」と聞かれることが多く、最初から焼き鳥について知っていたら、お店の良さをより感じてくれるのではと思い、制作に至りました。



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
- 記事詳細、編集、削除表示機能
- コメント機能（非同期対応）
  - 記事詳細、投稿済コメントは未ログインでも閲覧可能です。
  - 記事編集、削除、コメント投稿はログインして頂くと、使用出来ます。
[![Image from Gyazo](https://i.gyazo.com/65eef43941c7d27c3a7a19887842a676.gif)](https://gyazo.com/65eef43941c7d27c3a7a19887842a676)
>
- ぐるなびAPIでの飲食店名、ぐるなび店舗詳細リンクの登録機能
- カテゴリー（焼き鳥の種類別）機能
  - テストユーザーでログイン後、トップページ左上の「投稿ボタン」をクリックして頂くと、機能をご覧になれます。
[![Image from Gyazo](https://i.gyazo.com/6cd2b4a45db81198f9337c2060fbdfce.gif)](https://gyazo.com/6cd2b4a45db81198f9337c2060fbdfce)
>
- いいね機能
  - ログインして頂くと、機能を使用出来ます。
[![Image from Gyazo](https://i.gyazo.com/ced03eb0cadedb87de398d57c296e631.gif)](https://gyazo.com/ced03eb0cadedb87de398d57c296e631)
>
- 検索機能
  - 未ログインでも使用可能です。
  - キーワードを入力することで、タイトル、本文、店舗名から該当する記事を表示します。
[![Image from Gyazo](https://i.gyazo.com/75573086cb52ce1adaa28542d45ad147.gif)](https://gyazo.com/75573086cb52ce1adaa28542d45ad147)
>
- バリデーションテスト
- レスポンシブ対応
- freenomでドメイン取得、EC2と結びつけ
- AWSでroutes53・SSL・LoadBalancer・S3の設定

## これから実装したい機能
---
- フォロー機能
## ER図
---
[![Image from Gyazo](https://i.gyazo.com/9504f8cfacfa837c162ece0af6235492.png)](https://gyazo.com/9504f8cfacfa837c162ece0af6235492)