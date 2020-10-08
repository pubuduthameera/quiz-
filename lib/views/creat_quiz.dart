import 'package:flutter/material.dart';
import 'package:make_paper/service/database.dart';
import 'package:make_paper/views/addqueston.dart';
import 'package:make_paper/widgets/widget.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formkey = GlobalKey<FormState>();
  String imageUrl, title, description, quizId;
  DatabaseService databaseService = new DatabaseService();

  bool _isLoading = false;
  createQuizOnline() async {
    if (_formkey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      quizId = randomAlphaNumeric(16);

      Map<String, String> quizMap = {
        "quizId": quizId,
        "quizImgurl": imageUrl,
        "quizTitle": title,
        "quizdesc": description
      };
      await databaseService.addQuizData(quizMap, quizId).then((value) {
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => AddQuestion(
              quizId
          )));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black87),
        brightness: Brightness.light,
      ),
      body: _isLoading
          ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      )
          : Form(
        key: _formkey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              TextFormField(
                validator: (val) =>
                val.isEmpty ? "Enter Image Url" : null,
                decoration: InputDecoration(
                  hintText: "Quiz Image Url",
                ),
                onChanged: (val) {
                  imageUrl = val;
                },
              ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Title" : null,
                decoration: InputDecoration(
                  hintText: "Title",
                ),
                onChanged: (val) {
                  title = val;
                },
              ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                validator: (val) =>
                val.isEmpty ? "Enter Description" : null,
                decoration: InputDecoration(
                  hintText: "Description",
                ),
                onChanged: (val) {
                  description = val;
                },
              ),
              Spacer(),
              GestureDetector(
                  onTap: () {
                    createQuizOnline();
                  },
                  child: blueButton(
                      context: context,
                      label: "Create Quiz"
                  )),
              SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}