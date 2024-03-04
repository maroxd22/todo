import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/todo_app/cubit/tasks_cubit.dart';
import 'package:myapp/todo_app/cubit/tasks_state.dart';
import 'package:myapp/todo_app/presntation/widgets/customcontainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ArchiveTasks extends StatelessWidget {
   ArchiveTasks({super.key});

  @override
  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            hintText: 'Name',
            border: OutlineInputBorder(),
          ),
        ),
        TextField(
          controller: jobController,
          decoration: InputDecoration(
            hintText: 'Job',
            border: OutlineInputBorder(),
          ),
        ),
        TextField(
          controller: ageController,
          decoration: InputDecoration(
            hintText: 'Age',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: (){
              final db = FirebaseFirestore.instance;
              // Create a new user with a first and last name
              final user = <String, dynamic>{
                "name": "${nameController.text}",
                "job": "${jobController.text}",
                "age": "${ageController.text}",
              };

// Add a new document with a generated ID
              db.collection("userData").add(user).then((DocumentReference doc) =>
                  print('DocumentSnapshot added with ID: ${doc.id}'));
            },
            child: Text('Save'),
        ),
      ],
    );
  }
}
