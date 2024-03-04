import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/todo_app/cubit/tasks_cubit.dart';
import 'package:myapp/todo_app/data/tasks_repostery.dart';

import '../../data/task_model.dart';

class TaskView extends StatefulWidget {
  TaskView({
    super.key,
    required this.model,
  });
  final TaskModel model;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey('${widget.model.title},${widget.model.subTitle},${widget.model.date}'),
      onDismissed: (direction){
        context.read<TasksCubit>().deleteTasks(widget.model);
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 50,
              child: Text(
                widget.model.date,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Text(
                  widget.model.title,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.model.subTitle,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ],
            ),
            Spacer(),
            Checkbox(
              value: widget.model.isChecked,
              onChanged: (value) {
                context.read<TasksCubit>().togleTasks(widget.model);
                setState(() {
                  widget.model.isChecked = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
