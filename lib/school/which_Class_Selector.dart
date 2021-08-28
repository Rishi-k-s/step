import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ClassDivisionSelection extends StatefulWidget {
  @override
  _ClassDivisionSelectionState createState() => _ClassDivisionSelectionState();
}

class Animal {
  final int id;
  final String name;

  Animal({
    this.id,
    this.name,
  });
}

class _ClassDivisionSelectionState extends State<ClassDivisionSelection> {
  List<bool> isSelected = List.generate(4, (index) => false);
  // List<String> numbers = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'];

  static List<Animal> _animals = [
    Animal(id: 1, name: "1"),
    Animal(id: 2, name: "2"),
    Animal(id: 3, name: "3"),
    Animal(id: 4, name: "4"),
    Animal(id: 5, name: "5"),
    Animal(id: 6, name: "6"),
    Animal(id: 7, name: "7"),
    Animal(id: 8, name: "8"),
    Animal(id: 9, name: "9"),
    Animal(id: 10, name: "10"),
    Animal(id: 11, name: "11"),
    Animal(id: 12, name: "12"),
  ];
  final _items = _animals.map((animal) => MultiSelectItem<Animal>(animal, animal.name)).toList();

  List<Animal> _selectedAnimals = [];
  // List<Animal> _selectedAnimals2 = [];
  // List<Animal> _selectedAnimals3 = [];
  //List<Animal> _selectedAnimals4 = [];
  List<Animal> _selectedAnimals5 = [];
  final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    _selectedAnimals5 = _animals;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: MultiSelectChipField<Animal>(
        items: _items,
        key: _multiSelectKey,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue[700], width: 1.8),
        ),
        selectedChipColor: Colors.blue.withOpacity(0.5),
        selectedTextStyle: TextStyle(color: Colors.blue[800]),
        itemBuilder: (item, state) {
          // return your custom widget here
          return InkWell(
            onTap: () {
              _selectedAnimals.contains(item.value) ? _selectedAnimals.remove(item.value) : _selectedAnimals.add(item.value);
              state.didChange(_selectedAnimals);
              _multiSelectKey.currentState.validate();
            },
            child: Text(item.value.name),
          );
        },
      ),
    );
  }
}
