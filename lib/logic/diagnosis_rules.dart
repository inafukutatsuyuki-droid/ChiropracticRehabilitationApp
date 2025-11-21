import '../data/models/diagnosis_result.dart';
import '../data/models/pain_answer.dart';

DiagnosisReport diagnose(List<PainAnswer> answers) {
  final answerMap = {for (final a in answers) a.questionId: a};
  final area = answerMap['area']?.selected.firstOrNull;
  final nature = answerMap['nature']?.selected ?? [];
  final trigger = answerMap['trigger']?.selected ?? [];
  final duration = answerMap['duration']?.selected.firstOrNull;
  final levelString = answerMap['level']?.selected.firstOrNull;
  final warning = answerMap['warning']?.selected ?? [];

  final level = int.tryParse(levelString ?? '') ?? 0;

  final List<DiagnosisResult> patterns = [];

  if (area == '肩' && trigger.contains('デスクワーク')) {
    patterns.add(
      DiagnosisResult(
        patternName: 'デスクワーク由来の首・肩こり傾向',
        description:
            '長時間のPC作業や同じ姿勢が続くことで首から肩の筋緊張が高まっている可能性があります。',
        recommendedCare: [
          '1時間に1回の肩回し・体幹伸ばしストレッチ',
          'モニター高さ調整と腕を支える肘置きの活用',
          '入浴や蒸しタオルで血流を促す',
        ],
        videoUrl: Uri.parse('https://www.youtube.com/watch?v=8o9WQdADG_s'),
      ),
    );
  }

  if (area == '腰' && trigger.contains('運動不足')) {
    patterns.add(
      DiagnosisResult(
        patternName: '筋力不足・運動不足タイプの腰痛傾向',
        description:
            '体幹や臀部の筋力低下で腰への負担が増えているかもしれません。短時間の体幹トレーニングで土台を整えましょう。',
        recommendedCare: [
          'ドローインやブリッジなどの自重トレーニングを週3回',
          '長時間座位を避け、こまめに立ち上がる',
          '歩行時間を10〜20分増やす',
        ],
        videoUrl: Uri.parse('https://www.youtube.com/watch?v=feN6ynJ3u6c'),
      ),
    );
  }

  if (area == '膝' && duration == '数ヶ月以上') {
    patterns.add(
      DiagnosisResult(
        patternName: '加齢・負担蓄積タイプの膝痛傾向',
        description:
            '歩行や階段での痛みが続く場合、膝周りの筋力バランスや関節への負担蓄積が考えられます。',
        recommendedCare: [
          '太もも前後のストレッチで関節可動域を確保',
          '膝に優しいスクワットやレッグレイズで支持力アップ',
          '痛みが強い日は無理をせずアイシングを活用',
        ],
        videoUrl: Uri.parse('https://www.youtube.com/watch?v=N1wuR9kpX9M'),
      ),
    );
  }

  if (nature.contains('しびれ') || level >= 8) {
    patterns.add(
      DiagnosisResult(
        patternName: '強い症状・神経症状のサイン',
        description:
            'しびれや強い痛みがある場合は無理をせず、早めに専門医への相談を検討してください。',
        recommendedCare: [
          '安静を確保し、無理なストレッチは避ける',
          '痛みが強い場合は冷却や市販鎮痛薬の使用を検討（用法用量遵守）',
          '痛みが続く場合は整形外科や専門外来へ相談',
        ],
        videoUrl: null,
      ),
    );
  }

  if (patterns.isEmpty) {
    patterns.add(
      DiagnosisResult(
        patternName: '生活習慣要因の可能性',
        description:
            '姿勢や生活リズムなど複合的な要因で痛みが出ているかもしれません。無理のない範囲でセルフケアを続けてみましょう。',
        recommendedCare: [
          '日中にこまめな姿勢リセットと深呼吸を行う',
          '軽いストレッチやウォーキングを毎日継続',
          '睡眠時間を確保し、疲労を溜め込まない',
        ],
      ),
    );
  }

  final warningSigns = ['しびれ', '麻痺', '発熱', '夜間痛'];
  final showNotice = warning.any(warningSigns.contains) || level >= 8;

  return DiagnosisReport(
    patterns: patterns,
    showMedicalNotice: showNotice,
  );
}

extension FirstOrNull<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
