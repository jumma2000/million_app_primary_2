import 'question_model.dart';

class QuestionBank {
  // هذه الدالة تقوم بتحميل الأسئلة مع الحماية من الأخطاء
  static List<Question> loadQuestions() {
    try {
      return [
        // ===== Unit 1: About Me =====
        Question(
          questionText: 'What is your name?',
          options: ['I am 6.', 'My name is Muna.', 'I am fine.', 'Hello'],
          correctAnswerIndex: 1,
          arabicTranslation: 'ما اسمك؟',
        ),
        Question(
          questionText: 'How old are you?',
          options: ['I am 6.', 'My name is Kareem.', 'I am from Libya.', 'Goodbye'],
          correctAnswerIndex: 0,
          arabicTranslation: 'كم عمرك؟',
        ),
        Question(
          questionText: 'How are you?',
          options: ['I am 7.', 'My name is Ali.', 'I am very well, thanks.', 'This is a book.'],
          correctAnswerIndex: 2,
          arabicTranslation: 'كيف حالك؟',
        ),
        Question(
          questionText: 'What is his name?',
          options: ['Her name is Muna.', 'His name is Kareem.', 'My name is Zack.', 'I am 8.'],
          correctAnswerIndex: 1,
          arabicTranslation: 'ما اسمه؟',
        ),

        // ===== Unit 2: My Classroom =====
        Question(
          questionText: 'We write with a ______.',
          options: ['bag', 'pencil', 'desk', 'chair'],
          correctAnswerIndex: 1,
          arabicTranslation: 'نحن نكتب باستخدام ______.',
        ),
        Question(
          questionText: 'We put our books in a ______.',
          options: ['rubber', 'ruler', 'bag', 'bin'],
          correctAnswerIndex: 2,
          arabicTranslation: 'نحن نضع كتبنا في ______.',
        ),
        Question(
          questionText: 'We draw a line with a ______.',
          options: ['ruler', 'glue', 'pen', 'book'],
          correctAnswerIndex: 0,
          arabicTranslation: 'نحن نرسم خطاً باستخدام ______.',
        ),
        Question(
          questionText: 'I sit on a ______.',
          options: ['desk', 'chair', 'clock', 'case'],
          correctAnswerIndex: 1,
          arabicTranslation: 'أنا أجلس على ______.',
        ),
        Question(
          questionText: 'What is this? (صورة قلم رصاص)',
          options: ['It is a pen.', 'It is a pencil.', 'It is a book.', 'It is a bag.'],
          correctAnswerIndex: 1,
          arabicTranslation: 'ما هذا؟ (قلم رصاص)',
        ),

        // ===== Unit 3: I like fruit =====
        Question(
          questionText: 'I like ______. (صورة موز)',
          options: ['banana', 'apple', 'orange', 'grapes'],
          correctAnswerIndex: 0,
          arabicTranslation: 'أنا أحب ______. (الموز)',
        ),
        Question(
          questionText: 'I don\'t like ______. (صورة عنب)',
          options: ['watermelon', 'grapes', 'pear', 'dates'],
          correctAnswerIndex: 1,
          arabicTranslation: 'أنا لا أحب ______. (العنب)',
        ),
        Question(
          questionText: 'What is your favourite fruit?',
          options: ['I like mango.', 'I am 6.', 'My name is Hadi.', 'It is a ruler.'],
          correctAnswerIndex: 0,
          arabicTranslation: 'ما هي فاكهتك المفضلة؟',
        ),
        Question(
          questionText: 'This fruit is big and green outside, red inside.',
          options: ['Banana', 'Watermelon', 'Plum', 'Pear'],
          correctAnswerIndex: 1,
          arabicTranslation: 'هذه الفاكهة كبيرة وخضراء من الخارج، وحمراء من الداخل.',
        ),
      ];
    } catch (e) {
      // إذا حدث خطأ، يتم طباعته في الكونسول وإرجاع قائمة فارغة
      print('حدث خطأ أثناء تحميل الأسئلة: $e');
      return [];
    }
  }
}
