# Yamekaku

## ディレクトリ構成
本プロジェクトは Flutter × Firebase × Riverpod をベースにした MVVM アーキテクチャ を採用しています。
責務を明確に分離することで、テスト容易性・保守性・拡張性を担保しています。
```
lib/
├── application/               # ViewModel層（状態管理・ビジネスロジック）
│   └── auth_controller.dart   # 認証状態を管理（ログイン/ログアウト/ユーザー情報）
│
├── core/                      # アプリ全体で使う共通機能
│   └── router.dart            # GoRouterによるルーティング定義
│
├── data/                      # 外部I/O層（FirebaseやAPIとのやり取り）
│   └── auth_repository.dart   # FirebaseAuthのラッパ（サインイン/サインアウト）
│
├── presentation/              # UI層（Widget群）
│   └── pages/                 # 画面ごとのWidget
│       ├── auth_gate.dart     # 認証状態に応じて画面を出し分け
│       ├── login_page.dart    # ログイン画面
│       └── home_page.dart     # ホーム（ダッシュボード）
│
├── app.dart                   # MaterialApp.router やテーマ設定
├── firebase_options.dart      # Firebase CLI が生成する初期化設定
└── main.dart                  # アプリのエントリーポイント
```

## データフロー
```
UI (presentation)
   ↓ ref.watch / イベント
Controller (application)
   ↓ 呼び出し
Repository (data)
   ↓ Firebase / API
外部サービス
```