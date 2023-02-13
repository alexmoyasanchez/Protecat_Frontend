import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/ColoniesList/coloniesList_screen.dart';
import 'package:flutter_auth/Screens/Map/ui/pages/home/home_controller.dart';
import 'package:flutter_auth/SideBar.dart';
import 'package:flutter_auth/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatelessWidget {
  MapScreen({Key key}) : super(key: key);

  List<String> latitud = [];
  List<String> longitud = [];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
        create: (_) {
          final controller = HomeController();
          controller.onMarkerTap.listen((String id) {});
          return controller;
        },
        child: Scaffold(
          drawer: SideBar(),
          appBar: AppBar(
            backgroundColor: Background,
            title: Text(
              "Colonias",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.2),
            ),
            centerTitle: true,
            actions: [
              TextButton(
                  child: Text(
                    "Lista",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ColoniesListScreen();
                        },
                      ),
                    );
                  })
            ],
          ),
          body: Consumer<HomeController>(
            builder: (_, controller, __) => GoogleMap(
              onMapCreated: controller.onMapCreatedyeah,
              initialCameraPosition: controller.initialCameraPosition,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: true,
              compassEnabled: true,
              myLocationEnabled: true,
              mapType: MapType.normal,
              markers: controller.markers,
            ),
          ),
        ));
  }
}
