import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

class MachineScreen extends StatefulWidget {
  const MachineScreen({Key? key}) : super(key: key);

  @override
  State<MachineScreen> createState() => _MachineScreenState();
}

class _MachineScreenState extends State<MachineScreen> {
  File? imageFile;
  List output = [];

  loadModel() async {
    await Tflite.loadModel(
            model: "assets/model_unquant.tflite",
            labels: "assets/labels.txt",
            numThreads: 1,
            isAsset: true,
            useGpuDelegate: false)
        .then((value) {
      if (kDebugMode) {
        print(value);
      }
    });
  }

  classifiy() async {
    var recognitions = await Tflite.runModelOnImage(
            path: imageFile!.path,
            // required
            imageMean: 0.0,
            // defaults to 117.0
            imageStd: 255.0,
            // defaults to 1.0
            numResults: 2,
            // defaults to 5
            threshold: 0.2,
            // defaults to 0.1
            asynch: true // defaults to true
            )
        .then((value) {
      print('000000000000000000000000000000');
      print(value);
      output = value as List;
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  void initState() {
    loadModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 0,
        title:   Text('افحص الان ',
            style: boldTextStyle(size: 24, color: Colors.white)),
centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.redAccent)),
              child: imageFile == null
                  ? const Icon(
                      Icons.image,
                      color: Colors.redAccent,
                    )
                  : Image.file(imageFile!),
            ),
            12.height,
            output.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'النتيجه : - ',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w900),
                      ),
                      Text(
                        output[0]['label'],
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      )
                    ],
                  )
                : Container(),
            12.height,
            GestureDetector(
              onTap: () => openCamera(),
              child: Container(
                height: 60,
                width: double.infinity,
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
                child: Text('الكاميرا',
                    style: TextStyle(
                        color: Colors.white.withOpacity(.8),
                        fontSize: 20,
                        fontWeight: FontWeight.w900)),
              ),
            ),
            14.height,
            GestureDetector(
              onTap: () => openGallery(),
              child: Container(
                height: 60,
                width: double.infinity,
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
                child: Text('المعرض',
                    style: TextStyle(
                        color: Colors.white.withOpacity(.8),
                        fontSize: 20,
                        fontWeight: FontWeight.w900)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future openGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        imageFile = imageTemporary;
      });
    } catch (error) {
      print("error: $error");
    }
    classifiy();
  }

  Future openCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        imageFile = imageTemporary;
      });
    } catch (error) {
      print("error: $error");
    }
    classifiy();
  }
}
