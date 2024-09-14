import 'package:flutter/material.dart';
import 'package:frontend/src/configs/constants/app_colors.dart';
import 'package:frontend/src/providers/sale.dart';
import 'src/configs/navigator/router.dart';
import 'package:provider/provider.dart';
import 'package:frontend/src/providers/auth.dart';

void main() {
  // runApp(ListenableProvider(create: (_) => Auth(), child: MyApp()));
  // Provider.debugCheckInvalidValueType = null;
  runApp(MultiProvider(
    providers: [
      ListenableProvider(create: (_) => Auth()),
      ListenableProvider(create: (_) => Sale()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final _appRouter = router();

    return MaterialApp.router(
      routerConfig: _appRouter,
      title: "Foodorderanywhere Print App",
      theme: ThemeData(
        primarySwatch: AppColors.primaryColor,
        primaryColor: AppColors.primaryColor,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
