class Question {
  final int question_id;
  final int
      type; //1-> for single option select 2-> for multi select 3->type answers
  final int
      cat; //1-> show answer after completing the test 2-> Never show answers
  final String Questions;
  final Set<String> options;
  final Set<String> answer; //selected options
  //late List<int>selectedoptions;
  Question({
    required this.question_id,
    required this.type,
    required this.cat,
    required this.Questions,
    required this.options,
    required this.answer,
  });
}

class Answer {
  static late  Map<int, bool> mp = {};
  late Set<int> ans = {};
}
