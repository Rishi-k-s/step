import 'package:flutter/material.dart';
import 'package:step/shared/textstyle.dart';
import 'package:step/teacher/add_classes_for_students/create_class_by_teacher.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:dropdown_search/dropdown_search.dart';

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

class ViewAddClassByTeacher extends StatefulWidget {
  @override
  _ViewAddClassByTeacherState createState() => _ViewAddClassByTeacherState();
}

class _ViewAddClassByTeacherState extends State<ViewAddClassByTeacher> {
  @override
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff040812),
      appBar: AppBar(
        backgroundColor: Color(0xff0a2057),
        title: Text(
          'Add Virtual Classes',
          style: commontextstylewhite,
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15, 20, 15, 15),
              child: DropdownSearch(),
            )
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 27,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateClassPage()),
          );
        },
      ),
    );
  }
}

// Table Calendar Code

// SingleChildScrollView(
//   child: SafeArea(
//       child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Card(
//         clipBehavior: Clip.antiAlias,
//         margin: const EdgeInsets.all(8.0),
//         child: TableCalendar(
//           //should continue from , on format changed
//           calendarFormat: CalendarFormat.week,
//           onFormatChanged: (format) {},
//           focusedDay: _focusedDay,
//           firstDay: kFirstDay,
//           lastDay: kLastDay,
//           weekendDays: [7],
//           headerStyle: HeaderStyle(
//             decoration: BoxDecoration(color: Colors.lightBlue[900]),
//             headerMargin: const EdgeInsets.only(bottom: 10.0),
//             titleTextStyle: TextStyle(color: Colors.white, fontSize: 20.0),
//             formatButtonDecoration: BoxDecoration(
//               border: Border.all(color: Colors.white),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             formatButtonTextStyle: commontextstylewhite,
//             leftChevronIcon: Icon(
//               Icons.chevron_left,
//               color: Colors.white,
//               size: 30.0,
//             ),
//             rightChevronIcon: Icon(
//               Icons.chevron_right,
//               color: Colors.white,
//               size: 30.0,
//             ),
//           ),
//           calendarStyle: CalendarStyle(
//             // markerDecoration: BoxDecoration(
//             //   borderRadius: BorderRadius.circular(9.0),
//             //   color: Colors.amber,
//             // ),
//             outsideTextStyle: TextStyle(
//               color: Colors.grey,
//               fontSize: 22.0,
//             ),
//             weekendTextStyle: TextStyle(
//               color: Colors.red[400],
//               fontSize: 22.0,
//             ),
//             defaultTextStyle: TextStyle(
//               color: Colors.black,
//               fontSize: 22.0,
//             ),
//             todayTextStyle: TextStyle(
//               color: Colors.white,
//               fontSize: 22.0,
//             ),
//             selectedTextStyle: TextStyle(
//               color: Colors.blue[800],
//               fontSize: 22.0,
//             ),
//             // selectedDecoration: BoxDecoration(color: Colors.black),
//           ),
//           calendarBuilders: CalendarBuilders(),
//         ),
//       )
//     ],
//   )),
// ),
