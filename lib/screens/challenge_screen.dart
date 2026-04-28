// screens/challenge_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';

class Challenge {
  final String title;
  final String description;
  final String exampleCode;
  final String expectedOutput;
  const Challenge({required this.title, required this.description, required this.exampleCode, required this.expectedOutput});
}

const List<Challenge> challenges = [
  Challenge(title: 'طباعة رسالة', description: 'اكتب كوداً يطبع: "مرحباً بالبرمجة!"', exampleCode: '// اكتب كودك هنا', expectedOutput: 'مرحباً بالبرمجة!'),
  Challenge(title: 'جمع عددين', description: 'عرف متغيرين أ و ب بقيم 5 و 10 واطبع مجموعهما.', exampleCode: 'عدد أ = 5\nعدد ب = 10\n// أكمل الكود', expectedOutput: '15'),
];

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({super.key});
  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  final TextEditingController _codeController = TextEditingController();
  String? _resultMessage;
  bool _isSuccess = false;
  bool _isEvaluating = false;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _codeController.text = challenges[_currentIndex].exampleCode;
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _evaluate() async {
    setState(() { _isEvaluating = true; _resultMessage = null; });
    await Future.delayed(const Duration(milliseconds: 800));
    final code = _codeController.text;
    final expected = challenges[_currentIndex].expectedOutput;
    bool success = false;
    if (code.contains('اطبع') || code.contains('print')) {
      if (code.contains(expected)) { success = true; }
    }
    setState(() {
      _isEvaluating = false;
      _isSuccess = success;
      _resultMessage = success ? '✅ أحسنت! إجابتك صحيحة.' : '❌ حاول مرة أخرى. توقعنا: "$expected"';
    });
  }

  void _reset() {
    setState(() { _codeController.text = challenges[_currentIndex].exampleCode; _resultMessage = null; });
  }

  void _nextChallenge() {
    if (_currentIndex < challenges.length - 1) {
      setState(() { _currentIndex++; _codeController.text = challenges[_currentIndex].exampleCode; _resultMessage = null; _isSuccess = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final isDark = appState.isDarkMode;
    final challenge = challenges[_currentIndex];
    final editorBg = isDark ? const Color(0xFF1E1E2E) : const Color(0xFFF5F5F5);
    final editorFg = isDark ? const Color(0xFFCDD6F4) : const Color(0xFF1E1E2E);

    return Scaffold(
      appBar: AppBar(title: const Text('تحدى روحك')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [const Icon(Icons.flag_rounded, color: Color(0xFFFF9800)), const SizedBox(width: 8), Text('التحدي ${_currentIndex + 1}/${challenges.length}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))]),
                    const SizedBox(height: 12),
                    Text(challenge.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(challenge.description, style: TextStyle(fontSize: 15, color: isDark ? const Color(0xFFCDD6F4) : const Color(0xFF4A4A6A), height: 1.6)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(children: [const Icon(Icons.code_rounded, color: Color(0xFF6C63FF)), const SizedBox(width: 8), const Text('محرر الأكواد', style: TextStyle(fontWeight: FontWeight.bold)), const Spacer(), TextButton.icon(onPressed: _reset, icon: const Icon(Icons.refresh_rounded, size: 18), label: const Text('إعادة'))]),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(color: editorBg, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.withOpacity(0.3))),
              child: TextField(
                controller: _codeController, maxLines: 8, textDirection: TextDirection.ltr,
                style: TextStyle(fontFamily: 'monospace', fontSize: 14, color: editorFg, height: 1.6),
                decoration: const InputDecoration(contentPadding: EdgeInsets.all(16), border: InputBorder.none, hintText: '// اكتب كودك هنا...'),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 52,
              child: ElevatedButton.icon(
                onPressed: _isEvaluating ? null : _evaluate,
                icon: _isEvaluating ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Icon(Icons.check_circle_rounded),
                label: Text(_isEvaluating ? 'جاري التقييم...' : 'تقييم الإجابة', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C63FF), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              ),
            ),
            if (_resultMessage != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: _isSuccess ? (isDark ? const Color(0xFF1B3A1B) : const Color(0xFFE8F5E9)) : (isDark ? const Color(0xFF3A1B1B) : const Color(0xFFFFEBEE)), borderRadius: BorderRadius.circular(12)),
                child: Row(children: [Icon(_isSuccess ? Icons.check_circle : Icons.error, color: _isSuccess ? Colors.green : Colors.red), const SizedBox(width: 12), Expanded(child: Text(_resultMessage!, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: _isSuccess ? Colors.green : Colors.red)))]),
              ),
            ],
            if (_isSuccess && _currentIndex < challenges.length - 1) ...[
              const SizedBox(height: 12),
              OutlinedButton.icon(onPressed: _nextChallenge, icon: const Icon(Icons.arrow_forward_rounded), label: const Text('التحدي التالي'), style: OutlinedButton.styleFrom(foregroundColor: const Color(0xFF6C63FF), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))),
            ],
            if (_isSuccess && _currentIndex == challenges.length - 1) ...[
              const SizedBox(height: 12),
              Card(color: const Color(0xFFFFD700).withOpacity(0.15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), child: const Padding(padding: EdgeInsets.all(16), child: Text('🏆 مبروك! أكملت كل التحديات!', textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
            ],
          ],
        ),
      ),
    );
  }
}
