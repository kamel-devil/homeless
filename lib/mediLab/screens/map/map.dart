import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homeless/mediLab/controller/controller.dart';
import 'package:location/location.dart';

import '../house_info/hospital_info.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with TickerProviderStateMixin {
  // MapController mapController = MapController();
  GoogleMapController? _mapController;
  Timer? timer;
  String typeHospital = 'all';

  // List<Marker> mark = [];
  int typeIndex = 6;

  late AnimationController _controller;
  final Location currentLocation = Location();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.5,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // void _animatedMapMove(LatLng destLocation, double destZoom) {
  //   // Create some tweens. These serve to split up the transition from one location to another.
  //   // In our case, we want to split the transition be<tween> our current map center and the destination.
  //   final latTween = Tween<double>(
  //       begin: mapController.center.latitude, end: destLocation.latitude);
  //   final lngTween = Tween<double>(
  //       begin: mapController.center.longitude, end: destLocation.longitude);
  //   final zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);
  //
  //   // Create a animation controller that has a duration and a TickerProvider.
  //   final controller = AnimationController(
  //       duration: const Duration(milliseconds: 1000), vsync: this);
  //   // The animation determines what path the animation will take. You can try different Curves values, although I found
  //   // fastOutSlowIn to be my favorite.
  //   final Animation<double> animation =
  //       CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
  //
  //   controller.addListener(() {
  //     mapController.move(
  //         LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
  //         zoomTween.evaluate(animation));
  //   });
  //
  //   animation.addStatusListener((status) {
  //     if (status == AnimationStatus.completed) {
  //       controller.dispose();
  //     } else if (status == AnimationStatus.dismissed) {
  //       controller.dispose();
  //     }
  //   });
  //
  //   controller.forward();
  // }

  @override
  Widget build(BuildContext context) {
    MapPageController x = Get.put(MapPageController());
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'Home Care',
            style: TextStyle(color: Colors.grey),
          ),
          elevation: 0,
        ),
        body: Stack(
          children: [
            FutureBuilder(
                future: x.getMarkers1(typeHospital),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List data = snapshot.data as List;
                    return GoogleMap(
                      zoomControlsEnabled: true,
                      myLocationButtonEnabled: true,
                      padding: const EdgeInsets.only(
                        top: 230.0,
                      ),
                      initialCameraPosition: CameraPosition(
                          target: LatLng(x.lat!, x.long!),
                          zoom: 11.0,
                          tilt: 0,
                          bearing: 0),
                      onMapCreated: (GoogleMapController controller) async {
                        _mapController = controller;
                        LocationData location =
                            await currentLocation.getLocation();
                        _mapController!.moveCamera(CameraUpdate.newLatLngZoom(
                            LatLng(location.latitude ?? 0.0,
                                location.longitude ?? 0.0),
                            14));
                      },
                      myLocationEnabled: true,
                      markers: {
                        ...data.map((e) => Marker(
                            // width: 50,
                            // height: 50,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HospitalInfo(
                                      uid: e['uid'],
                                      email: e['email'],
                                    ),
                                  ));
                            },
                            position: LatLng(double.parse('${e['late']}'),
                                double.parse('${e['long']}')),
                            // builder: (BuildContext context) => InkWell(
                            //   onTap: () {
                            //     Navigator.push(context, MaterialPageRoute(builder: (context) => HospitalInfo(uid:e['uid'], email: e['email'],),));
                            //   },
                            //   child: Stack(
                            //     children: [
                            //       CustomPaint(
                            //         size: const Size(180, 110),
                            //         painter: RPSCustomPainter(
                            //             color: Colors.redAccent),
                            //       ),
                            //       const Positioned(
                            //         right: 11,
                            //         top: 5,
                            //         child: Icon(
                            //           Icons.local_hospital,
                            //           color: Colors.white,
                            //           size: 27.0,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            markerId: const MarkerId('sdd'))),
                        Marker(
                          position: LatLng(x.lat!, x.long!),
                          // builder: (ctx) => AnimatedBuilder(
                          //     animation: CurvedAnimation(
                          //         parent: _controller,
                          //         curve: Curves.fastOutSlowIn),
                          //     builder: (context, child) {
                          //       return Stack(
                          //         children: [
                          //           Center(
                          //             child: Container(
                          //               width: 20,
                          //               height: 20,
                          //               decoration: BoxDecoration(
                          //                   color:
                          //                   Colors.green.withOpacity(1),
                          //                   shape: BoxShape.circle),
                          //             ),
                          //           ),
                          //           Lottie.network(
                          //               'https://assets4.lottiefiles.com/packages/lf20_bgmlsv9w.json')
                          //         ],
                          //       );
                          //     }),
                          markerId: const MarkerId('fkowf'),
                        ),
                      },
                    );

                    // FlutterMap(
                    //   key: ValueKey(MediaQuery.of(context).orientation),
                    //   mapController: mapController,
                    //   options: MapOptions(
                    //     maxZoom: 22,
                    //     minZoom: 3,
                    //     zoom: 8,
                    //     onPositionChanged: (center, val) {},
                    //     // plugins: [
                    //     //   MarkerClusterPlugin(),
                    //     //   const LocationMarkerPlugin(),
                    //     // ],
                    //     center: LatLng(x.lat!, x.long!),
                    //     // center: LatLng(30.635478259074432, 31.0902948107),
                    //     // interactiveFlags: InteractiveFlag.drag |
                    //     //     InteractiveFlag.pinchMove |
                    //     //     InteractiveFlag.pinchZoom
                    //   ),
                    //   children: [],
                    //   // layers: [
                    //   //   TileLayerOptions(
                    //   //     urlTemplate:
                    //   //         "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    //   //     subdomains: ['a', 'b', 'c'],
                    //   //   ),
                    //   //   MarkerLayerOptions(markers: [
                    //   //     ...data.map((e) => Marker(
                    //   //         width: 50,
                    //   //         height: 50,
                    //   //         point: LatLng(double.parse('${e['late']}'),
                    //   //             double.parse('${e['long']}')),
                    //   //         builder: (BuildContext context) => InkWell(
                    //   //               onTap: () {
                    //   //                 Navigator.push(context, MaterialPageRoute(builder: (context) => HospitalInfo(uid:e['uid'], email: e['email'],),));
                    //   //               },
                    //   //               child: Stack(
                    //   //                 children: [
                    //   //                   CustomPaint(
                    //   //                     size: const Size(180, 110),
                    //   //                     painter: RPSCustomPainter(
                    //   //                         color: Colors.redAccent),
                    //   //                   ),
                    //   //                   const Positioned(
                    //   //                     right: 11,
                    //   //                     top: 5,
                    //   //                     child: Icon(
                    //   //                       Icons.local_hospital,
                    //   //                       color: Colors.white,
                    //   //                       size: 27.0,
                    //   //                     ),
                    //   //                   ),
                    //   //                 ],
                    //   //               ),
                    //   //             ))),
                    //   //     Marker(
                    //   //       width: 100,
                    //   //       height: 100,
                    //   //       point: LatLng(x.lat!, x.long!),
                    //   //       builder: (ctx) => AnimatedBuilder(
                    //   //           animation: CurvedAnimation(
                    //   //               parent: _controller,
                    //   //               curve: Curves.fastOutSlowIn),
                    //   //           builder: (context, child) {
                    //   //             return Stack(
                    //   //               children: [
                    //   //                 Center(
                    //   //                   child: Container(
                    //   //                     width: 20,
                    //   //                     height: 20,
                    //   //                     decoration: BoxDecoration(
                    //   //                         color:
                    //   //                             Colors.green.withOpacity(1),
                    //   //                         shape: BoxShape.circle),
                    //   //                   ),
                    //   //                 ),
                    //   //                 lo.Lottie.network(
                    //   //                     'https://assets4.lottiefiles.com/packages/lf20_bgmlsv9w.json')
                    //   //               ],
                    //   //             );
                    //   //           }),
                    //   //     ),
                    //   //   ]),
                    //   // ],
                    // );
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
            Positioned(
                bottom: 40,
                right: 15,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.white,
                  elevation: 2,
                  child: IconButton(
                    icon: const Icon(
                      Icons.my_location,
                      size: 26,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      // x.endValue(true);
                      x.getCurrentLocation().whenComplete(() {
                        // _mapController!.animateCamera();
                        _mapController!.animateCamera(
                            CameraUpdate.newLatLngZoom(
                                LatLng(x.lat!, x.long!), 14));
                        // _animatedMapMove(LatLng(x.lat!, x.long!), 13);
                        // mapController.move(LatLng(x.lat!, x.long!), 13);
                      });
                      // mapController.move(LatLng(lat, long), 13);
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
