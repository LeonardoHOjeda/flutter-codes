import 'package:flutter/material.dart';
import 'package:progra_movil/screens/practice_four.dart';
import 'package:progra_movil/screens/practice_two.dart';
import 'package:progra_movil/screens/screens.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _DrawerHeader(),
          ListTile(
            leading: Icon(Icons.home_rounded),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, HomeScreen.routerName);
            },
          ),
          ListTile(
            leading: Icon(Icons.looks_two_rounded),
            title: Text('Practice 2 - CºFº to FºCº '),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, PracticeTwoScreen.routerName);
            },
          ),
          ListTile(
            leading: Icon(Icons.looks_3_rounded),
            title: Text('Practice 3 - UI Login'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, PracticeThreeScreen.routerName);
            },
          ),
          ListTile(
            leading: Icon(Icons.looks_4_rounded),
            title: Text('Practice 4 - Movies'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, PracticeFourScreen.routerName);
            },
          ),
        ],
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Container(),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/menu-img.jpg'), fit: BoxFit.cover)),
    );
  }
}
