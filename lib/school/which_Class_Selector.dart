import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:step/shared/textstyle.dart';

class ClassDivisionSelection extends StatefulWidget {
  @override
  _ClassDivisionSelectionState createState() => _ClassDivisionSelectionState();
}

class _ClassDivisionSelectionState extends State<ClassDivisionSelection> {
  List<String> numbers = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'];
  List<String> onlyNeeded = [];

  Widget dynamicChips() {
    return Wrap(
      spacing: 6.0,
      runSpacing: 6.0,
      children: List<Widget>.generate(numbers.length, (int index) {
        return FilterChip(
          label: Text(numbers[index]),
          padding: EdgeInsets.all(4),
          onSelected: (index) {},
        );
      }),
    );
  }

//   List<Company> _companies = <Company>[
//       const Company('Google'),
//       const Company('Apple'),
//       const Company('Microsoft'),
//       const Company('Sony'),
//       const Company('Amazon'),
//  ];

// Iterable<Widget> get companyWidgets sync* {
//     for (Company company in _companies) {
//       yield Padding(
//         padding: const EdgeInsets.all(6.0),
//         child: FilterChip(
//           avatar: CircleAvatar(
//             child: Text(company.name[0].toUpperCase()),
//           ),
//           label: Text(company.name),
//           selected: _filters.contains(company.name),
//           onSelected: (bool selected) {
//             setState(() {
//               if (selected) {
//                 _filters.add(company.name);
//               } else {
//                 _filters.removeWhere((String name) {
//                   return name == company.name;
//                 });
//               }
//             });
//           },
//       ),
//    );
// }

// class Company {
//   const Company(this.name);
//   final String name;
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          dynamicChips(),
        ],
      ),
    );
  }
}



// class ClassDivisionSelection extends StatefulWidget {
//   @override
//   _ClassDivisionSelectionState createState() => _ClassDivisionSelectionState();
// }

// class Animal {
//   final int id;
//   final String name;

//   Animal({
//     this.id,
//     this.name,
//   });
// }

// class _ClassDivisionSelectionState extends State<ClassDivisionSelection> {
//   List<bool> isSelected = List.generate(4, (index) => false);
//   // List<String> numbers = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'];

//   static List<Animal> _animals = [
//     Animal(id: 1, name: "1"),
//     Animal(id: 2, name: "2"),
//     Animal(id: 3, name: "3"),
//     Animal(id: 4, name: "4"),
//     Animal(id: 5, name: "5"),
//     Animal(id: 6, name: "6"),
//     Animal(id: 7, name: "7"),
//     Animal(id: 8, name: "8"),
//     Animal(id: 9, name: "9"),
//     Animal(id: 10, name: "10"),
//     Animal(id: 11, name: "11"),
//     Animal(id: 12, name: "12"),
//   ];
//   final _items = _animals.map((animal) => MultiSelectItem<Animal>(animal, animal.name)).toList();

//   List<Animal> _selectedAnimals = [];
//   // List<Animal> _selectedAnimals2 = [];
//   // List<Animal> _selectedAnimals3 = [];
//   //List<Animal> _selectedAnimals4 = [];
//   List<Animal> _selectedAnimals5 = [];
//   final _multiSelectKey = GlobalKey<FormFieldState>();

//   @override
//   void initState() {
//     _selectedAnimals5 = _animals;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xff040812),
//       appBar: AppBar(),
//       body: Column(
//         children: <Widget>[
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 "Choose amenities",
//                 style: bigtextstyle,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 8.0),
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: Container(
//                 child: Wrap(
//                   spacing: 5.0,
//                   runSpacing: 5.0,
//                   children: <Widget>[
//                     filterChipWidget(chipName: '1'),
//                     filterChipWidget(chipName: '2'),
//                     filterChipWidget(chipName: '3'),
//                     filterChipWidget(chipName: '4'),
//                     filterChipWidget(chipName: '5'),
//                     filterChipWidget(chipName: '6'),
//                     filterChipWidget(chipName: '7'),
//                     filterChipWidget(chipName: '8'),
//                     filterChipWidget(chipName: '9'),
//                     filterChipWidget(chipName: '10'),
//                     filterChipWidget(chipName: '11'),
//                     filterChipWidget(chipName: '12'),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Divider(
//             color: Colors.blueGrey,
//             height: 10.0,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class filterChipWidget extends StatefulWidget {
//   final String chipName;

//   filterChipWidget({Key key, this.chipName}) : super(key: key);

//   @override
//   _filterChipWidgetState createState() => _filterChipWidgetState();
// }

// class _filterChipWidgetState extends State<filterChipWidget> {
//   var _isSelected = false;

//   @override
//   Widget build(BuildContext context) {
//     return FilterChip(
//       label: Text(widget.chipName),
//       labelStyle: TextStyle(color: Color(0xff6200ee), fontSize: 16.0, fontWeight: FontWeight.bold),
//       selected: _isSelected,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(30.0),
//       ),
//       backgroundColor: Color(0xffededed),
//       onSelected: (isSelected) {
//         setState(() {
//           _isSelected = isSelected;
//           // print();
//         });
//       },
//       selectedColor: Color(0xffeadffd),
//     );
//   }
// }
