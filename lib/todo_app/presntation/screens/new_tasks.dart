import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/todo_app/cubit/tasks_cubit.dart';
import 'package:myapp/todo_app/cubit/tasks_state.dart';
import 'package:myapp/todo_app/data/task_model.dart';
import 'package:myapp/todo_app/presntation/screens/home_screen.dart';

import '../../data/tasks_repostery.dart';
import '../widgets/customcontainer.dart';

class NewTasks extends StatelessWidget{
  const NewTasks({super.key});



  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit,TasksState>(
      builder:(context, state){
        if(state is LoadingState){
          return Center(child: CircularProgressIndicator());
        }
        else if(state is ErrorState){
          return Center(child: Icon(Icons.error,size: 100));
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            return TaskView(
              model: context.read<TasksCubit>().newTasks[index],
            );
          },
          itemCount: context.read<TasksCubit>().newTasks.length,
        );
      },

    );
  }
  }
