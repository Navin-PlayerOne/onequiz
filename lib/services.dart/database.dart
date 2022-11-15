import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/questions_model.dart';
import '../models/test.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  final CollectionReference testCollection =
      FirebaseFirestore.instance.collection('tests');

  final CollectionReference adminCollection =
      FirebaseFirestore.instance.collection('admin');

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference scoresCollection =
      FirebaseFirestore.instance.collection('scores');

  final CollectionReference questionsCollection =
      FirebaseFirestore.instance.collection('questions');

  final CollectionReference testTokenRefrenceCollection =
      FirebaseFirestore.instance.collection('testref');

  final CollectionReference testStatusCollection =
      FirebaseFirestore.instance.collection('teststatus');

  // Stream<DocumentSnapshot<Object?>> get test {
  //   return testCollection.doc('gt').snapshots();
  // }

  Future getTestMetaData(String testCode) async {
    try {
      String testId = "";
      late Test test;
      await testTokenRefrenceCollection.doc(testCode).get().then((value) {
        Map<dynamic, dynamic> tId = value.data() as Map;
        testId = tId['testRef'];
      });
      await testCollection.doc(testId).get().then((value) {
        Map<dynamic, dynamic> eachTest = value.data() as Map;
        test = Test(
          completedCount: 0,
          contactMail: eachTest['supportMail'],
          isOpen: eachTest['isClosed'],
          name: eachTest['Name'],
          questionsCollectionId: eachTest['questionsCollectionId'],
          scoreBoardCollectionId: eachTest['scoreBoardCollectionId'],
          testCode: eachTest['testCode'],
          testName: eachTest['testName'],
          testid: value.id,
        );
      });
      return test;
    } catch (e) {
      return null;
    }
  }

  Future getQuestions(Test test) async {
    try {
      List<Question> questionList = [];
      await questionsCollection
          .doc(test.questionsCollectionId)
          .get()
          .then((value) {
        Map<dynamic, dynamic> allQuestionsmap = value.data() as Map;
        List<dynamic> allQuestionList = allQuestionsmap['questions'];
        Map<dynamic, dynamic> eachQuestionsmap = value.data() as Map;
        for (var element in allQuestionList) {
          eachQuestionsmap = element;
          Set<String> options = getOptions(eachQuestionsmap['options']);
          Set<String> answers =
              getAnswers(eachQuestionsmap['answers'], options);
          questionList.add(Question(
              question_id: eachQuestionsmap['questionId'],
              type: answers.length == 1 ? 1 : 2,
              cat: 1, //unImplemented
              Questions: eachQuestionsmap['question'],
              options: options,
              answer: answers));
          //print(eachQuestionsmap);
          //print(eachQuestionsmap['questionId']);
        }
      });
      return questionList;
    } catch (e) {
      return null;
    }
  }

  Set<String> getOptions(optionsFromDb) {
    Set<String> options = {};
    for (var value in optionsFromDb) {
      options.add(value);
    }
    return options;
  }

  Set<String> getAnswers(answersFromDb, Set<String> options) {
    Set<String> answers = {};
    int i = 0;
    for (var value in answersFromDb) {
      if (value == 1) {
        answers.add(options.elementAt(i));
      }
      i++;
    }
    return answers;
  }

  Future storeScores(scores, scoreId) async {
    await scoresCollection.doc(scoreId).set({
      uid: {
        'scores': scores,
        'photoUrl': FirebaseAuth.instance.currentUser!.photoURL,
        'mail': FirebaseAuth.instance.currentUser!.email,
        'name': FirebaseAuth.instance.currentUser!.displayName,
      }
    }, SetOptions(merge: true));
  }

  Future<bool> checkAttendedStatus(scoreboardid) async {
    var doc = await testStatusCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    return !doc.exists;
  }

  Future saveTestDetails() async {
    await testStatusCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'isAttended': 1});
  }

  bool _testStatusFromSnapshot(DocumentSnapshot doc) {
    return (doc.data() as Map)['isClosed'] ==1 ? false: true;
  }

  Stream<bool> getStatus(testId) {
    return testCollection.doc(testId).snapshots().map(_testStatusFromSnapshot);
  }
}
