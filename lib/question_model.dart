class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;
  final String arabicTranslation;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
    required this.arabicTranslation,
  }) {
    // هذا الجزء يتحقق من صحة البيانات عند إنشاء السؤال
    if (options.length != 4) {
      throw Exception('يجب أن يحتوي السؤال على 4 خيارات بالضبط: $questionText');
    }
    if (correctAnswerIndex < 0 || correctAnswerIndex > 3) {
      throw Exception('رقم الإجابة الصحيحة يجب أن يكون بين 0 و 3: $questionText');
    }
  }
}
