import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home/MLDashboardScreen.dart';
import '../nicu_chat/api/apis.dart';
import '../nicu_chat/helper/dialogs.dart';
import '../nicu_chat/screens/home_screen.dart';
import 'component/cache_image.dart';
import 'component/to_map.dart';

class HospitalInfo extends StatefulWidget {
  HospitalInfo(
      {super.key,
      required this.uid,
      required this.email,
      this.report = false,
      this.file});

  final String uid;
  final String email;
  final bool report;
  final File? file;

  @override
  _HospitalInfoState createState() => _HospitalInfoState();
}

class _HospitalInfoState extends State<HospitalInfo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.redAccent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.redAccent,
          centerTitle: true,
          title: const Text(
            'House Information',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
          ),
          actions: [
            widget.report
                ? GestureDetector(
                    onTap: () async {
                      CollectionReference addPost = FirebaseFirestore.instance
                          .collection('home')
                          .doc(widget.uid)
                          .collection('reports');
                      var currentUser = FirebaseAuth.instance.currentUser?.uid;

                      var imageName = basename(widget.file!.path);
                      var ref =
                          FirebaseStorage.instance.ref('images/$imageName');
                      await ref.putFile(widget.file!);
                      String imageUrl = await ref.getDownloadURL();
                      addPost.add({
                        'imageurl': imageUrl,
                        'user': currentUser,
                        'id': widget.uid,
                        'email': widget.email
                      }).then((value) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MLDashboardScreen()));
                      });
                    },
                    child: Container(
                      height: 60,
                      width: 90,
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 4,
                                color: Colors.black12.withOpacity(.2),
                                offset: const Offset(2, 2))
                          ],
                          borderRadius: BorderRadius.circular(20)
                              .copyWith(bottomRight: const Radius.circular(0)),
                          gradient: LinearGradient(colors: [
                            Colors.redAccent.shade200,
                            Colors.red.shade900
                          ])),
                      child: Text('ابلاغ',
                          style: TextStyle(
                              color: Colors.white.withOpacity(.8),
                              fontSize: 20,
                              fontWeight: FontWeight.w900)),
                    ),
                  )
                : Container(),
          ],
        ),
        body: Container(
          height: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0)),
          ),
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: getProfileData(widget.uid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data;
                  print(widget.uid);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              data['profile'],
                              width: 160,
                              height: 170,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 222,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const SizedBox(
                                  height: 18,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['name'],
                                      maxLines: 3,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            launchUrl(Uri.parse(
                                                'tel:/${data['phone']}'));
                                          },
                                          child: const Icon(
                                            Icons.call,
                                            color: Colors.green,
                                            size: 30,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Flexible(
                                          child: Text(
                                            data['phone'],
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            MapUtils.map(
                                                double.parse('${data['late']}'),
                                                double.parse(
                                                    '${data['long']}'));
                                          },
                                          child: const Icon(
                                            Icons.location_on,
                                            color: Colors.red,
                                            size: 30,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                          child: Text(
                                            data['address'],
                                            maxLines: 4,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.timer_sharp,
                                          color: Colors.blue,
                                          size: 30,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          data['open'],
                                          maxLines: 3,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 3,
                            color: Colors.white54,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "Availability",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                color: data['availability'] == 'True'
                                    ? Colors.green
                                    : Colors.red,
                                borderRadius: BorderRadius.circular(50)),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        "About",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        "Dr. Stefeni Albert is a cardiologist in Nashville & affiliated with multiple hospitals in the  area.He received his medical degree from Duke University School of Medicine and has been in practice for more than 20 years. ",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 16),
                          height: 170,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5),
                            scrollDirection: Axis.horizontal,
                            itemCount: data['image'].length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 2,
                                color: Colors.redAccent,
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    child: buildCacheNetworkImage(
                                        width: 160,
                                        height: 130,
                                        url: data['image'][index])),
                              );
                            },
                          )),
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.redAccent,
          onPressed: () async {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomeChat()));
            if (widget.email.isNotEmpty) {
              await APIs.addChatUser(widget.email).then((value) {
                if (!value) {
                  Dialogs.showSnackbar(context, 'User does not Exists!');
                }
              });
            }
          },
          child: const Icon(Icons.chat),
        ),
      ),
    );
  }

  Future getProfileData(String uid) async {
    var firestore = FirebaseFirestore.instance;
    CollectionReference qn = firestore.collection("home");
    DocumentReference itemIdRef = qn.doc(uid);
    DocumentSnapshot itemIdSnapshot = await itemIdRef.get();
    return itemIdSnapshot;
  }

  Future getProfileReview(String uid) async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn =
        await firestore.collection("home").doc(uid).collection('review').get();
    return qn.docs;
  }
}
