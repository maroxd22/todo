import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/bmi_calculator/login_screen.dart';
import 'package:myapp/todo_app/cubit/tasks_cubit.dart';
import 'package:myapp/todo_app/cubit/tasks_state.dart';
import 'package:myapp/todo_app/data/task_model.dart';
import 'package:myapp/todo_app/data/tasks_repostery.dart';
import 'package:myapp/todo_app/presntation/screens/archived_tasks.dart';
import 'package:myapp/todo_app/presntation/screens/done_tasks.dart';
import 'package:myapp/todo_app/presntation/screens/new_tasks.dart';
import 'package:myapp/todo_app/presntation/widgets/customcontainer.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController subtitlecontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  int currentIndex = 0;
  List<Widget> myList = [
    NewTasks(),
    DoneTasks(),
    ArchiveTasks(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit,TasksState>(
      builder:(context,state) {
        return
          Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.task), label: '${myList[0]}'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.done), label: '${myList[1]}'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: '${myList[2]}'),
              ],
            ),
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              actions: [
                IconButton(onPressed: ()async{
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('isLogin', false);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                    return LoginScreen();
                  }));
                },
                  icon: Icon(Icons.logout),
                ),
              ],
              title: Center(
                child: Text(
                  'Todo Screen',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            body: myList[currentIndex],
            // ListView.builder(
            //   itemBuilder: (context, index) {
            //     return TaskView(
            //       model: myTasks[index],
            //     );
            //   },
            //   itemCount: myTasks.length,
            // ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // setState(() {
                //   myTasks.add(
                //       TaskModel(date: '1/2/2020', title: 'home', subTitle: 'work'));
                // });
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        width: double.infinity,
                        height: 300,
                        color: Colors.blue,
                        child: Column(
                          children: [
                            TextField(
                              controller: titlecontroller,
                              decoration: InputDecoration(
                                hintText: 'Title',
                              ),
                            ),
                            TextField(
                              controller: subtitlecontroller,
                              decoration: InputDecoration(
                                hintText: 'SubTitle',
                              ),
                            ),
                            TextField(
                              controller: datecontroller,
                              decoration: InputDecoration(
                                hintText: 'Date',
                              ),
                              onTap: () {
                                setState(() {
                                  showDatePicker(
                                      context: context,
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2025))
                                      .then((value) {
                                    datecontroller.text =
                                        DateFormat.MEd().format(value!);
                                  });
                                });
                              },
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  final task = TaskModel(
                                      date: datecontroller.text,
                                      title: titlecontroller.text,
                                      subTitle: subtitlecontroller.text);
                                  // myTasks.add(task);
                                  // TaskRepostery.insertDb(task);
                                  context.read<TasksCubit>().addTask(task);
                                });
                                titlecontroller.clear();
                                datecontroller.clear();
                                subtitlecontroller.clear();
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Save',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
              child: Icon(Icons.add),
            ),
          );
      }
    );
  }

}
