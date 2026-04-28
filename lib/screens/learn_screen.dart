// screens/learn_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import '../models/lesson.dart';
import 'lesson_screen.dart';

const List<Lesson> lessons = [
  Lesson(id: 'variables', title: 'المتغيرات', icon: '📦', colorValue: 0xFF4CAF50, description: 'تعلم كيفية تخزين البيانات في متغيرات.', codeExample: 'عدد العمر = 15\nاطبع("عمرك هو: " + العمر)'),
  Lesson(id: 'conditions', title: 'الشروط', icon: '🔀', colorValue: 0xFFFF9800, description: 'اتخذ قرارات في برنامجك باستخدام إذا.', codeExample: 'عدد النتيجة = 80\nإذا النتيجة > 50:\n    اطبع("ناجح!")\nوإلا:\n    اطبع("حاول مرة أخرى")'),
  Lesson(id: 'loops', title: 'الحلقات', icon: '🔁', colorValue: 0xFF2196F3, description: 'كرر الأوامر باستخدام طالما.', codeExample: 'عدد ع = 1\nطالما ع <= 5:\n    اطبع(ع)\n    ع = ع + 1'),
  Lesson(id: 'functions', title: 'الدوال', icon: '⚙️', colorValue: 0xFF9C27B0, description: 'نظم كودك في دوال.', codeExample: 'دالة اجمع(أ، ب):\n    أرجع أ + ب\n\nاطبع(اجمع(5، 3))'),
  Lesson(id: 'lists', title: 'القوائم', icon: '📋', colorValue: 0xFFE91E63, description: 'تعامل مع مجموعات من البيانات.', codeExample: 'قائمة فواكه = ["تفاح"، "موز", "برتقال"]\nاطبع(فواكه[0])'),
  Lesson(id: 'dictionaries', title: 'القواميس', icon: '📖', colorValue: 0xFF00BCD4, description: 'خزن البيانات بأزواج المفتاح والقيمة.', codeExample: 'قاموس طالب = {\n    "الاسم": "أحمد",\n    "العمر": 16\n}\nاطبع(طالب["الاسم"])'),
];

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final isDark = appState.isDarkMode;

    return Scaffold(
      appBar: AppBar(title: const Text('تعَلَّمْ')),
      body: ListView.builder(
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          final lesson = lessons[index];
          return ListTile(
            leading: Text(lesson.icon, style: const TextStyle(fontSize: 28)),
            title: Text(lesson.title),
            subtitle: Text(lesson.description),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => LessonScreen(lesson: lesson)));
            },
          );
        },
      ),
    );
  }
}
