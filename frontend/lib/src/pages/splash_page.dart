import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:frontend/src/providers/auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/src/configs/constants/app_variable.dart';
import 'package:frontend/src/configs/navigator/router.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      FlutterNativeSplash.remove();

      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'auth');
      if (token?.isEmpty ?? true) {
        _onError();
        return;
      } else {
        try {
          await Provider.of<Auth>(context, listen: false).getMe(token);
          if (Provider.of<Auth>(context, listen: false).authenticated == true) {
            _onSuccess();
          } else {
            _onError();
          }
        } catch (e) {
          _onError();
        }
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _onError() {
    context.go(Routes.login);
  }

  void _onSuccess() {
    context.go(Routes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  child: CircularProgressIndicator(
                    strokeWidth: 3.0,
                    color: Colors.deepOrange,
                  ),
                  width: 25,
                  height: 25,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Loading...',
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 25),
                  child: Text(
                    "Powered by Foodorderanywhere v${AppVariable.VERSION_NAME}",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
