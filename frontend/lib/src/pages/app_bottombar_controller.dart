import 'package:flutter/material.dart';
import 'package:frontend/src/configs/constants/app_colors.dart';
import 'package:frontend/src/configs/navigator/router.dart';
import 'package:frontend/src/pages/print_page.dart';
import 'package:frontend/src/pages/tvscreen_page.dart';
import 'package:frontend/src/providers/auth.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppBottomBarController extends StatefulWidget {
  const AppBottomBarController({super.key});

  @override
  State<AppBottomBarController> createState() => _AppBottomBarControllerState();
}

class _AppBottomBarControllerState extends State<AppBottomBarController> {
  int _selectedIndex = 0;
  int? _tempIndex;
  static const List<Widget> _widgetOptions = <Widget>[
    TvScreenPage(),
    PrintPage(),
    Text(''),
  ];

  Future _logout() async {
    await Provider.of<Auth>(context, listen: false).logout();
    if (!Provider.of<Auth>(context, listen: false).authenticated) {
      context.go(Routes.login);
    }
    Navigator.pop(context);
  }

  void showLogoutDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
        title: Text("Logout"),
        content: Text(
            "Do you really want to logout? You will be reset to the login screen."),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = _tempIndex!;
                });
                return;
              },
              child: Text('Cancel')),
          TextButton(onPressed: _logout, child: Text('Logout')),
        ]);

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      setState(() {
        _tempIndex = _selectedIndex;
      });
      showLogoutDialog(context);
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.connected_tv),
            label: 'TV Screen',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_print_shop),
            label: 'Print',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primaryColor[100],
        onTap: _onItemTapped,
      ),
    );
  }
}
