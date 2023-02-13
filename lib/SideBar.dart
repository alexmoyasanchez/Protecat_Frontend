import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Calendar/calendar_screen.dart';
import 'package:flutter_auth/Screens/CatsList/catsList_screen.dart';
import 'package:flutter_auth/Screens/EditPerfil/editperfil_screen.dart';
import 'package:flutter_auth/Screens/Feed/feed_screen.dart';
import 'package:flutter_auth/Screens/Map/ui/pages/home/map_screen.dart';
import 'package:flutter_auth/Screens/ObjectsList/objectsList_screen.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/data.dart';
import 'Screens/TasksList/tasksList_screen.dart';

class SideBar extends StatelessWidget {
  //final LocalStorage storage = new LocalStorage('My App');

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Background,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: Text(
                currentUser.username,
                style: TextStyle(color: Color(0xfff0e1f8), fontSize: 16.0),
              ),
              accountEmail: Text(
                currentUser.email,
                style: TextStyle(color: Color(0xfff0e1f8), fontSize: 16.0),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Color(0xfff0e1f8),
                radius: 20.0,
                backgroundImage: NetworkImage(currentUser.imageUrl),
                child: IconButton(
                  icon: Icon(Icons.edit, color: Background,),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      currentPhoto = " ";
                      return EditPerfilScreen();
                    }),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Background,
              )),
          Divider(
            color: Colors.white,
            thickness: 2.0,
          ),
          ListTile(
            iconColor: Color(0xfff0e1f8),
            leading: Icon(Icons.home_filled, size: 30.0),
            title: Text(
              'Mapa',
              style: TextStyle(color: Color(0xfff0e1f8), fontSize: 18.0),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return MapScreen();
              }),
            ),
          ),
          ListTile(
            iconColor: Color(0xfff0e1f8),
            leading: Icon(
              Icons.people_alt_rounded,
              size: 30.0,
            ),
            title: Text(
              'Foro',
              style: TextStyle(color: Color(0xfff0e1f8), fontSize: 18.0),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                currentPhoto = "";
                return FeedScreen();
              }),
            ),
          ),
          ListTile(
            iconColor: Color(0xfff0e1f8),
            leading: Icon(
              Icons.pets,
              size: 30.0,
            ),
            title: Text(
              'Gatos',
              style: TextStyle(color: Color(0xfff0e1f8), fontSize: 18.0),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return CatsListScreen();
              }),
            ),
          ),
          ListTile(
            iconColor: Color(0xfff0e1f8),
            leading: Icon(
              Icons.description_outlined,
              size: 30.0,
            ),
            title: Text(
              'Formularios de adopción',
              style: TextStyle(color: Color(0xfff0e1f8), fontSize: 18.0),
            ),
            onTap: () => null,
          ),
          ListTile(
            iconColor: Color(0xfff0e1f8),
            leading: Icon(
              Icons.checklist_rtl_sharp,
              size: 30.0,
            ),
            title: Text(
              'Tareas',
              style: TextStyle(color: Color(0xfff0e1f8), fontSize: 18.0),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return TasksListScreen();
              }),
            ),
          ),
          ListTile(
            iconColor: Color(0xfff0e1f8),
            leading: Icon(
              Icons.calendar_month_sharp,
              size: 30.0,
            ),
            title: Text(
              'Calendario',
              style: TextStyle(color: Color(0xfff0e1f8), fontSize: 18.0),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return CalendarScreen();
              }),
            ),
          ),
          ListTile(
            iconColor: Color(0xfff0e1f8),
            leading: Icon(
              Icons.storefront_outlined,
              size: 30.0,
            ),
            title: Text(
              'Inventario',
              style: TextStyle(color: Color(0xfff0e1f8), fontSize: 18.0),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return ObjectsListcreen();
              }),
            ),
          ),
          Divider(
            color: Colors.white,
            thickness: 2.0,
          ),
          ListTile(
            iconColor: Color(0xfff0e1f8),
            leading: Icon(
              Icons.exit_to_app,
              size: 30.0,
            ),
            title: Text(
              'Cerrar sesión',
              style: TextStyle(color: Color(0xfff0e1f8), fontSize: 18.0),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                //storage.deleteItem('token');
                return WelcomeScreen();
              }),
            ),
          ),
        ],
      ),
    );
  }
}
