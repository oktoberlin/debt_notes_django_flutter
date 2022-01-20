import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'page/notes_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'debt_notes_dkm';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        //themeMode: ThemeMode.light,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            //backgroundColor: Colors.transparent,
            elevation: 2,
          ),
        ),
        home: const NotesPage(),
      );
}
