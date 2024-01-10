// import 'dart:async';
import 'dart:ui';

import 'package:aimlproject/main.dart';
import 'package:aimlproject/models.dart';
import 'package:aimlproject/result_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

// import 'package:get/get.dart';
import 'package:tflite_v2/tflite_v2.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isWorking = false;
  String result = "";
  String breedname = "";
  CameraController? cameraController;
  CameraImage? imgCamera;

  initCamera() {
    cameraController = CameraController(cameras![0], ResolutionPreset.medium);
    cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      }

      setState(() {
        cameraController!.startImageStream((imageFromStream) => {
              if (!isWorking)
                {
                  isWorking = true,
                  imgCamera = imageFromStream,
                  runModelonStreamFrames(),
                }
            });
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
  }

  @override
  void dispose() async {
    // TODO: implement dispose
    super.dispose();

    await Tflite.close();
    cameraController?.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  void refresh() {
    setState(() {});
  }

  runModelonStreamFrames() async {
    if (imgCamera != null) {
      var recognitions = await Tflite.runModelOnFrame(
        bytesList: imgCamera!.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        imageHeight: imgCamera!.height,
        imageWidth: imgCamera!.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 2,
        threshold: 0.1,
        asynch: true,
      );
      result = '';
      breedname = '';

      recognitions!.forEach((response) {
        breedname = response["label"];
        result += response["label"] +
            (response["confidence"] as double).toStringAsFixed(2);
      });

      // Timer(const Duration(seconds: 10), () {
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => Result(
      //               result: breedname,
      //             ),
      //             ),
      //             );
      // )}

      // showModalBottomSheet(
      //     context: context,
      //     builder: (ctx) => Result(result: breedname),
      //     isScrollControlled: true);
      // });
      // print(result);

      setState(() {
        result;
      });

      isWorking = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: TextButton(
            onPressed: initCamera,
            child: Container(
              width: double.infinity, // Ensure the button takes full width
              height: double.infinity,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30)),
              // Ensure the button takes full width
              // Ensure the button takes full height
              child: imgCamera == null
                  ? const Icon(
                      Icons.photo_camera_front_rounded,
                      size: 40.0,
                    )
                  : AspectRatio(
                      aspectRatio: cameraController!.value.aspectRatio,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30)),
                          child: CameraPreview(cameraController!)),
                    ),
            ),
          ),
        ),
        Positioned(
          bottom: 80,
          right: 20,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Center(
              child: Container(
                height: 100,
                width: 100,
                child: Stack(children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Container(),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.white.withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(50),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withOpacity(0.4),
                              Colors.white.withOpacity(0.1),
                            ])),
                  ),
                  Center(
                    child: TextButton(
                      style:
                          TextButton.styleFrom(foregroundColor: Colors.black),
                      onPressed: () => {
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            // isScrollControlled: true,
                            context: context,
                            builder: (ctx) => Container(
                                  color: Colors.transparent,
                                  child: Stack(
                                    children: [
                                      BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 2, sigmaY: 2),
                                        child: Container(),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white
                                                    .withOpacity(0.2)),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  Colors.white.withOpacity(0.4),
                                                  Colors.white.withOpacity(0.1),
                                                ])),
                                      ),
                                      ResultSlider(
                                        result: result,
                                        breedname: breedname,
                                        refresh: refresh,
                                      )
                                    ],
                                  ),
                                ))
                      },
                      child: const Row(
                        children: [
                          Text(
                            "Next",
                            style: TextStyle(fontSize: 20),
                          ),
                          Icon(Icons.arrow_forward_rounded),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        )
      ],
    );
  }
}
