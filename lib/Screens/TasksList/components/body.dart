import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/NewTask/newTask_screen.dart';
import 'package:flutter_auth/Screens/TasksList/tasksList_screen.dart';
import 'package:flutter_auth/SideBar.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field_extended.dart';
import 'package:flutter_auth/components/rounded_input_field_sex.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/data.dart';
import 'package:flutter_auth/models/user_model.dart';
import 'dart:async';

import '../../../models/task_model.dart';

class Body extends StatelessWidget {
  final Future<User> user;

  IconButton icon, icon2, icon3;

  String volunteerUsername;

  Body({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xfff0e1f8),
      child: Center(
          child: FutureBuilder(
              future: getAllTasks(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                print(snapshot.data);
                if (snapshot.data == null) {
                  return Container(
                      child: Center(
                          child:
                              CircularProgressIndicator(color: Colors.white)));
                } else {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 70.0,
                            width: MediaQuery.of(context).size.width,
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: [
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.035),
                                RoundedButton(
                                  margin: 10,
                                  text: "Mis tareas",
                                  color: Background,
                                  textColor: DetailsColor,
                                  height: 10.0,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  press: () {
                                    Navigator.push(
                                      context,
                                      new PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            MyTasksPage(),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          return child;
                                        },
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(width: 5.0),
                                RoundedButton(
                                  margin: 10,
                                  text: "Tareas asignadas",
                                  color: Background,
                                  textColor: DetailsColor,
                                  height: 10.0,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  press: () {
                                    Navigator.push(
                                      context,
                                      new PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            AssignedTasksPage(),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          return child;
                                        },
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(width: 5.0),
                                RoundedButton(
                                  margin: 10,
                                  text: "Tareas por asignar",
                                  color: Background,
                                  textColor: DetailsColor,
                                  height: 10.0,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  press: () {
                                    Navigator.push(
                                      context,
                                      new PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            UnassignedTasksPage(),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          return child;
                                        },
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.035),
                              ],
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: ListView.separated(
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Divider(
                                  indent: 20.0,
                                  endIndent: 20.0,
                                  thickness: 1.0,
                                  color: Background,
                                ),
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if (snapshot.data[index].volunteer == null) {
                                    icon = IconButton(
                                      icon: Icon(Icons.abc),
                                      iconSize: 0,
                                      onPressed: () {},
                                    );
                                    volunteerUsername = "";
                                    icon2 = IconButton(
                                      icon: Icon(Icons.person_add,
                                          color: Background),
                                      onPressed: () async {
                                        await getUserNames();
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) =>
                                                    AssignTaskPage(
                                                        snapshot.data[index])));
                                      },
                                    );
                                    icon3 = IconButton(
                                      icon: Icon(Icons.edit_rounded,
                                          color: Background),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) => EditPage(
                                                    snapshot.data[index])));
                                      },
                                    );
                                  } else {
                                    if (snapshot.data[index]
                                            .volunteer[0]["username"] ==
                                        currentUser.username) {
                                      if (snapshot.data[index].done == true) {
                                        icon = IconButton(
                                          iconSize: 25,
                                          icon: Icon(Icons.check_box_outlined),
                                          onPressed: () {
                                            uncheckTask(
                                                snapshot.data[index].id);
                                            Navigator.push(
                                              context,
                                              new PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation,
                                                        secondaryAnimation) =>
                                                    TasksListScreen(),
                                                transitionsBuilder: (context,
                                                    animation,
                                                    secondaryAnimation,
                                                    child) {
                                                  return child;
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        icon = IconButton(
                                          iconSize: 25,
                                          icon: Icon(Icons.crop_square),
                                          onPressed: () {
                                            checkTask(snapshot.data[index].id);
                                            Navigator.push(
                                              context,
                                              new PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation,
                                                        secondaryAnimation) =>
                                                    TasksListScreen(),
                                                transitionsBuilder: (context,
                                                    animation,
                                                    secondaryAnimation,
                                                    child) {
                                                  return child;
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    } else {
                                      icon = IconButton(
                                        icon: Icon(Icons.abc),
                                        iconSize: 0,
                                        onPressed: () {},
                                      );
                                    }
                                    volunteerUsername = snapshot
                                        .data[index].volunteer[0]["username"];
                                    icon2 = IconButton(
                                      icon: Icon(Icons.person_add,
                                          color: Background2, size: 0),
                                      onPressed: () {},
                                    );
                                    icon3 = IconButton(
                                      icon: Icon(Icons.person_add,
                                          color: Background2, size: 0),
                                      onPressed: () {},
                                    );
                                  }
                                  return Material(
                                    child: ListTile(
                                      tileColor: Background2,
                                      leading: IconButton(
                                        iconSize: 25,
                                        onPressed: () {},
                                        icon: icon,
                                      ),
                                      title: Text(
                                        snapshot.data[index].subject,
                                        style: TextStyle(
                                            color: Background,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                          "Voluntaria asignada: " +
                                              volunteerUsername,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          )),
                                      trailing: Wrap(
                                        children: <Widget>[
                                          icon3,
                                          icon2,
                                        ],
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailPage(
                                                        snapshot.data[index])));
                                      },
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }
              })),
    );
  }
}

class DetailPage extends StatefulWidget {
  final Task task;

  DetailPage(this.task);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  DateTime dt = new DateTime(0, 0, 0, 0, 0, 0);

  String valUser, volunteerUsername;

  String date;

  RoundedButton button;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    date = widget.task.date.substring(0, 10);
    if (widget.task.volunteer != null) {
      volunteerUsername = widget.task.volunteer[0]["username"];
      button = RoundedButton(
        margin: 10,
        text: "",
        color: Background2,
        textColor: Background2,
        height: 20.0,
        press: () {},
      );
    } else if (volunteerUsername2 != null) {
      volunteerUsername = volunteerUsername2;
      volunteerUsername2 = null;
      button = RoundedButton(
        margin: 10,
        text: "",
        width: size.width * 0.5,
        color: Background2,
        textColor: Background2,
        height: 20.0,
        press: () {},
      );
    } else {
      volunteerUsername = "Tarea no asignada";
      button = RoundedButton(
        margin: 10,
        text: "Asignar tarea",
        color: Background,
        textColor: Background2,
        width: size.width * 0.8,
        height: 20.0,
        press: () async {
          await getUserNames();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AssignTaskPage(widget.task);
              },
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Color(0xfff0e1f8),
      drawer: SideBar(),
      appBar: AppBar(
        backgroundColor: Background,
        title: Text(
          "Tarea",
          style: const TextStyle(
              color: Colors.white,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.2),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.mode_edit_outlined, color: Colors.white, size: 35),
            iconSize: 25,
            onPressed: () {
              currentPhoto = null;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return EditPage(widget.task);
                  },
                ),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 70),
        child: ListView(
          children: <Widget>[
            SizedBox(height: size.height * 0.11),
            Text(
              "Asunto",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Background, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.task.subject,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            Divider(
              indent: 20.0,
              endIndent: 20.0,
              color: Background,
              thickness: 2.0,
            ),
            Text(
              "Descripción",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Background, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.task.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            Divider(
              indent: 20.0,
              endIndent: 20.0,
              color: Background,
              thickness: 2.0,
            ),
            Text(
              "Fecha",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Background, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              date.split("-")[2] +
                  "/" +
                  date.split("-")[1] +
                  "/" +
                  date.split("-")[0],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            Divider(
              indent: 20.0,
              endIndent: 20.0,
              color: Background,
              thickness: 2.0,
            ),
            Text(
              "Voluntaria asignada",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Background, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              volunteerUsername,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20.0),
            button,
          ],
        ),
      ),
    );
  }
}

class MyTasksPage extends StatefulWidget {
  @override
  State<MyTasksPage> createState() => _MyTasksPageState();
}

class _MyTasksPageState extends State<MyTasksPage> {
  IconButton icon;
  String volunteerUsername;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
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
            iconSize: 25,
            icon: Icon(Icons.add, color: Colors.white, size: 40),
            onPressed: () async {
              await getUserNames();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return NewTaskScreen();
                  },
                ),
              );
            },
          )
        ],
      ),
      body: Container(
        color: Color(0xfff0e1f8),
        child: Center(
            child: FutureBuilder(
                future: getTasks(currentUser.email),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  print(snapshot.data);
                  if (snapshot.data == null) {
                    return Container(
                        child: Center(
                            child: CircularProgressIndicator(
                                color: Colors.white)));
                  } else {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 70.0,
                              width: MediaQuery.of(context).size.width,
                              child: ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.035),
                                  RoundedButton(
                                    margin: 10,
                                    text: "Mis tareas",
                                    color: DetailsColor,
                                    textColor: Background,
                                    height: 10.0,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    press: () {
                                      Navigator.push(
                                        context,
                                        new PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              TasksListScreen(),
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            return child;
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(width: 5.0),
                                  RoundedButton(
                                    margin: 10,
                                    text: "Tareas asignadas",
                                    color: Background,
                                    textColor: DetailsColor,
                                    height: 10.0,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    press: () {
                                      Navigator.push(
                                        context,
                                        new PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              AssignedTasksPage(),
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            return child;
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(width: 5.0),
                                  RoundedButton(
                                    margin: 10,
                                    text: "Tareas por asignar",
                                    color: Background,
                                    textColor: DetailsColor,
                                    height: 10.0,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    press: () {
                                      Navigator.push(
                                        context,
                                        new PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              UnassignedTasksPage(),
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            return child;
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.035),
                                ],
                              ),
                            )
                          ],
                        ),
                        Expanded(
                          child: Row(children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: ListView.separated(
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Divider(
                                  indent: 20.0,
                                  endIndent: 20.0,
                                  thickness: 1.0,
                                  color: Background,
                                ),
                                itemCount: snapshot.data.tasks.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if (snapshot.data.tasks[index]["done"] ==
                                      true) {
                                    icon = IconButton(
                                      iconSize: 25,
                                      icon: Icon(Icons.check_box_outlined),
                                      onPressed: () {
                                        uncheckTask(
                                            snapshot.data.tasks[index]["id"]);
                                        Navigator.push(
                                          context,
                                          new PageRouteBuilder(
                                            pageBuilder: (context, animation,
                                                    secondaryAnimation) =>
                                                MyTasksPage(),
                                            transitionsBuilder: (context,
                                                animation,
                                                secondaryAnimation,
                                                child) {
                                              return child;
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    icon = IconButton(
                                      iconSize: 25,
                                      icon: Icon(Icons.crop_square),
                                      onPressed: () {
                                        checkTask(
                                            snapshot.data.tasks[index]["id"]);
                                        Navigator.push(
                                          context,
                                          new PageRouteBuilder(
                                            pageBuilder: (context, animation,
                                                    secondaryAnimation) =>
                                                MyTasksPage(),
                                            transitionsBuilder: (context,
                                                animation,
                                                secondaryAnimation,
                                                child) {
                                              return child;
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  }
                                  if (snapshot.data.username == null) {
                                    volunteerUsername = "Tarea no asignada";
                                  } else {
                                    volunteerUsername = snapshot.data.username;
                                  }
                                  return Material(
                                    child: ListTile(
                                      tileColor: Background2,
                                      leading: IconButton(
                                        iconSize: 25,
                                        onPressed: () {},
                                        icon: icon,
                                      ),
                                      title: Text(
                                        snapshot.data.tasks[index]["subject"],
                                        style: TextStyle(
                                            color: Background,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                          "Voluntaria asignada: " +
                                              volunteerUsername,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          )),
                                      trailing: Wrap(
                                        children: <Widget>[
                                          IconButton(
                                            iconSize: 25,
                                            icon: Icon(Icons.edit_rounded,
                                                color: Background),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  new MaterialPageRoute(
                                                      builder: (context) => EditPage(Task(
                                                          id: snapshot.data.tasks[index]
                                                              ["id"],
                                                          date: snapshot.data.tasks[index]
                                                              ["date"],
                                                          subject: snapshot.data
                                                                  .tasks[index]
                                                              ["subject"],
                                                          description: snapshot
                                                                  .data
                                                                  .tasks[index]
                                                              ["description"],
                                                          done: snapshot.data
                                                                  .tasks[index]
                                                              ["done"],
                                                          volunteer: null))));
                                            },
                                          ),
                                          IconButton(
                                            iconSize: 25,
                                            icon: Icon(
                                                Icons.delete_outline_rounded,
                                                color: Background),
                                            onPressed: () async {
                                              await deleteTask(snapshot
                                                  .data.tasks[index]["id"]);
                                              Navigator.push(
                                                  context,
                                                  new MaterialPageRoute(
                                                      builder: (context) =>
                                                          MyTasksPage()));
                                            },
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        volunteerUsername2 =
                                            currentUser.username;
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) => DetailPage(Task(
                                                    id: snapshot.data.tasks[index]
                                                        ["id"],
                                                    date: snapshot.data
                                                        .tasks[index]["date"],
                                                    subject: snapshot
                                                            .data.tasks[index]
                                                        ["subject"],
                                                    description:
                                                        snapshot.data.tasks[index]
                                                            ["description"],
                                                    done: snapshot.data
                                                        .tasks[index]["done"],
                                                    volunteer: null))));
                                      },
                                    ),
                                  );
                                },
                              ),
                            )
                          ]),
                        )
                      ],
                    );
                  }
                })),
      ),
    );
  }
}

class UnassignedTasksPage extends StatefulWidget {
  @override
  State<UnassignedTasksPage> createState() => _UnassignedTasksPageState();
}

class _UnassignedTasksPageState extends State<UnassignedTasksPage> {
  Icon icon;
  IconButton icon2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
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
            iconSize: 25,
            icon: Icon(Icons.add, color: Colors.white, size: 40),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return NewTaskScreen();
                  },
                ),
              );
            },
          )
        ],
      ),
      body: Container(
        color: Color(0xfff0e1f8),
        child: Center(
            child: FutureBuilder(
                future: getUnassignedTasks(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  print(snapshot.data);
                  if (snapshot.data == null) {
                    return Container(
                        child: Center(
                            child: CircularProgressIndicator(
                                color: Colors.white)));
                  } else {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 70.0,
                              width: MediaQuery.of(context).size.width,
                              child: ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.035),
                                  RoundedButton(
                                    margin: 10,
                                    text: "Mis tareas",
                                    color: Background,
                                    textColor: DetailsColor,
                                    height: 10.0,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    press: () {
                                      Navigator.push(
                                        context,
                                        new PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              MyTasksPage(),
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            return child;
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(width: 5.0),
                                  RoundedButton(
                                    margin: 10,
                                    text: "Tareas asignadas",
                                    color: Background,
                                    textColor: DetailsColor,
                                    height: 10.0,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    press: () {
                                      Navigator.push(
                                        context,
                                        new PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              AssignedTasksPage(),
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            return child;
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(width: 5.0),
                                  RoundedButton(
                                    margin: 10,
                                    text: "Tareas por asignar",
                                    color: DetailsColor,
                                    textColor: Background,
                                    height: 10.0,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    press: () {
                                      Navigator.push(
                                        context,
                                        new PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              TasksListScreen(),
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            return child;
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.035),
                                ],
                              ),
                            )
                          ],
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: ListView.separated(
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const Divider(
                                    indent: 20.0,
                                    endIndent: 20.0,
                                    thickness: 1.0,
                                    color: Background,
                                  ),
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Material(
                                      child: ListTile(
                                        tileColor: Background2,
                                        leading: IconButton(
                                          iconSize: 25,
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.crop_square,
                                            color: Background,
                                          ),
                                        ),
                                        title: Text(
                                          snapshot.data[index].subject,
                                          style: TextStyle(
                                              color: Background,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text("Voluntaria asignada: ",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                            )),
                                        trailing: Wrap(
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.edit_rounded,
                                                  color: Background),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    new MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditPage(snapshot
                                                                .data[index])));
                                              },
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.person_add,
                                                  color: Background),
                                              onPressed: () async {
                                                await getUserNames();
                                                Navigator.push(
                                                    context,
                                                    new MaterialPageRoute(
                                                        builder: (context) =>
                                                            AssignTaskPage(
                                                                snapshot.data[
                                                                    index])));
                                              },
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              new MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailPage(snapshot
                                                          .data[index])));
                                        },
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  }
                })),
      ),
    );
  }
}

class AssignedTasksPage extends StatefulWidget {
  @override
  State<AssignedTasksPage> createState() => _AssignedTasksPageState();
}

class _AssignedTasksPageState extends State<AssignedTasksPage> {
  IconButton icon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return NewTaskScreen();
                  },
                ),
              );
            },
          )
        ],
      ),
      body: Container(
        color: Color(0xfff0e1f8),
        child: Center(
            child: FutureBuilder(
                future: getAssignedTasks(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  print(snapshot.data);
                  if (snapshot.data == null) {
                    return Container(
                        child: Center(
                            child: CircularProgressIndicator(
                                color: Colors.white)));
                  } else {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 70.0,
                              width: MediaQuery.of(context).size.width,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.035),
                                  RoundedButton(
                                    margin: 10,
                                    text: "Mis tareas",
                                    color: Background,
                                    textColor: DetailsColor,
                                    height: 10.0,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    press: () {
                                      Navigator.push(
                                        context,
                                        new PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              MyTasksPage(),
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            return child;
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(width: 5.0),
                                  RoundedButton(
                                    margin: 10,
                                    text: "Tareas asignadas",
                                    color: DetailsColor,
                                    textColor: Background,
                                    height: 10.0,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    press: () {
                                      Navigator.push(
                                        context,
                                        new PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              TasksListScreen(),
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            return child;
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(width: 5.0),
                                  RoundedButton(
                                    margin: 10,
                                    text: "Tareas por asignar",
                                    color: Background,
                                    textColor: DetailsColor,
                                    height: 10.0,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    press: () {
                                      Navigator.push(
                                        context,
                                        new PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              UnassignedTasksPage(),
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            return child;
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.035),
                                ],
                              ),
                            )
                          ],
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: ListView.separated(
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const Divider(
                                    indent: 20.0,
                                    endIndent: 20.0,
                                    thickness: 1.0,
                                    color: Background,
                                  ),
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (snapshot.data[index].volunteer == null) {
                                    icon = IconButton(
                                      icon: Icon(Icons.abc),
                                      iconSize: 0,
                                      onPressed: () {},
                                    );
                                  } else {
                                    if (snapshot.data[index]
                                            .volunteer[0]["username"] ==
                                        currentUser.username) {
                                      if (snapshot.data[index].done == true) {
                                        icon = IconButton(
                                          iconSize: 25,
                                          icon: Icon(Icons.check_box_outlined),
                                          onPressed: () {
                                            uncheckTask(
                                                snapshot.data[index].id);
                                            Navigator.push(
                                              context,
                                              new PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation,
                                                        secondaryAnimation) =>
                                                    AssignedTasksPage(),
                                                transitionsBuilder: (context,
                                                    animation,
                                                    secondaryAnimation,
                                                    child) {
                                                  return child;
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        icon = IconButton(
                                          iconSize: 25,
                                          icon: Icon(Icons.crop_square),
                                          onPressed: () {
                                            checkTask(snapshot.data[index].id);
                                            Navigator.push(
                                              context,
                                              new PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation,
                                                        secondaryAnimation) =>
                                                    AssignedTasksPage(),
                                                transitionsBuilder: (context,
                                                    animation,
                                                    secondaryAnimation,
                                                    child) {
                                                  return child;
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    } else {
                                      icon = IconButton(
                                        icon: Icon(Icons.abc),
                                        iconSize: 0,
                                        onPressed: () {},
                                      );
                                    }
                                  }
                                    return Material(
                                      child: ListTile(
                                        tileColor: Background2,
                                        leading: IconButton(
                                          iconSize: 25,
                                          onPressed: () {},
                                          icon: icon,
                                        ),
                                        title: Text(
                                          snapshot.data[index].subject,
                                          style: TextStyle(
                                              color: Background,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                            "Voluntaria asignada: " +
                                                snapshot.data[index]
                                                    .volunteer[0]["username"],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                            )),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              new MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailPage(snapshot
                                                          .data[index])));
                                        },
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  }
                })),
      ),
    );
  }
}

class EditPage extends StatefulWidget {
  final Task task;

  EditPage(this.task);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  String valUser;
  String newValue;
  String subject;
  String description;
  String date;
  Map<String, dynamic> volunteer;
  String volunteerUsername;

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    subject = widget.task.subject;
    description = widget.task.description;
    date = widget.task.date;

    return Scaffold(
      backgroundColor: Color(0xfff0e1f8),
      appBar: AppBar(
        backgroundColor: Background,
        title: Text(
          "Editar tarea " + widget.task.subject,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.2),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xfff0e1f8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Divider(
                height: 20.0,
                thickness: 2.0,
                color: Color(0xfff0e1f8),
              ),
              SizedBox(height: 20.0),
              RoundedInputField(
                icon: Icons.checklist_rounded,
                hintText: "Asunto: " + widget.task.subject,
                onChanged: (value) {
                  subject = value;
                },
              ),
              RoundedInputFieldExtended(
                icon: Icons.edit,
                hintText: "Descripción: " + description,
                onChanged: (value) {
                  description = value;
                },
              ),
              RoundedInputField(
                maxLines: 2,
                icon: Icons.calendar_today_rounded,
                hintText: "Fecha de finalización: " + date.split('T')[0],
                onChanged: (value) {
                  date = value;
                },
              ),
              RoundedButton(
                margin: 10,
                text: "Editar tarea",
                color: Background,
                textColor: Colors.white,
                width: size.width * 0.8,
                height: 20.0,
                press: () async {
                  if (volunteerUsername == null) {
                    volunteerUsername = currentUser.username;
                  }
                  if ('$subject' != "" &&
                      '$description' != "" &&
                      '$date' != "" &&
                      '$volunteerUsername' != null) {
                    await updateTask(
                        widget.task.id, '$subject', '$description', '$date');
                    await getAllTasks();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return TasksListScreen();
                        },
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: new Text("Error"),
                          content: new Text("Campos"),
                          actions: <Widget>[
                            new TextButton(
                              child: new Text("Cerrar"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AssignTaskPage extends StatefulWidget {
  final Task task;

  AssignTaskPage(this.task);

  @override
  State<AssignTaskPage> createState() => _AssignTaskPageState();
}

class _AssignTaskPageState extends State<AssignTaskPage> {
  String newValue;
  String subject;
  String description;
  String newUser;
  String assignedUser;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    subject = widget.task.subject;
    description = widget.task.description;
    final listItem = users;

    return Scaffold(
      backgroundColor: Color(0xfff0e1f8),
      appBar: AppBar(
        backgroundColor: Background,
        title: Text(
          "Asignar tarea  ",
          style: const TextStyle(
              color: Colors.white,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.2),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width / 8),
        color: Color(0xfff0e1f8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.15),
              Text(
                "Asunto",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Background,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                widget.task.subject,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              Divider(
                indent: 20.0,
                endIndent: 20.0,
                color: Background,
                thickness: 2.0,
              ),
              Text(
                "Descripción",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Background,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                widget.task.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              Divider(
                indent: 20.0,
                endIndent: 20.0,
                color: Background,
                thickness: 2.0,
              ),
              Text(
                "Fecha",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Background,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                widget.task.date.substring(0, 10).split("-")[2] +
                    "/" +
                    widget.task.date.substring(0, 10).split("-")[1] +
                    "/" +
                    widget.task.date.substring(0, 10).split("-")[0],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              Divider(
                indent: 20.0,
                endIndent: 20.0,
                color: Background,
                thickness: 2.0,
              ),
              Container(
                width: size.width * 0.7,
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(29.0),
                    border: Border.all(
                        color: Color(0xff8c52ff),
                        style: BorderStyle.solid,
                        width: 0.8)),
                child: DropdownButton(
                    borderRadius: BorderRadius.circular(15),
                    hint: Text("Voluntaria asignada",
                        style: TextStyle(
                            fontSize: 16,
                            color: Background,
                            fontWeight: FontWeight.bold)),
                    dropdownColor: Background2,
                    underline: Container(height: 0, color: Background2),
                    style: TextStyle(color: Background),
                    icon: const Icon(Icons.arrow_drop_down_rounded,
                        color: Background, size: 30),
                    items: listItem.map(buildMenuItem).toList(),
                    value: newValue,
                    onChanged: (value) {
                      newUser = value;
                      setState(() {
                        newValue = value;
                      });
                    }),
              ),
              SizedBox(height: size.height * 0.05),
              RoundedButton(
                margin: 10,
                text: "Asignar tarea",
                color: Background,
                textColor: Colors.white,
                width: size.width * 0.8,
                height: 20.0,
                press: () async {
                  if ('$newUser' != "") {
                    assignedUser = await getUserByUsername(newUser);
                    await assignTask(widget.task.id, assignedUser);
                    await getAllTasks();
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => TasksListScreen()));
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: new Text("Error"),
                          content: new Text("Faltan campos por rellenar"),
                          actions: <Widget>[
                            new TextButton(
                              child: new Text("Cerrar"),
                              onPressed: () {
                                getAllTasks();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontSize: 20),
        ),
      );
}
