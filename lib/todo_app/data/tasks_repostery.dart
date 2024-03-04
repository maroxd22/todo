import 'package:myapp/todo_app/data/task_model.dart';
import 'package:sqflite/sqflite.dart';

class TaskRepostery {
  static late final Database db;

  static Future<void> initDb() async {
    db = await openDatabase('todo.db', version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Tasks (id INTEGER PRIMARY KEY,title  TEXT, subtitle TEXT, date TEXT, isChecked INTEGER )');
      print('DataBase Created');
    }, onOpen: (db) {
      print('DataBase opened');
    });
  }

  static Future<void> insertDb(TaskModel task) async {
    final check = task.isChecked ? 1 : 0;

    await db.transaction(
      (txn) async {
      int id =  await txn.rawInsert(
            'INSERT INTO Tasks(title,subtitle, date,isChecked) VALUES("${task.title}", "${task.subTitle}","${task.date}", $check)');
      print('row $id inserted');
      },
    );

  }
   static Future<List<TaskModel>> gettasks() async{

    List<Map> list = await db.rawQuery('SELECT * FROM Tasks');
    List<TaskModel> mytasks = [];
    print(list);
    for( var x in list){
       final task = TaskModel(date: x['date'],
           title: x['title'],
           subTitle: x['subtitle'],
           isChecked: x['isChecked'] == 0 ? false : true,
          id: x['id']);
       mytasks.add(task);
    }
    print(mytasks.length);
    return mytasks;
  }
  static Future<void> togleCheck(TaskModel task) async{
 final check =  task.isChecked ? 0 :1;
      int count = await db.rawUpdate(
          'UPDATE Tasks SET isChecked = $check WHERE  id = ${task.id}');
      print('updated: $count');

  }
  static Future<void> deleteTask(TaskModel task)async{
  var  count = await db
        .rawDelete('DELETE FROM Tasks WHERE id = ${task.id}');
  print('${count} deleted');

  }
}
