import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:step/shared/textstyle.dart';
import 'package:step/teacher/add_activities_for_students/add_activities_buttons/add_text.dart';

class CreateChapterByTeachers extends StatefulWidget {
  @override
  _CreateChapterByTeachersState createState() => _CreateChapterByTeachersState();
}

class _CreateChapterByTeachersState extends State<CreateChapterByTeachers> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  bool floatingActionButtonVisible = true;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    final curvedAnimation = CurvedAnimation(curve: Curves.easeInOutSine, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff040812),
      appBar: AppBar(
        backgroundColor: Color(0xff0a2057),
        title: Text(
          'Add New Chapter',
          style: commontextstylewhite,
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 30.0,
            ),
            Container()
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: floatingActionButtonVisible,
        child: FloatingActionBubble(
          items: <Bubble>[
            // Floating action menu items
            // Bubble(
            //   title: "View Chapter",
            //   iconColor: Colors.white,
            //   bubbleColor: Colors.cyan[800],
            //   icon: Icons.view_agenda_outlined,
            //   titleStyle: TextStyle(fontSize: 16, color: Colors.white),
            //   onPress: () {
            //     _animationController.reverse();
            //   },
            // ),
            Bubble(
              title: "Add Text",
              iconColor: Colors.white,
              bubbleColor: Colors.cyan[800],
              icon: Icons.text_fields,
              titleStyle: TextStyle(fontSize: 16, color: Colors.white),
              onPress: () {
                _animationController.reverse();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddTextCard()),
                );
              },
            ),
            Bubble(
              title: "Add PDF",
              iconColor: Colors.white,
              bubbleColor: Colors.cyan[800],
              icon: Icons.picture_as_pdf,
              titleStyle: TextStyle(fontSize: 16, color: Colors.white),
              onPress: () {
                _animationController.reverse();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateChapterByTeachers()),
                );
              },
            ),
            Bubble(
              title: "Add Slides",
              iconColor: Colors.white,
              bubbleColor: Colors.cyan[800],
              icon: Icons.add_chart,
              titleStyle: TextStyle(fontSize: 16, color: Colors.white),
              onPress: () {
                _animationController.reverse();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateChapterByTeachers()),
                );
              },
            ),
            Bubble(
              title: "Add Videos",
              iconColor: Colors.white,
              bubbleColor: Colors.cyan[800],
              icon: Icons.video_collection_rounded,
              titleStyle: TextStyle(fontSize: 16, color: Colors.white),
              onPress: () {
                _animationController.reverse();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateChapterByTeachers()),
                );
              },
            ),
          ],
          onPress: () {
            _animationController.isCompleted ? _animationController.reverse() : _animationController.forward();
          },
          iconColor: Colors.white,
          backGroundColor: Colors.cyan[800],
          animation: _animation,
          // iconData: Icons.add,
          animatedIconData: AnimatedIcons.menu_close,
        ),
      ),
    );
  }
}
