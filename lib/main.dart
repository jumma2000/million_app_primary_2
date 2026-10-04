import 'package:flutter/material.dart';
import 'question_model.dart';
import 'questions_data.dart';

void main() {
  runApp(const MillionApp());
}

class MillionApp extends StatelessWidget {
  const MillionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' من سيربح المليون',
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
          brightness: Brightness.dark,
        ),
      ),
      home: const MainLayout(),
    );
  }
}

// تخطيط رئيسي يحتوي على Navbar و Footer وشاشات متغيرة
class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const GameScreen(),
    const AboutScreen(),
    const ContactScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
        title: const Row(
          children: [
            Icon(Icons.quiz, color: Colors.amber),
            SizedBox(width: 10),
            Text(' تصميم جمعة ضو        من سيربح المليون', style: TextStyle(fontSize: 18, color: Colors.amber)),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: () => setState(() => _currentIndex = 0),
            icon: const Icon(Icons.gamepad, color: Colors.white),
            label: const Text('اللعبة', style: TextStyle(color: Colors.white)),
          ),
          TextButton.icon(
            onPressed: () => setState(() => _currentIndex = 1),
            icon: const Icon(Icons.info, color: Colors.white),
            label: const Text('من نحن', style: TextStyle(color: Colors.white)),
          ),
          TextButton.icon(
            onPressed: () => setState(() => _currentIndex = 2),
            icon: const Icon(Icons.contact_phone, color: Colors.white),
            label: const Text('اتصل بنا', style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        color: Colors.indigo[950],
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'جميع الحقوق محفوظة © 2026 | تصميم وتطوير: جمعة ضو',
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

// 1. شاشة اللعبة الآمنة ضد التجاوز
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int currentQuestionIndex = 0;
  int score = 100;
  
  bool fiftyFiftyUsed = false;
  bool audienceUsed = false;
  bool friendUsed = false;

  List<int> hiddenOptions = [];
  
  // تحميل الأسئلة باستخدام الدالة الجديدة
  final List<Question> questions = QuestionBank.loadQuestions();

  void answerQuestion(int selectedIndex) {
    if (questions.isEmpty) return;
    
    Question currentQ = questions[currentQuestionIndex];

    if (selectedIndex == currentQ.correctAnswerIndex) {
      score += 1000;
      if (currentQuestionIndex < questions.length - 1) {
        setState(() {
          currentQuestionIndex++;
          hiddenOptions.clear();
        });
      } else {
        _showEndDialog('مبروك! لقد فزت بالمليون ونقاطك هي: $score');
      }
    } else {
      _showEndDialog('إجابة خاطئة! انتهت اللعبة. رصيدك النهائي: $score');
    }
  }

  void useFiftyFifty() {
    if (fiftyFiftyUsed || questions.isEmpty) return;
    Question currentQ = questions[currentQuestionIndex];
    int correct = currentQ.correctAnswerIndex;
    
    List<int> wrongOptions = [];
    for (int i = 0; i < 4; i++) {
      if (i != correct) wrongOptions.add(i);
    }
    wrongOptions.shuffle();

    setState(() {
      fiftyFiftyUsed = true;
      hiddenOptions = [wrongOptions[0], wrongOptions[1]];
    });
  }

  void useAudience() {
    if (audienceUsed || questions.isEmpty) return;
    Question currentQ = questions[currentQuestionIndex];
    String correctAnswer = currentQ.options[currentQ.correctAnswerIndex];
    
    setState(() {
      audienceUsed = true;
    });
    _showMsg('رأي الجمهور: التصويت الأعلى بنسبة 85% هو لصالح الإجابة: "$correctAnswer"');
  }

  void useFriend() {
    if (friendUsed || questions.isEmpty) return;
    Question currentQ = questions[currentQuestionIndex];
    String correctAnswer = currentQ.options[currentQ.correctAnswerIndex];
    
    setState(() {
      friendUsed = true;
    });
    _showMsg('الصديق: متأكد بنسبة كبيرة أن الإجابة الصحيحة هي: "$correctAnswer"');
  }

  void showTranslation() {
    if (questions.isEmpty) return;
    Question currentQ = questions[currentQuestionIndex];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ترجمة السؤال بالعربية'),
        content: Text(
          currentQ.arabicTranslation,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }

  void _showMsg(String msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('وسيلة إغاثة'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }

  void _showEndDialog(String title) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(title),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                currentQuestionIndex = 0;
                score = 100;
                fiftyFiftyUsed = false;
                audienceUsed = false;
                friendUsed = false;
                hiddenOptions.clear();
              });
            },
            child: const Text('إعادة اللعبة'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // التحقق من وجود أسئلة
    if (questions.isEmpty) {
      return const Center(
        child: Text(
          'لا توجد أسئلة متاحة حالياً.',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      );
    }

    Question currentQ = questions[currentQuestionIndex];

    return Container(
      color: const Color(0xFF0D1B2A),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('السؤال ${currentQuestionIndex + 1} من ${questions.length}',
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.amber)),
                        Text('الجائزة: $score دينار',
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.greenAccent)),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.amber[800]),
                          onPressed: fiftyFiftyUsed ? null : useFiftyFifty,
                          child: const Text('50:50'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo[700]),
                          onPressed: audienceUsed ? null : useAudience,
                          child: const Text('الجمهور'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo[700]),
                          onPressed: friendUsed ? null : useFriend,
                          child: const Text('صديق'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: showTranslation,
                      icon: const Icon(Icons.translate),
                      label: const Text('ترجمة السؤال بالعربية'),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.indigo[800],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.amber, width: 2),
                      ),
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text(
                          currentQ.questionText,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ...List.generate(4, (index) {
                      if (hiddenOptions.contains(index)) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey[900],
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: () => answerQuestion(index),
                            child: Text(
                              currentQ.options[index],
                              style: const TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// 2. شاشة من نحن الآمنة ضد التجاوز
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0D1B2A),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.indigo[900],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.amber, width: 2),
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('من نحن ؟', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.amber)),
                        SizedBox(height: 20),
                        Text(
                          'هذه اللعبة مستوحاة من برنامج المسابقات الشهير "من سيربح المليون"، تم تطويرها خصيصاً لتوفير تجربة تفاعلية ممتعة ومسلية لاختبار المعلومات العامة في شتى المجالات العلمية والتاريخية والثقافية بأسلوب سلس ومناسب لجميع المستخدمين.',
                          style: TextStyle(fontSize: 16, height: 1.6, color: Colors.white70),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// 3. شاشة اتصل بنا الآمنة ضد التجاوز
class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0D1B2A),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.indigo[900],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.amber, width: 2),
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text('اتصل بنا', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.amber)),
                        ),
                        SizedBox(height: 20),
                        ListTile(
                          leading: Icon(Icons.person, color: Colors.amber),
                          title: Text('الاسم الكريم', style: TextStyle(color: Colors.white70)),
                          subtitle: Text('جمعة ضو', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                        ListTile(
                          leading: Icon(Icons.phone, color: Colors.greenAccent),
                          title: Text('رقم الهاتف / واتساب', style: TextStyle(color: Colors.white70)),
                          subtitle: Text('00218911313949', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                        ListTile(
                          leading: Icon(Icons.location_on, color: Colors.redAccent),
                          title: Text('العنوان', style: TextStyle(color: Colors.white70)),
                          subtitle: Text('طريق المشتل - قرب مصنع النجمة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
