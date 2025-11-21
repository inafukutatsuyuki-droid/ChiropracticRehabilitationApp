# 痛み原因セルフ判定アプリ 設計メモ

このドキュメントは、オフライン完結型の痛み原因セルフ判定アプリ（Flutter製）の初期設計方針をまとめたものです。サーバーやクラウドサービスは利用せず、端末内処理とローカルDBのみで完結させます。

## 技術スタック概要
- Flutter（Dart）/ Material 3 有効化
- 状態管理: Riverpod（`riverpod` / `flutter_riverpod`）
- ナビゲーション: `go_router`（Navigator 1.0 互換のシンプル構成でも移行可能）
- ローカルDB: `sqflite` + `path_provider`
- 広告: `google_mobile_ads`（広告除去はアプリ内課金で制御）
- 課金: `in_app_purchase`（広告除去のみを想定）
- その他: `url_launcher`（YouTube 外部ブラウザ起動用）

## パッケージ導入方針
`pubspec.yaml` に以下を追加する想定です。
- UI/テーマ: Material 3 + ColorScheme（ブルー/ホワイト基調、落ち着いたトーン）
- 状態管理: `flutter_riverpod`
- ルーティング: `go_router`
- DB: `sqflite`, `path_provider`
- 広告/IAP: `google_mobile_ads`, `in_app_purchase`
- その他: `url_launcher`

## アプリ構成
```
lib/
  main.dart                // MaterialApp + go_router ルート登録
  theme/app_theme.dart     // ColorScheme とテキストテーマ
  router/app_router.dart   // 画面ルート定義
  features/
    home/
    questionnaire/
    result/
    diary/
    settings/
  data/
    models/                // 問診モデル・判定結果モデル
    db/                    // sqflite DAO / 初期化
    repository/            // 日記保存・読み出し
  logic/
    diagnosis_rules.dart   // if/else ベースの判定ロジック
```

## 画面とルーティング
- `/home`: ホーム
  - 「セルフチェックをはじめる」ボタン
  - 直近の痛み記録（1〜3件）表示
  - メニュー: 「痛み日記を見る」, 「アプリの説明・免責」
- `/questionnaire`: 問診フロー（5〜10問, 1問ずつカード表示）
- `/result`: 判定結果画面
- `/diary`: 痛み日記一覧
- `/settings`: 課金・免責・アプリ説明

## 問診データモデル（例）
```dart
class PainQuestion {
  final String id;
  final String title;
  final List<String> options;
  final bool multiSelect;
}

class PainAnswer {
  final String questionId;
  final List<String> selected;
}

class QuestionnaireState {
  final int currentIndex;
  final List<PainAnswer> answers;
}
```
- 共通項目: 痛み部位（腰/肩/膝）、痛みの性質、発症きっかけ、期間、痛みレベル (1-10)
- Riverpod の `StateNotifier` で回答を管理し、「次へ/戻る」「結果を見る」を制御

## 判定ロジック（if / else）例
- 痛み部位・性質・きっかけなどをスコアリング／条件分岐し、腰痛/肩こり/膝痛の候補パターンを返す
- 例: デスクワーク + 肩部位 + こり/重だるい → "デスクワーク由来の首肩こり傾向"
- 注意サイン（しびれ/麻痺/発熱/夜間痛 など）が含まれる場合は、追加で「医療機関への受診推奨」を表示
- 判定結果モデル
```dart
class DiagnosisResult {
  final String patternName;
  final String description;
  final List<String> recommendedCare; // ストレッチ/体操/生活習慣
  final Uri? videoUrl;                // YouTube 外部ブラウザ用
  final bool showMedicalNotice;       // 受診推奨のフラグ
}
```

## 診断結果画面
- 表示: パターン名、説明、注意事項（医療行為ではない旨を必ず表示）、推奨セルフケア
- ボタン: 「ストレッチ動画を見る」（外部ブラウザで `url_launcher` を使用）、
  「この結果を日記に保存」（ON デフォルトで即保存でも可）

## 日記（ローカルDB）
- テーブル: `pain_diary`
  - `id` INTEGER PRIMARY KEY
  - `date` TEXT (ISO8601)
  - `area` TEXT
  - `painLevel` INTEGER
  - `patternName` TEXT
  - `memo` TEXT
- 日付順で一覧表示し、タップで詳細 + メモ編集（削除/編集は v1.0 では任意）

## 広告・課金
- ホーム下部にバナー広告（AdMob テストID）
- 「広告除去購入済み」フラグをローカル保存（SharedPreferences またはシンプルな DB テーブル）
- 設定画面に「広告を削除する」ボタン → 購入成功でフラグ ON + 広告非表示

## 免責・ポリシー
- アプリ説明と免責文を設定画面から参照可能にし、問診・結果画面にも「診断ではない」旨の注意文を常時表示
- プライバシーポリシーはローカルデータと広告/IAP 利用の説明を簡潔に記載

## UI/UX ポイント
- 3〜5タップで結果表示できるよう、質問数を絞り簡易な単一/複数選択 UI を採用
- 必須項目は早期に入力させ、進捗インジケータで全体感を提示
- ダークモードは v1 では無効化し、明示的に `themeMode: ThemeMode.light` を設定
