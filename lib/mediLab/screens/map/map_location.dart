// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:lottie/lottie.dart' as lo;
//
// class MapLocation extends StatefulWidget {
//   const MapLocation({Key? key}) : super(key: key);
//
//   @override
//   State<MapLocation> createState() => _MapLocationState();
// }
//
// class _MapLocationState extends State<MapLocation>
//     with TickerProviderStateMixin {
//   MapController mapController = MapController();
//   Timer? timer;
//   final PopupController _popupController = PopupController();
//   List<Marker> mark = [];
//   late AnimationController _controller;
//
//
//   @override
//   void initState() {
//     mapController = MapController();
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       lowerBound: 0.5,
//       duration: const Duration(seconds: 3),
//     )..repeat();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Scaffold(
//           body: Stack(
//             children: [
//               FlutterMap(
//                 mapController: mapController,
//                 options: MapOptions(
//                   // onMapCreated: (c) {
//                   //   mapController = c;
//                   // },
//                   onPointerHover: (xx, y) {
//                     // value.change(y.latitude, y.longitude);
//                     // value.savaAddress(y.latitude, y.longitude);
//                     // value.getAddressInfo(y.latitude, y.longitude);
//                   },
//                   // plugins: [
//                   //   MarkerClusterPlugin(),
//                   // ],
//                    center: LatLng(value.lat!, value.long!),
//                   maxZoom: 16,
//                   minZoom: 10,
//                   zoom: 20,
//                 ),
//                 layers: [
//                   // TileLayerOptions(
//                   //   urlTemplate:
//                   //       "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//                   //   subdomains: ['a', 'b', 'c'],
//                   // ),
//                   MarkerClusterLayerOptions(
//                     maxClusterRadius: 120,
//                     disableClusteringAtZoom: 6,
//                     size: const Size(40, 40),
//                     anchor: AnchorPos.align(AnchorAlign.center),
//                     fitBoundsOptions: const FitBoundsOptions(
//                       padding: EdgeInsets.all(50),
//                     ),
//                     markers: [
//                       Marker(
//                         width: 100,
//                         height: 100,
//                         point: LatLng(30.00, 31.12),
//                         builder: (ctx) => AnimatedBuilder(
//                             animation: CurvedAnimation(
//                                 parent: _controller,
//                                 curve: Curves.fastOutSlowIn),
//                             builder: (context, child) {
//                               return Stack(
//                                 children: [
//                                   Center(
//                                     child: Container(
//                                       width: 20,
//                                       height: 20,
//                                       decoration: BoxDecoration(
//                                           color: Colors.green.withOpacity(1),
//                                           shape: BoxShape.circle),
//                                     ),
//                                   ),
//                                   lo.Lottie.network(
//                                       'https://assets4.lottiefiles.com/packages/lf20_bgmlsv9w.json')
//                                 ],
//                               );
//                             }),
//                       ),
//                     ],
//                     polygonOptions: const PolygonOptions(
//                         borderColor: Colors.blueAccent,
//                         color: Colors.black12,
//                         borderStrokeWidth: 3),
//                     popupOptions: PopupOptions(
//                         popupSnap: PopupSnap.markerTop,
//                         popupController: _popupController,
//                         popupBuilder: (_, marker) => GestureDetector(
//                               onTap: () {},
//                               child: Container(
//                                 padding: const EdgeInsets.all(10),
//                                 width: 300,
//                                 child: const Text(
//                                   '',
//                                   maxLines: 3,
//                                 ),
//                               ),
//                             ),
//                         popupState: PopupState()),
//                     builder: (context, markers) {
//                       return FloatingActionButton(
//                         onPressed: () {},
//                         child: Text(markers.length.toString()),
//                       );
//                     },
//                   ),
//                   // MarkerLayerOptions(markers: mark),
//                 ],
//               ),
//               Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Container(
//                     width: MediaQuery.of(context).size.width - 30,
//                     height: 230.0,
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.rectangle,
//                       color: Colors.white,
//                       borderRadius: BorderRadius.all(Radius.circular(32.0)),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: <Widget>[
//                         // dialog top
//                         Expanded(
//                           child: Row(
//                             children: <Widget>[
//                               Container(
//                                 decoration: const BoxDecoration(
//                                   color: Colors.white,
//                                 ),
//                                 child: Text(
//                                   '           Location',
//                                   style: TextStyle(
//                                       color: Theme.of(context).primaryColor,
//                                       fontSize: 23,
//                                       fontWeight: FontWeight.w800),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//
//                         // dialog centre
//                         Expanded(
//                           child: TextField(
//                             decoration: InputDecoration(
//                               border: InputBorder.none,
//                               filled: false,
//                               contentPadding: const EdgeInsets.only(
//                                   left: 10.0,
//                                   top: 10.0,
//                                   bottom: 10.0,
//                                   right: 10.0),
//                               hintText: '',
//                               hintMaxLines: 3,
//                               hintStyle: TextStyle(
//                                 color: Colors.grey.shade700,
//                                 fontSize: 18.0,
//                                 fontWeight: FontWeight.w500,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                           ),
//                         ),
//                         const Divider(
//                           thickness: 2,
//                         ),
//
//                         // dialog bottom
//                         InkWell(
//                           onTap: () {
//                             // Navigator.of(context).push(MaterialPageRoute(
//                             //     builder: (context) =>
//                             //     const HomeServices()));
//                           },
//                           child: Container(
//                             padding: const EdgeInsets.all(16.0),
//                             decoration: BoxDecoration(
//                                 color: const Color(0xFF33b17c),
//                                 borderRadius: BorderRadius.circular(20)),
//                             height: 60,
//                             child: const Center(
//                               child: Text(
//                                 'Confirm',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 25,
//                                     fontWeight: FontWeight.w700),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )),
//               Positioned(
//                   bottom: 250,
//                   right: 10,
//                   child: FloatingActionButton(
//                     onPressed: () async {
//                       // pro.endValue(true);
//                       // pro.getCurrentLocation().whenComplete(() {
//                       //   _animatedMapMove(LatLng(pro.lat!, pro.long!), 13);
//                       //   //
//                       //   // mapController.move(LatLng(pro.lat!, pro.long!), 13);
//                       // });
//                     },
//                     backgroundColor: Colors.white,
//                     child: const Icon(
//                       FontAwesomeIcons.locationPin,
//                       color: Colors.red,
//                     ),
//                   )),
//             ],
//           ),
//         ),
//         // pro.end
//         //     ? Center(
//         //         child: SizedBox(
//         //           width: 400,
//         //           height: 400,
//         //           child: lo.Lottie.network(
//         //               'https://assets1.lottiefiles.com/packages/lf20_gbfwtkzw.json'),
//         //         ),
//         //       )
//         //     : Container()
//       ],
//     );
//   }
// }
