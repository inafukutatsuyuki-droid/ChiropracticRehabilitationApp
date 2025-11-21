# 痛み原因セルフ判定アプリ

Flutter を用いたオフライン完結型のセルフチェックアプリです。問診ロジックは if / else の条件分岐のみで実装し、ローカル DB（sqflite）を利用して痛み日記を端末内に保存します。医療行為や診断を行うものではなく、注意文言を常時表示する方針です。

- プラットフォーム: Android（将来的に iOS 対応を想定）
- 状態管理: Riverpod
- データ保存: sqflite + path_provider
- ナビゲーション: go_router（シンプルな 3 画面 + 設定）
- 広告/課金: Google AdMob / 広告除去のアプリ内課金

## 進行中の設計メモ
詳細な画面構成・データモデル・判定ロジックの方針は [docs/architecture.md](docs/architecture.md) にまとめています。
