import 'dart:math';
import 'dart:ui';

import 'package:aimlproject/utils/data.dart';
import 'package:flutter/material.dart';

class ResultSlider extends StatelessWidget {
  const ResultSlider({
    super.key,
    required this.result,
    required this.breedname,
    required this.refresh,
  });

  final String result;
  final String breedname;
  final void Function() refresh;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
          child: Container(
            height: 10,
            width: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.black,
            ),
          ),
        ),
        Row(
          children: [
            const Spacer(),
            IconButton(
                onPressed: () => {Navigator.pop(context)},
                icon: const Icon(
                  Icons.cancel_rounded,
                  color: Colors.black,
                ))
          ],
        ),
        Text(
          result,
          style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w800,
              color: Color.fromARGB(255, 43, 7, 65)),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0.0, 0.0, 0.0),
              child: Container(
                width: 200,
                height: 200,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(90)),
                child: FrostedGlass(
                  childargument: Text(
                    breedname != "" ? dogFoodMap[breedname]! : "breed",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Color.fromARGB(255, 43, 7, 65)),
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
        Row(
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 30),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: FrostedGlass(
                    childargument: IconButton(
                        onPressed: refresh, icon: Icon(Icons.refresh_rounded))),
              ),
            )
          ],
        ),
        const Spacer(),
      ],
    );
  }
}

class FrostedGlass extends StatelessWidget {
  const FrostedGlass({super.key, required this.childargument});
  final Widget childargument;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // BackdropFilter(
        //   filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        //   child: Container(),
        // ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(100),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.4),
                    Colors.white.withOpacity(0.1),
                  ])),
        ),
        Center(child: childargument)
      ],
    );
  }
}
