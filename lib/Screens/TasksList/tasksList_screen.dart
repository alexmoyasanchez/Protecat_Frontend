import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/NewTask/newTask_screen.dart';
import 'package:flutter_auth/Screens/TasksList/components/body.dart';
import 'package:flutter_auth/SideBar.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/data.dart';
import 'package:flutter_auth/models/task_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import '../../models/user_model.dart';

Future<User> getTasks(String email) async {
  User user;
  final data = await http.get(Uri.parse('http://192.168.1.132:3000/tasks/getTaskByUser/' + email));
  var jsonData = json.decode(data.body);
  user = User(id: jsonData["id"], username: jsonData["username"], password: jsonData["password"], email: jsonData["email"], imageUrl: jsonData["imageUrl"], tasks: jsonData["tasks"]);
  
  return user;
}

Future<Task> getTaskById(String id) async {
  Task task;
  final data = await http.get(Uri.parse('http://192.168.1.132:3000/tasks/getTask/' + id));
  var jsonData = json.decode(data.body);
  task= Task(id: jsonData["id"], date: jsonData["date"] ,subject: jsonData["subject"], description: jsonData["description"], done: jsonData["done"], volunteer: jsonData["volunteer"]);
  return task;
}

Future<void> getListOfTasks(List<Task> list) async {
  final data = await http.get(Uri.parse('http://192.168.1.132:3000/tasks/'));
  var jsonData = json.decode(data.body);
  for (var u in jsonData) {
    print(data.body);
    Task task = Task(
        id: u["id"],
        date: u["date"],
        subject: u["subject"],
        description: u["description"],
        done: u["done"],
        volunteer: u["volunteer"]);

    list.add(task);
  }
}

Future<List<Task>> getAllTasks() async {
  List<Task> tasks = [];
  final data = await http.get(Uri.parse('http://192.168.1.132:3000/tasks/'));
  var jsonData = json.decode(data.body);
  for (var u in jsonData) {
    print(data.body);
    Task task = Task(
        id: u["id"],
        date: u["date"],
        subject: u["subject"],
        description: u["description"],
        done: u["done"],
        volunteer: u["volunteer"]);

    tasks.add(task);
  }
  print(tasks.length);
  return tasks;
}

Future<List<Task>> getUnassignedTasks() async {
  List<Task> tasks = [];
  final data = await http.get(Uri.parse('http://192.168.1.132:3000/tasks/'));
  var jsonData = json.decode(data.body);
  for (var u in jsonData) {
    print(data.body);
    Task task = Task(
        id: u["id"],
        date: u["date"],
        subject: u["subject"],
        description: u["description"],
        done: u["done"],
        volunteer: u["volunteer"]);

    if(task.volunteer == null){
      tasks.add(task);
    }
  }
  print(tasks.length);
  return tasks;
}

Future<List<Task>> getAssignedTasks() async {
  List<Task> tasks = [];
  final data = await http.get(Uri.parse('http://192.168.1.132:3000/tasks/'));
  var jsonData = json.decode(data.body);
  for (var u in jsonData) {
    print(data.body);
    Task task = Task(
        id: u["id"],
        date: u["date"],
        subject: u["subject"],
        description: u["description"],
        done: u["done"],
        volunteer: u["volunteer"]);

    if(task.volunteer != null){
      tasks.add(task);
    }
  }
  print(tasks.length);
  return tasks;
}

Future deleteTask(id) async {
  final response = await http.delete(
    Uri.parse('http://192.168.1.132:3000/tasks/delete/' + id + "/" + currentUser.email),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }
  );

  if (response.statusCode == 201) {
  } else {
    throw Exception("Error al eliminar"); 
  }
}

Future<void> updateTask(
    String id, String subject, String description, String date ) async {
  final data = await http.put(
    Uri.parse('http://192.168.1.132:3000/tasks/update/' + id + "/" + currentUser.email),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'id': id,
      'subject': subject,
      'description': description,
      'date': date
    }),
  );
  print(data.request);
  if (data.statusCode == 201) {
    return Task.fromJson(jsonDecode(data.body));
  } else {
    throw Exception('Error al editar la tarea');
  }
}

Future<void> assignTask(String id, String user) async{
  final data = await http.put(
    Uri.parse('http://192.168.1.132:3000/tasks/assignTask/' + id + "/" + user + "/" + currentUser.email),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  print(data.request);
  if (data.statusCode == 201) {
    return Task.fromJson(jsonDecode(data.body));
  } else {
    throw Exception('Error al asignar la tarea');
  }
}

Future<Task> checkTask(
    String id ) async {
  final data = await http.put(
    Uri.parse('http://192.168.1.132:3000/tasks/check/' + id ),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  print(data.request);
  if (data.statusCode == 201) {
    return Task.fromJson(jsonDecode(data.body));
  } else {
    throw Exception('Error al editar la tarea');
  }
}

Future<Task> uncheckTask(
    String id ) async {
  final data = await http.put(
    Uri.parse('http://192.168.1.132:3000/tasks/uncheck/' + id ),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  print(data.request);
  if (data.statusCode == 201) {
    return Task.fromJson(jsonDecode(data.body));
  } else {
    throw Exception('Error al editar la tarea');
  }
}

Future<void> getUserNames() async {
  //final LocalStorage storage = new LocalStorage('My App');
  users=[];
  final data = await http.get(Uri.parse('http://192.168.1.132:3000/users/'),
      headers: <String, String>{
        //'x-access-token': storage.getItem('token'),
      });
  var jsonData = json.decode(data.body);
  for (var u in jsonData) {
    users.add(u["username"]);
  }
}

class TasksListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(
      ),
      appBar: AppBar(
        backgroundColor: Background,
        title: Text(
          "Tareas", 
          style: const TextStyle(
              color: Colors.white,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.2),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white, size: 40),
            onPressed: () async {
              await getUserNames();
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context){
                    return NewTaskScreen();
                  },
                ),
              );
            },
          )
        ],
      ),
      body: Body(),
    );
  }
}
