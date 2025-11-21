# 痛み原因セルフ判定アプリ

Flutter を用いたオフライン完結型のセルフチェックアプリです。問診ロジックは if / else の条件分岐のみで実装し、ローカル DB（sqflite）を利用して痛み日記を端末内に保存します。医療行為や診断を行うものではなく、注意文言を常時表示する方針です。

- プラットフォーム: Android（将来的に iOS 対応を想定）
- 状態管理: Riverpod
- データ保存: sqflite + path_provider
- ナビゲーション: go_router（シンプルな 3 画面 + 設定）
- 広告/課金: Google AdMob / 広告除去のアプリ内課金

## セットアップ（ローカル開発）
1. Flutter SDK をインストールし、`flutter doctor` がパスすることを確認してください。
2. 依存パッケージを取得します。
   ```bash
   flutter pub get
   ```
3. エミュレータまたはデバイスを接続し、アプリを起動します。
   ```bash
   flutter run
   ```

## 主要なディレクトリ構成
- `lib/main.dart`: MaterialApp と go_router を利用したエントリポイント。
- `lib/theme/`: ブルー/ホワイト基調の Material 3 テーマ設定。
- `lib/router/`: 画面ルート定義（ホーム / 問診 / 結果 / 日記 / 設定）。
- `lib/features/`: 画面別 UI・ロジック（ホーム、問診、結果、日記、設定）。
- `lib/data/`: 問診モデル、診断結果モデル、ローカル DB（sqflite）とリポジトリ実装。
- `lib/logic/diagnosis_rules.dart`: if/else ベースの判定ロジックと注意サイン判定。

## 進行中の設計メモ
詳細な画面構成・データモデル・判定ロジックの方針は [docs/architecture.md](docs/architecture.md) にまとめています。
