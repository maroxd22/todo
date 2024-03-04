import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/todo_app/cubit/tasks_cubit.dart';
import 'package:myapp/todo_app/cubit/tasks_state.dart';
import 'package:myapp/todo_app/presntation/widgets/customcontainer.dart';

class DoneTasks extends StatefulWidget {
  const DoneTasks({super.key});

  @override
  State<DoneTasks> createState() => _DoneTasksState();
}

class _DoneTasksState extends State<DoneTasks> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        else if (state is ErrorState) {
          return Center(child: Icon(Icons.error, size: 100));
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            return TaskView(
              model: context
                  .read<TasksCubit>()
                  .doneTasks[index],
            );
          },
          itemCount: context
              .read<TasksCubit>()
              .doneTasks
              .length,
        );
      },

    );
  }
  }
