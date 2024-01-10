import 'dart:ui';

import 'package:aimlproject/widgets/bottombar_item.dart';
import 'package:aimlproject/breed_predictor.dart';
import 'package:aimlproject/screens/chat.dart';
import 'package:aimlproject/themes/color.dart';
import 'package:aimlproject/screens/home.dart';
import 'package:flutter/material.dart';
// import 'package:pet_app/screens/chat.dart';
// import 'package:pet_app/screens/home.dart';
// import 'package:pet_app/theme/color.dart';
// import 'package:pet_app/utils/constant.dart';
// import 'package:pet_app/widgets/bottombar_item.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> with TickerProviderStateMixin {
  int _activeTab = 0;
  final List barItems = [
    {
      "icon": "assets/icons/home-border.svg",
      "active_icon": "assets/icons/home.svg",
      "page": HomePage(),
    },
    {
      "icon": "assets/icons/pet-border.svg",
      "active_icon": "assets/icons/pet.svg",
      // "page": Container(
      //     child: Center(
      //   child: Text("Setting Page"),
      // )),
      "page": Home()
    },
    {
      "icon": "assets/icons/chat-border.svg",
      "active_icon": "assets/icons/chat.svg",
      "page": ChatPage(),
    },
    {
      "icon": "assets/icons/setting-border.svg",
      "active_icon": "assets/icons/setting.svg",
      "page": Container(
        child: Center(
          child: Text("Setting Page"),
        ),
      ),
    },
  ];

//====== set animation=====
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  _buildAnimatedPage(page) {
    return FadeTransition(child: page, opacity: _animation);
  }

  void onPageChanged(int index) {
    _controller.reset();
    setState(() {
      _activeTab = index;
    });
    _controller.forward();
  }

//====== end set animation=====

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBgColor,
      body: _buildPage(),
      floatingActionButton: _buildBottomBar(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }

  Widget _buildPage() {
    return IndexedStack(
      index: _activeTab,
      children: List.generate(
        barItems.length,
        (index) => _buildAnimatedPage(barItems[index]["page"]),
      ),
    );
  }

  Widget _buildBottomBar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 350,
        height: 55,
        child: Stack(children: [
          // BackdropFilter(
          //   filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          //   child: Container(),
          // ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(50),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.4),
                      Colors.white.withOpacity(0.1),
                    ])),
          ),
          Container(
            height: 55,
            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(
                barItems.length,
                (index) => BottomBarItem(
                  _activeTab == index
                      ? barItems[index]["active_icon"]
                      : barItems[index]["icon"],
                  isActive: _activeTab == index,
                  activeColor: AppColor.primary,
                  onTap: () => onPageChanged(index),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
