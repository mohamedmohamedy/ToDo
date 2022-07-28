import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/task.dart';

import './states.dart';

class TasksCubit extends Cubit<TasksStates> {
  TasksCubit() : super(BoardInitialState());

  static TasksCubit get(context) => BlocProvider.of(context);

//........................initialize database.................................
  Future<void> initialDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'newTasksDatabase.db');

    debugPrint('Database Initialized');

    openTasksDatabase(path);

    emit(TasksDatabaseInitialized());
  }

//..............................creating database..............................
  late Database database;

  Future<void> openTasksDatabase(String path) async {
    await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE newTasksDatabase (id INTEGER PRIMARY KEY, title TEXT, startTime TEXT, endTime TEXT, date TEXT, reminder TEXT, repeat TEXT, favorite TEXT, completed TEXT, color TEXT)');
      debugPrint('database created');
    }, onOpen: (Database db) async {
      debugPrint('database opened');
      database = db;
      fetchData();
    });
  }

//............................insert into database...................................
  Future<void> insertIntoDatabase(TaskModel taskModel) async {
    await database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO newTasksDatabase(title,startTime,endTime,date,reminder,repeat,favorite,completed,color) VALUES("${taskModel.title}","${taskModel.startTime}","${taskModel.endTime}","${taskModel.date}","${taskModel.reminder}","${taskModel.repeat}","${taskModel.favorite}","${taskModel.completed}","${taskModel.color}")');
      debugPrint('insert data into database');
    });
    fetchData();
    emit(InsertDataToTasksDatabaseState());
  }

  //.............................Fetch data from database............................
  List<Map> _tasksData = [];

  List<Map> get tasksData => [..._tasksData];

  Future<void> fetchData() async {
    // Get the records
    final response = await database.rawQuery('SELECT * FROM newTasksDatabase');

    _tasksData = response;

    debugPrint('fetchedData');
    emit(FetchDataState());
  }

  //____________________________Get tasks______________________________________________
  List<Map> get completedTasks {
    return _tasksData
        .where((element) => element['completed'] == 'true')
        .toList();
  }

  List<Map> get uncompletedTasks {
    return _tasksData
        .where((element) => element['completed'] == 'false')
        .toList();
  }

  List<Map> get favoriteTasks {
    return _tasksData
        .where((element) => element['favorite'] == 'true')
        .toList();
  }

  List<Map> dataTasks(String date) {
    return _tasksData.where((element) => element['date'] == date).toList();
  }

//__________________________________change tasks status________________________________________
  Future<void> changeTaskStatus(
      int id, String statusKind, String status) async {
    await database.rawUpdate(
        'UPDATE newTasksDatabase SET $statusKind= ? WHERE id = $id', [status]);
    debugPrint('Task status changed');
    fetchData();
  }

  Future<void> markAsCompleted(int id) async {
    await changeTaskStatus(id, 'completed', 'true');
  }
 
  Future<void> markAsUnCompleted(int id) async {
    await changeTaskStatus(id, 'completed', 'false');
  }
 
  Future<void> markAsFavorite(int id) async {
    await changeTaskStatus(id, 'favorite', 'true');
  }
 
  Future<void> removeFromFavorites(int id) async {
    await changeTaskStatus(id, 'favorite', 'false');
  }

  //_____________________Delete some record______________________________

  Future<void> deleteTask(int id) async {
    await database
        .rawDelete('DELETE FROM newTasksDatabase WHERE id = ?', ['$id']);
    debugPrint('Task deleted');
    fetchData();
  }
}
