import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step/quiz/controllers/question_controller.dart';

import 'components/body.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // Fluttter show the back button automatically
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          FlatButton(onPressed: _controller.nextQuestion, child: Container(
            height: 40,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(5))

              ),
              child: Center(
                child: Text("Skip",style: TextStyle(
                  color: Colors.white
                ),),
              ))),
        ],
      ),
      body: Body(),
    );
  }
}
