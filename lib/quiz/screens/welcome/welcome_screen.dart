import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:googleapis/adsense/v1_4.dart';
import 'package:step/quiz/screens/quiz/quiz_screen.dart';


import '../../constants.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
               width: MediaQuery.of(context).size.width,
               height: MediaQuery.of(context).size.height,
              child: SvgPicture.asset("assets/icons/bg.svg", fit: BoxFit.fill)),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Padding(
                padding: const EdgeInsets.only(top: 20,bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          "Quiz 01213",
                          style: Theme.of(context).textTheme.headline4.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text("Quiz about Science"),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text(
                             "Questions",
                             style: Theme.of(context).textTheme.headline6.copyWith(
                                 color: Colors.white, fontWeight: FontWeight.bold),
                           ),
                           Text(
                             "05",
                             style: Theme.of(context).textTheme.headline6.copyWith(
                                 color: Colors.white, fontWeight: FontWeight.w500),
                           ),

                         ],
                       ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Time",
                              style: Theme.of(context).textTheme.headline6.copyWith(
                                  color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "5 Mins",
                              style: Theme.of(context).textTheme.headline6.copyWith(
                                  color: Colors.white, fontWeight: FontWeight.w500),
                            ),

                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Marks",
                              style: Theme.of(context).textTheme.headline6.copyWith(
                                  color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "50",
                              style: Theme.of(context).textTheme.headline6.copyWith(
                                  color: Colors.white, fontWeight: FontWeight.w500),
                            ),

                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Deadline",
                              style: Theme.of(context).textTheme.headline6.copyWith(
                                  color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "08-07-2021",
                              style: Theme.of(context).textTheme.headline6.copyWith(
                                  color: Colors.white, fontWeight: FontWeight.w500),
                            ),

                          ],
                        )

                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        Text(
                          "Instructions",
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),// 1/6
                        Text("1-The quizzes responses or how many times you take the quiz"),
                        Text("2-The quizzes responses or how many times you take the quiz"),
                        Text("3-The quizzes responses or how many times you take the quiz"),
                        Text("4-The quizzes responses or how many times you take the quiz"),
                      ],
                    ),
                    InkWell(
                      onTap: () => Get.to(QuizScreen()),
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(kDefaultPadding * 0.75), // 15
                        decoration: BoxDecoration(
                          gradient: kPrimaryGradient,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Text(
                          "Start Quiz",
                          style: Theme.of(context)
                              .textTheme
                              .button
                              .copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
