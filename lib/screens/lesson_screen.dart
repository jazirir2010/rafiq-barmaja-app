// screens/lesson_screen.dart
import 'package:flutter/material.dart';
import '../models/lesson.dart';

class LessonScreen extends StatefulWidget {
  final Lesson lesson;
  const LessonScreen({super.key, required this.lesson});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  late final TextEditingController _codeController;
  String? _output;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController(text: widget.lesson.codeExample);
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _runCode() async {
    setState(() {
      _isRunning = true;
      _output = null;
    });
    await Future.delayed(const Duration(milliseconds: 900));
    final code = _codeController.text.trim();
    String result;
    if (code.isEmpty) {
      result = '⚠️ لا يوجد كود للتشغيل.';
    } else if (code.contains('اطبع') || code.contains('أخرج')) {
      final regex = RegExp(r"(?:اطبع|أخرج)\((['\"]?)(.+?)\1\)");
      final matches = regex.allMatches(code);
      if (matches.isNotEmpty) {
        result = matches.map((m) => m.group(2) ?? '').join('\n');
      } else {
        result = '✅ تم تنفيذ الكود بنجاح.';
      }
    } else {
      result = '✅ تم تنفيذ الكود بنجاح.\n\n--- النتيجة ---\nقيمة المتغير: 42';
    }
    setState(() {
      _output = result;
      _isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final editorBg = isDark ? const Color(0xFF1E1E2E) : const Color(0xFFF5F5F5);
    final editorFg = isDark ? const Color(0xFFCDD6F4) : const Color(0xFF1E1E2E);
    final outputBg = isDark ? const Color(0xFF11111B) : const Color(0xFFE8F5E9);
    final outputFg = isDark ? const Color(0xFFA6E3A1) : const Color(0xFF1B5E20);

    return Scaffold(
      appBar: AppBar(title: Text(widget.lesson.title)),
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
                    Row(children: [Icon(Icons.menu_book_rounded, color: theme.colorScheme.primary), const SizedBox(width: 8), Text('شرح الدرس', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold))]),
                    const SizedBox(height: 12),
                    Text(widget.lesson.description, style: theme.textTheme.bodyMedium?.copyWith(height: 1.7), textAlign: TextAlign.justify),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(children: [Icon(Icons.code_rounded, color: theme.colorScheme.secondary), const SizedBox(width: 8), Text('محرر الأكواد', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)), const Spacer(), TextButton.icon(onPressed: () => _codeController.clear(), icon: const Icon(Icons.clear_all_rounded, size: 18), label: const Text('مسح'))]),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(color: editorBg, borderRadius: BorderRadius.circular(12), border: Border.all(color: theme.colorScheme.outline.withOpacity(0.4))),
              child: TextField(
                controller: _codeController,
                maxLines: null,
                minLines: 10,
                textDirection: TextDirection.ltr,
                style: TextStyle(fontFamily: 'monospace', fontSize: 14, color: editorFg, height: 1.6),
                decoration: InputDecoration(contentPadding: const EdgeInsets.all(16), border: InputBorder.none, hintText: '// اكتب كودك هنا...', hintStyle: TextStyle(fontFamily: 'monospace', color: editorFg.withOpacity(0.4), fontStyle: FontStyle.italic)),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 52,
              child: ElevatedButton.icon(
                onPressed: _isRunning ? null : _runCode,
                icon: _isRunning ? SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: theme.colorScheme.onPrimary)) : const Icon(Icons.play_arrow_rounded),
                label: Text(_isRunning ? 'جاري التشغيل...' : '▶ تشغيل الكود', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(backgroundColor: theme.colorScheme.primary, foregroundColor: theme.colorScheme.onPrimary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              ),
            ),
            if (_output != null) ...[
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(color: outputBg, borderRadius: BorderRadius.circular(12), border: Border.all(color: outputFg.withOpacity(0.3))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), decoration: BoxDecoration(color: outputFg.withOpacity(0.1), borderRadius: const BorderRadius.vertical(top: Radius.circular(12))), child: Row(children: [Icon(Icons.terminal_rounded, size: 18, color: outputFg), const SizedBox(width: 8), Text('نتيجة التنفيذ', style: TextStyle(fontWeight: FontWeight.bold, color: outputFg, fontSize: 13)), const Spacer(), GestureDetector(onTap: () => setState(() => _output = null), child: Icon(Icons.close_rounded, size: 18, color: outputFg.withOpacity(0.6)))])),
                    Padding(padding: const EdgeInsets.all(16), child: SelectableText(_output!, textDirection: TextDirection.ltr, style: TextStyle(fontFamily: 'monospace', fontSize: 14, color: outputFg, height: 1.6))),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
