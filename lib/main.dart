import 'package:devloperstudio/widgets/authorization/login.dart';
import 'package:devloperstudio/widgets/cpforum/question_replies.dart';
import 'package:devloperstudio/widgets/cpforum/reply_question.dart';
import 'package:devloperstudio/widgets/cpnotes/cp_expandedSubTopics.dart';
import 'package:devloperstudio/widgets/quizes/quiz_details.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:devloperstudio/widgets/mainpage/homepage.dart';
import 'package:devloperstudio/widgets/authorization/loginModel.dart';
import 'package:devloperstudio/widgets/cpquestions/cpquestionslist.dart';

// https://www.figma.com/file/PWCCQJIkYFNN2RePuB8IgY/Incredible.dev-(Copy)?node-id=467%3A377
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue, statusBarIconBrightness: Brightness.light));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoading = false;
  LoginModel model = new LoginModel();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Devs.Studio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<bool>(
        future: model.checkUser(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.data == true) {
            return HomePage();
          } else {
            return LoginPage();
          }
        },
      ),
      routes: {
        '/cpexpanded': (ctx) => CpExpandedSubTopics(),
        '/login': (ctx) => LoginPage(),
        '/home': (ctx) => HomePage(),
        '/questionPostAndReplies': (ctx) => QuestionPostAndReplies(),
        '/replyQuestion': (ctx) => ReplyQuestion(),
        '/quizDetails': (ctx) => QuizDetails(),
        '/cpquestionslist': (ctx) => CpQuestionsLists(),
      },
    );
  }
}
