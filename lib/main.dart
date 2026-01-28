import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_ad_2/vieew/user_screen_ui.dart';
import 'package:sqlite_ad_2/view_model/task_view_model.dart';
import 'package:sqlite_ad_2/view_model/user_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => TaskViewModel()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: UserScreen(),
      ),
    );
  }
}
