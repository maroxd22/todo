import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/todo_app/cubit/tasks_state.dart';
import 'package:myapp/todo_app/data/task_model.dart';
import 'package:myapp/todo_app/data/tasks_repostery.dart';

class TasksCubit extends Cubit<TasksState>{
  TasksCubit() : super(InitialState());
    List<TaskModel> newTasks = [];
    List<TaskModel> doneTasks = [];

   addTask(TaskModel task)async{
     await TaskRepostery.insertDb(task);
     loadTasks();
   }
   loadTasks()async{
     newTasks.clear();
     doneTasks.clear();
     emit(LoadingState());
     try {
       final mytasks = await TaskRepostery.gettasks();
       for( var x in mytasks){
         if(x.isChecked ){
           doneTasks.add(x);
         }
         else{
           newTasks.add(x);
         }
       }
       emit(LoadedState());
     }catch(e){
       emit(ErrorState());
     }
   }
   deleteTasks (TaskModel task)async{
   await TaskRepostery.deleteTask(task);
     loadTasks();
   }
   togleTasks(TaskModel task)async{
     await TaskRepostery.togleCheck(task);
     loadTasks();
   }
}

