// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:myapp/todo_app/cubit/tasks_cubit.dart';
// import 'package:myapp/todo_app/data/tasks_repostery.dart';
// import 'package:myapp/todo_app/presntation/screens/home_screen.dart';
//
//
//
// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await TaskRepostery.initDb();
//   runApp(const MainApp());
// }
//
// class MainApp extends StatelessWidget {
//   const MainApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context)=> TasksCubit()..loadTasks(),
//       child: const MaterialApp(
//         home: HomeScreen(),
//       ),
//     );
//   }
// }
