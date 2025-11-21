import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../data/models/diagnosis_result.dart';
import '../features/diary/diary_screen.dart';
import '../features/home/home_screen.dart';
import '../features/questionnaire/views/questionnaire_screen.dart';
import '../features/result/result_screen.dart';
import '../features/settings/settings_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/questionnaire',
        builder: (context, state) => const QuestionnaireScreen(),
      ),
      GoRoute(
        path: '/result',
        builder: (context, state) {
          final report = state.extra as DiagnosisReport?;
          return ResultScreen(report: report);
        },
      ),
      GoRoute(
        path: '/diary',
        builder: (context, state) => const DiaryScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
});
