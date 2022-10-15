class Question {
  final int question_id;
  final int
      type; //1-> for single option select 2-> for multi select 3->type answers
  final int
      cat; //1->show anser immediately 2-> show answer after completing the test 3-> Never show answers
  final String Questions;
  final Set<String> options;
  final Set<String> answer;
  late int ans;
  //late List<int>selectedoptions;
  Question(
      {required this.question_id,
      required this.type,
      required this.cat,
      required this.Questions,
      required this.options,
      required this.answer,
      required this.ans});
}

class Answer {
  late Map<int, bool> mp = {};
}
