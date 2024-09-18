import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:converter/views/screens/android/settings_page.dart';

import 'package:provider/provider.dart';

import '../../../provider/platform_provider.dart';
import 'add_contact_page.dart';
import 'chat_page.dart';
import 'contact_list_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabBarController;

  @override
  void initState() {
    super.initState();
    tabBarController = TabController(length: 4, vsync: this);
  }

  bool isAndroid = Platform.isAndroid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        leading: Container(),
        title: const Center(
            child: Text(
          " Contacts",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        )),
        actions: [
          Consumer<PlatformProvider>(
            builder: (context, provider, child) => Transform.scale(
              scale: 0.8,
              child: Switch(
                activeColor: Colors.white,
                value: provider.isAndroid,
                onChanged: (val) {
                  provider.changePlatform(value: val);
                },
              ),
            ),
          ),
        ],
        bottom: TabBar(
          controller: tabBarController,
          tabs: const [
            Tab(
              icon: Icon(
                Icons.add_ic_call_outlined,
                color: Colors.white,
              ),
            ),
            Tab(
              child: Icon(
                CupertinoIcons.chat_bubble_2_fill,
                color: Colors.white,
              ),
            ),
            Tab(
              child: Icon(
                Icons.call,
                color: Colors.white,
              ),
            ),
            Tab(
              child: Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabBarController,
        children: [
          const AddContactPage(),
          const ChatContactPage(),
          const ContactListPage(),
          SettingsPage(),
        ],
      ),
    );
  }
}
