import 'package:flutter/material.dart';

class Object{
  final String id;
  final String name;
  final String imageUrl;
  final String price;
  final String description;
  final int units;

  Object({
    @required this.id,
    @required this.name,
    @required this.imageUrl,
    @required this.price,
    @required this.description,
    @required this.units
  } 
  );

  factory Object.fromJson(Map<String, dynamic> json) {
    return Object(
      id: json['id'],
      name: json['name'],      
      imageUrl: json['imageUrl'],
      price: json['price'],
      description: json['description'],
      units: json['units']
    );
  }

}