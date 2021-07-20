import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:step/google_Secrets.dart';
import 'package:step/quiz/screens/welcome/welcome_screen.dart';
import 'package:step/services/calendar_services/calendar_client.dart';
import 'package:step/models/usermodels.dart';
import 'package:step/services/auth.dart';
import 'package:step/wrapper.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis/calendar/v3.dart' as cal;
import 'package:url_launcher/url_launcher.dart';

import 'dummy_list.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  // var _clientID = new ClientId(Secret.getId(), "");
  // const _scopes = const [cal.CalendarApi.calendarScope];
  //
  // await clientViaUserConsent(_clientID, _scopes, prompt).then((AuthClient client) async {
  //   CalendarClient.calendar = cal.CalendarApi(client);
  // });

  runApp(Step());
}

void prompt(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Error launching $url';
  }
}

class Step extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<StepUser>.value(
      initialData: null,
      value: AuthService().user,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'LexendDeca',
            textTheme: TextTheme(
              bodyText1: TextStyle(color: Colors.white),
              bodyText2: TextStyle(color: Colors.white),
            )),
        // theme: ThemeData.dark(),
        home: WelcomeScreen(),
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
