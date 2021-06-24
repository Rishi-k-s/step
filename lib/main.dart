import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:step/models/usermodels.dart';
import 'package:step/services/auth.dart';
import 'package:step/wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Step());
}

class Step extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<StepUser>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(
            fontFamily: 'LexendDeca',
            textTheme: TextTheme(
              bodyText1: TextStyle(color: Colors.white),
              bodyText2: TextStyle(color: Colors.white),
            )),
        home: StepHome(),
      ),
    );
  }
}

class StepHome extends StatefulWidget {
  @override
  _StepHomeState createState() => _StepHomeState();
}

class _StepHomeState extends State<StepHome> {
  @override
  Widget build(BuildContext context) {
    return Wrapper();
  }
}
