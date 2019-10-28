# 焼鳥情報共有アプリ　〜とりコミュ〜

## 本アプリについて
URL: https://yakitori-community.tk/
>
ログイン画面の「テストユーザーログイン」ボタンをクリックして頂きますと、１クリックでログイン可能です。

※ご覧になられた後は、お手数ですが、必ずログアウトをお願い致します。

## 概要
本アプリのコンセプトは、「焼き鳥についての情報共有アプリ」です。以前勤めていました焼鳥屋の経験で、お客様が焼き鳥についてより詳しい情報を持つことで、お店の焼き鳥の良さを感じてくれるのではと考え、制作に至りました。

## 機能一覧並びに使用技術
- **フロントエンド**
  - html/scssでのマークアップ
  - CSSフレームワーク「Bulma」とメディアクエリを使用し、レスポンシブデザイン化
- **サーバーサイド**
  - ユーザー登録機能（gem Deviseを利用）
  - Twitter及びGoogleアカウントでのログイン機能（gem OmniAuthを利用）
  - 記事投稿（&編集・削除）機能(「ぐるなびAPI」で店舗情報登録、焼き鳥の種類別でのカテゴリー登録)
  - 検索機能（タイトル、本文、店舗名からキーワード検索）
  - コメント機能（非同期）
  - いいね機能
  - 単体テスト（RSpecによるバリデーションテスト）
  - 統合テスト（System SpecによるE2Eテスト,gem simplecovによるテストカバレッジの計測）
- **インフラ**
  - Capistrano による EC2 インスタンスへの自動デプロイ
  - DB として、Amazon RDS(MySQL)を使用
  - freenomにてドメイン取得、Route53 で独自ドメインを設定し、ELB をエンドポイントとして常時SSL化
  - Amazon S3 に画像ファイルを保存

## 参考資料
- **記事投稿時の「ぐるなびAPI」店舗情報登録**
[![Image from Gyazo](https://i.gyazo.com/6cd2b4a45db81198f9337c2060fbdfce.gif)](https://gyazo.com/6cd2b4a45db81198f9337c2060fbdfce)
>
- **いいね機能**
>
[![Image from Gyazo](https://i.gyazo.com/ced03eb0cadedb87de398d57c296e631.gif)](https://gyazo.com/ced03eb0cadedb87de398d57c296e631)
>
- **検索機能**
>
[![Image from Gyazo](https://i.gyazo.com/75573086cb52ce1adaa28542d45ad147.gif)](https://gyazo.com/75573086cb52ce1adaa28542d45ad147)
>
- **インフラ構成（AWS）**
>
[![Image from Gyazo](https://i.gyazo.com/c3223b979f03ce9b130d2e9848b0b686.png)](https://gyazo.com/c3223b979f03ce9b130d2e9848b0b686)
>
- **ER図**
>
[![Image from Gyazo](https://i.gyazo.com/426070dd60f75f98c757f10a963f666e.png)](https://gyazo.com/426070dd60f75f98c757f10a963f666e)

## これから実装したい機能
- フォロー機能
- 都道府県登録、検索機能
