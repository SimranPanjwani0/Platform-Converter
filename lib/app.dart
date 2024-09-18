import 'package:converter/provider/platform_provider.dart';
import 'package:converter/provider/settings_provider.dart';
import 'package:converter/views/screens/android/home_page.dart';
import 'package:converter/views/screens/ios/ios_home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<PlatformProvider, SettingProvider>(
      builder: (context, platformProvider, settingProvider, child) {
        return platformProvider.isAndroid
            ? MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: settingProvider.isDark
                    ? ThemeData.dark(useMaterial3: true)
                    : ThemeData.light(useMaterial3: true),
                routes: {
                  '/': (context) => HomePage(),
                },
              )
            : CupertinoApp(
                debugShowCheckedModeBanner: false,
                theme: CupertinoThemeData(
                  brightness: settingProvider.isDark
                      ? Brightness.dark
                      : Brightness.light,
                ),
                routes: {
                  '/': (context) => const IOsHomePage(),
                },
              );
      },
    );
  }
}
