import '../../../data/models/pain_question.dart';

const questionnaire = [
  PainQuestion(
    id: 'area',
    title: '痛みの部位はどこですか？',
    options: ['腰', '肩', '膝'],
  ),
  PainQuestion(
    id: 'nature',
    title: '痛みの性質に近いものを選んでください',
    options: ['ズキズキ', '重だるい', 'こり', 'しびれ'],
    multiSelect: true,
  ),
  PainQuestion(
    id: 'trigger',
    title: '発症のきっかけはありますか？',
    options: ['デスクワーク', '立ち仕事', '運動不足', '運動', '怪我'],
    multiSelect: true,
  ),
  PainQuestion(
    id: 'duration',
    title: '痛みの期間はどれくらいですか？',
    options: ['数日', '数週間', '数ヶ月以上'],
  ),
  PainQuestion(
    id: 'level',
    title: '現在の痛みレベルを1〜10で教えてください',
    options: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
  ),
  PainQuestion(
    id: 'warning',
    title: '以下の症状はありますか？（複数選択可）',
    options: ['しびれ', '麻痺', '発熱', '夜間痛', '特にない'],
    multiSelect: true,
  ),
];
