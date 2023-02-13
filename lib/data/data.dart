import 'package:flutter_auth/models/models.dart';

import '../models/colony_model.dart';

User currentUser = User(
  id: null,
  username: null,
  password: null,
  email: null,
  imageUrl: null,
  tasks: null,
);


String currentPhoto = " ";
String volunteerUsername2;

String user_id;

List<String> latitudes = ["42.2755182"];
List<String> longitudes = ["1.6850292"];

List<String> coloniesNames = [];
List<String> coloniesObsevations = [];

List<Colony> colonies = [];

List<String> cats = [];

List<String> users = [];

String addedCat;

Colony colonySelected;

Colony nullColony;

String change = "";