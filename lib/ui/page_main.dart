import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_2/models/profile.dart';
import 'package:flutter_application_2/providers/menubarviewmodel.dart';
import 'package:flutter_application_2/providers/mainviewmodel.dart';
import 'package:flutter_application_2/ui/AppConstant.dart';
import 'package:flutter_application_2/ui/page_login.dart';
import 'package:provider/provider.dart';

import 'Checkins.dart';
import 'ClassList.dart';
import 'News.dart';
import 'Profiles.dart';
import 'Search.dart';
import 'SessionList.dart';
import 'package:avatar_glow/avatar_glow.dart';

import 'page_dklop.dart';

class PageMain extends StatelessWidget {
  static String routename = '/home';
  PageMain({super.key});
  final List<String> menuTitles = [
    "News",
    "Profile",
    "Check-in",
    "Search",
    "Class List",
    "Session List",
  ];

  final menuBar = MenuItemlist();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewmodel = Provider.of<MainViewModel>(context);
    Profile profile = Profile();
    // if (profile.token == "") {
    //   return PageLogin();
    // }
    // if (profile.student.mssv == "") {
    //   return PageDangKyLop();
    // }
    Widget body = News();
    if (viewmodel.activemenu == Profiles.idpage) {
      body = Profiles();
    } else if (viewmodel.activemenu == Checkins.idpage) {
      body = Checkins();
    } else if (viewmodel.activemenu == Search.idpage) {
      body = Search();
    } else if (viewmodel.activemenu == ClassList.idpage) {
      body = ClassList();
    } else if (viewmodel.activemenu == SessionList.idpage) {
      body = SessionList();
    }

    menuBar.initialize(menuTitles);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFC8132B),
        leading: GestureDetector(
          onTap: () => viewmodel.toggleMenu(),
          // onTap: () => MainViewModel().closeMenu(),
          child: Icon(
            Icons.menu,
            color: Color(0xFFEEB60F),
          ),
        ),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Consumer<MenuBarViewModel>(
            builder: (context, menuBarModel, child) {
              return GestureDetector(
                // onTap: () {
                //   viewmodel.closeMenu();
                // },
                // onTap: () => MainViewModel().closeMenu(),
                onTap: () => viewmodel.closeMenu(),
                child: Center(
                  child: body,
                ),
              );
            },
          ),
          viewmodel.menustatus == 1
              ? Consumer<MenuBarViewModel>(
                  builder: (context, menuBarModel, child) {
                    return GestureDetector(
                        onPanUpdate: (details) {
                          menuBarModel.setOffset(details.localPosition);
                        },
                        onPanEnd: (details) {
                          menuBarModel.setOffset(Offset(0, 0));
                          viewmodel.closeMenu();
                        },
                        child: Stack(
                          children: [CustomMenuSideBar(size: size), menuBar],
                        ));
                  },
                )
              : Container(),
        ],
      )),
    );
  }
}

class MenuItemlist extends StatelessWidget {
  MenuItemlist({
    super.key,
  });

  final List<MenuBarItem> menuBarItems = [];
  void initialize(List<String> menuTitles) {
    menuBarItems.clear();
    for (int i = 0; i < menuTitles.length; i++) {
      menuBarItems.add(MenuBarItem(
        idpage: i,
        containerkey: GlobalKey(),
        title: menuTitles[i],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.2,
          width: size.width * 0.65,
          child: Center(
            child: AvatarGlow(
              endRadius: size.height * 1,
              duration: Duration(microseconds: 2000),
              repeat: true,
              showTwoGlows: true,
              repeatPauseDuration: Duration(milliseconds: 1000),
              glowColor: Colors.yellow,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(size.height),
                child: SizedBox(
                  height: size.height * 0.18,
                  width: size.width * 0.3,
                  child: Image(
                      image: AssetImage('assets/Emblem_of_Vietnam.png'),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 18,
        ),
        Container(
          height: 2,
          width: size.width * 0.65,
          color: Color(0xFFC8132B),
        ),
        SizedBox(
          height: 18,
        ),
        SizedBox(
          height: size.height * 0.6,
          width: size.width * 0.65,
          child: Padding(
            padding: const EdgeInsets.only(left: 27),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: menuBarItems.length,
              itemBuilder: (context, index) {
                return menuBarItems[index];
              },
            ),
          ),
        ),
      ],
    );
  }
}

class MenuBarItem extends StatelessWidget {
  MenuBarItem({
    super.key,
    required this.title,
    required this.containerkey,
    required this.idpage,
  });
  final int idpage;
  final String title;
  final GlobalKey containerkey;
  TextStyle style = AppConstant.textlink;
  void onPanmove(Offset offset) {
    if (offset.dy == 0) {
      style = AppConstant.textlink;
    }
    if (containerkey.currentContext != null) {
      RenderBox box =
          containerkey.currentContext!.findRenderObject() as RenderBox;
      Offset position = box.localToGlobal(Offset.zero);
      if (offset.dy < position.dy - 40 && offset.dy > position.dy - 80) {
        style = AppConstant.texterror;
        MainViewModel().activemenu = idpage;
      } else {
        style = AppConstant.textlink;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final menuBarModel = Provider.of<MenuBarViewModel>(context);
    onPanmove(menuBarModel.offset);
    return GestureDetector(
      onTap: () => MainViewModel().setActiveMenu(idpage),
      child: Container(
        key: containerkey,
        alignment: Alignment.centerLeft,
        height: 40,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class CustomMenuSideBar extends StatelessWidget {
  const CustomMenuSideBar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final sizeBarModel = Provider.of<MenuBarViewModel>(context);
    final size = MediaQuery.of(context).size;
    return CustomPaint(
      size: Size(size.width * 0.65, size.height),
      painter: DrawerCustomPaint(offset: sizeBarModel.offset),
    );
  }
}

class DrawerCustomPaint extends CustomPainter {
  final Offset offset;

  DrawerCustomPaint({super.repaint, required this.offset});
  double generatePointX(double width) {
    double kq = 0;
    if (offset.dx == 0) {
      kq = width;
    } else if (offset.dx < width) {
      kq = width + 75;
    } else {
      kq = offset.dx;
    }
    return kq;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = Paint()
      ..color = Colors.orangeAccent
      ..style = PaintingStyle.fill;
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    // path.lineTo(size.width, size.height);
    path.quadraticBezierTo(
        generatePointX(size.width), offset.dy, size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
