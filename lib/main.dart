import 'package:converter/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:converter/provider/add_contact_provider.dart';
import 'package:converter/provider/platform_provider.dart';
import 'package:converter/provider/profile_provider.dart';
import 'package:converter/provider/settings_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PlatformProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddContactProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SettingProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
