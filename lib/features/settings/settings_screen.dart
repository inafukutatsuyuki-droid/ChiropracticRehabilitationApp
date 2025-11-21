import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('アプリの説明・免責'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('アプリの目的',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text(
            '痛みの原因をセルフチェックし、ストレッチや生活習慣のヒントを提供するオフラインアプリです。',
          ),
          const SizedBox(height: 16),
          Text('免責事項',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text(
            '本アプリは医療行為や診断を行うものではありません。強い痛み、しびれ、発熱などの症状がある場合は医療機関への受診を推奨します。',
          ),
          const SizedBox(height: 16),
          Text('プライバシーポリシー',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text(
            'データは端末内に保存され、サーバー送信は行いません。広告・課金機能の利用に必要な情報のみ、各サービスのポリシーに基づき処理されます。',
          ),
          const SizedBox(height: 16),
          Text('広告除去（アプリ内課金）',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('アプリ内課金の導線は後続で実装予定です。'),
                ),
              );
            },
            child: const Text('広告を削除する（購入）'),
          ),
          const SizedBox(height: 24),
          Text('開発者情報',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('痛み原因セルフ判定アプリ開発チーム'),
        ],
      ),
    );
  }
}
