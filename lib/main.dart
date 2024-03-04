import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/bmi_calculator/bmi_calculator.dart';
import 'package:myapp/counter_app/cubit/counter.dart';
import 'package:myapp/counter_app/cubit/cubit.dart';
import 'package:myapp/todo_app/cubit/tasks_cubit.dart';
import 'package:myapp/todo_app/data/tasks_repostery.dart';
import 'package:myapp/todo_app/presntation/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bmi_calculator/login_screen.dart';
import 'firebase_options.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
   );
   await TaskRepostery.initDb();
  final prefs = await SharedPreferences.getInstance();
  bool logged = prefs.getBool('isLogin') ?? false;
  String? email = prefs.getString('name');
  runApp( MainApp(isLoggedIn: logged,name:email,));
}

class MainApp extends StatelessWidget {
  const MainApp({required this.isLoggedIn, super.key, required this.name});
  final bool isLoggedIn;
  final String? name;
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context)=> TasksCubit()..loadTasks(),
      child: MaterialApp(
        home: isLoggedIn ? HomeScreen() :  LoginScreen(),
      ),
    );
  }
  // multiBlocProvider
}


