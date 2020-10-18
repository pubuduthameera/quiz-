import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:make_paper/views/play_quiz.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future getfaqdata() async {
      var fireStore = Firestore.instance;
      //TODO
      // change the collection name to your one
      QuerySnapshot faq = await fireStore.collection('faq').getDocuments();
      return faq.documents;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      body: FutureBuilder(
        future: getfaqdata(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return QuizTitle(
                        imgUrl: snapshot.data[index].data["quizImgurl"],
                        title: snapshot.data[index].data["quiztitle"],
                        desc: snapshot.data[index].data["quizDesc"],
                        quizid: snapshot.data[index].data["quizId"]);
                  },
                );
        },
      ),
    );
  }
}

class QuizTitle extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String desc;
  final String quizid;
  QuizTitle(
      {@required this.imgUrl,
      @required this.title,
      @required this.desc,
      @required this.quizid});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PlayQuiz(quizid)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        height: 150,
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imgUrl,
                  width: MediaQuery.of(context).size.width - 48,
                  fit: BoxFit.cover,
                )),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black26,
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    desc,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
