import 'package:flutter/material.dart';
import 'package:make_paper/service/database.dart';
import 'package:make_paper/views/creat_quiz.dart';
import 'package:make_paper/views/play_quiz.dart';
import 'package:make_paper/widgets/widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Stream quizStream;
  DatabaseService databaseService=new DatabaseService();

  Widget quizList(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder(
        stream: quizStream,
        builder: (context,snapshot){
          return snapshot.data != null
              ? Container():
          ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index){
                return QuizTitle(
                  imgUrl: snapshot.data.documents[index].data["quizImgurl"],
                  desc: snapshot.data.documents[index].data["quizDesc"],
                  title: snapshot.data.documents[index].data["quiztitle"],
                  quizid: snapshot.data.documents[index].data["quizId"],
                );
              });
        },
      ),
    );
  }

  @override
  void initState() {
    databaseService.getQuizezData().then((val){
      setState(() {
        quizStream=val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: quizList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateQuiz()));
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
  QuizTitle({@required this.imgUrl,@required this.title,@required this
      .desc,@required this.quizid});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => PlayQuiz(
                quizid
            )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        height: 150,
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(imgUrl,width: MediaQuery.of(context).size.width - 48, fit: BoxFit.cover,)),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),color: Colors.black26,
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600) ,),
                  SizedBox(height: 6,),
                  Text(desc, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500) ,),
                ],),
            )
          ],
        ),
      ),
    );
  }
}