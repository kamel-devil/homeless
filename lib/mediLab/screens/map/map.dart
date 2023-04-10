import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:homeless/mediLab/controller/controller.dart';
import 'package:latlong2/latlong.dart';

import 'package:provider/provider.dart';

import 'package:lottie/lottie.dart' as lo;

import '../../components/colors.dart';
import '../../components/custom_shape.dart';

class MapPage extends StatefulWidget {
  MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with TickerProviderStateMixin {
  MapController mapController = MapController();

  Timer? timer;
  String typeHospital = 'all';
  List<Marker> mark = [];
  int typeIndex = 6;
  List type = [
    'government Hospital',
    "charity Center",
    "special Center",
  ];
  List type1 = [
    'governmentHospital',
    "charityCenter",
    "specialCenter",
  ];

  late AnimationController _controller;

  @override
  void initState() {
    mapController = MapController();
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

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final latTween = Tween<double>(
        begin: mapController.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: mapController.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    final controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    final Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(
          LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
          zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    MapPageController x = Get.put(MapPageController());
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            FutureBuilder(
                future: x.getMarkers1(typeHospital),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List data = snapshot.data as List;
                    return FlutterMap(
                      key: ValueKey(MediaQuery.of(context).orientation),
                      options: MapOptions(
                        controller: mapController,
                        onMapCreated: (c) {
                          mapController = c;
                        },
                        maxZoom: 22,
                        minZoom: 3,
                        zoom: 8,
                        onPositionChanged: (center, val) {},
                        plugins: [
                          MarkerClusterPlugin(),
                          const LocationMarkerPlugin(),
                        ],
                        center: LatLng(x.lat!, x.long!),
                        // center: LatLng(30.635478259074432, 31.0902948107),
                        // interactiveFlags: InteractiveFlag.drag |
                        //     InteractiveFlag.pinchMove |
                        //     InteractiveFlag.pinchZoom
                      ),
                      layers: [
                        TileLayerOptions(
                          urlTemplate:
                              "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                          subdomains: ['a', 'b', 'c'],
                        ),
                        MarkerLayerOptions(markers: [
                          ...data.map((e) => Marker(
                              width: 50,
                              height: 50,
                              point: LatLng(double.parse('${e['lat']}'),
                                  double.parse('${e['long']}')),
                              builder: (BuildContext context) => InkWell(
                                    onTap: () {},
                                    child: Stack(
                                      children: [
                                        CustomPaint(
                                          size: const Size(180, 110),
                                          painter: RPSCustomPainter(
                                              color: Colors.redAccent),
                                        ),
                                        const Positioned(
                                          right: 11,
                                          top: 5,
                                          child: Icon(
                                            Icons.local_hospital,
                                            color: Colors.white,
                                            size: 27.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))),
                          Marker(
                            width: 100,
                            height: 100,
                            point: LatLng(x.lat!, x.long!),
                            builder: (ctx) => AnimatedBuilder(
                                animation: CurvedAnimation(
                                    parent: _controller,
                                    curve: Curves.fastOutSlowIn),
                                builder: (context, child) {
                                  return Stack(
                                    children: [
                                      Center(
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.green.withOpacity(1),
                                              shape: BoxShape.circle),
                                        ),
                                      ),
                                      lo.Lottie.network(
                                          'https://assets4.lottiefiles.com/packages/lf20_bgmlsv9w.json')
                                    ],
                                  );
                                }),
                          ),
                        ]),
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
            Container(
              height: 240,
              decoration: const BoxDecoration(color: Colors.transparent),
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Container(
                      height: 60,
                      margin: const EdgeInsets.only(left: 15),
                      child: ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 15,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: type.length,
                        itemBuilder: (context, index) => ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              typeIndex = index;
                              typeHospital = type1[index];
                            });
                          },
                          icon: const Icon(
                            Icons.local_hospital,
                            color: Colors.white,
                            size: 27.0,
                          ),
                          label: Text(
                            type[index],
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 15),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  typeIndex == index
                                      ? Colors.teal.shade400.withOpacity(0.5)
                                      : Colors.white10),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: const BorderSide(
                                          color: Colors.black)))),
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
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
                        _animatedMapMove(LatLng(x.lat!, x.long!), 13);
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
