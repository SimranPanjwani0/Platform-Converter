import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:converter/provider/profile_provider.dart';
import 'package:converter/provider/settings_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  final GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Consumer2<SettingProvider, ProfileProvider>(
        builder: (context, settingProvider, profileProvider, child) =>
            SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: s.height * 0.01,
              ),
              Card(
                borderOnForeground: true,
                child: ListTile(
                  leading: const Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                  title: const Text("Profile"),
                  subtitle: const Text("Update Profile Data"),
                  trailing: Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      value: settingProvider.isSwitched,
                      onChanged: (value) => settingProvider.isSwitched = value,
                    ),
                  ),
                ),
              ),
              if (settingProvider.isSwitched)
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Stack(
                        children: [
                          CircleAvatar(
                            foregroundImage: profileProvider.image != null
                                ? FileImage(profileProvider.image!)
                                : null,
                            backgroundColor: Colors.lightBlueAccent,
                            radius: 60,
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.black,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 80,
                            child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      padding: const EdgeInsets.all(18),
                                      height: 170,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Profile photo",
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    height: 65,
                                                    child: ElevatedButton(
                                                        child: const Icon(
                                                          Icons.camera_alt,
                                                          size: 35,
                                                        ),
                                                        // title: Text('Camera'),
                                                        onPressed: () async {
                                                          final pickedPhoto =
                                                              await picker
                                                                  .pickImage(
                                                            source: ImageSource
                                                                .camera,
                                                          );
                                                          if (pickedPhoto !=
                                                              null) {
                                                            profileProvider
                                                                .setImage(File(
                                                                    pickedPhoto
                                                                        .path));
                                                          }
                                                          Navigator.of(context)
                                                              .pop();
                                                        }),
                                                  ),
                                                  const SizedBox(
                                                    height: 9,
                                                  ),
                                                  const Text(
                                                    "Camera",
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    height: 65,
                                                    child: ElevatedButton(
                                                        child: const Icon(
                                                          Icons.photo_library,
                                                          size: 35,
                                                        ),
                                                        // title: Text('Gallery'),
                                                        onPressed: () async {
                                                          final pickedPhoto =
                                                              await picker
                                                                  .pickImage(
                                                            source: ImageSource
                                                                .gallery,
                                                          );
                                                          if (pickedPhoto !=
                                                              null) {
                                                            profileProvider
                                                                .setImage(File(
                                                                    pickedPhoto
                                                                        .path));
                                                          }
                                                          Navigator.of(context)
                                                              .pop();
                                                        }),
                                                  ),
                                                  const SizedBox(
                                                    height: 9,
                                                  ),
                                                  const Text(
                                                    "Gallery",
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.blue[900],
                                child: const Icon(
                                  Icons.image_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Form(
                        key: profileFormKey,
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 118.0),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: nameController,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Your Name First...";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  hintText: "Name",
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: bioController,
                                textInputAction: TextInputAction.done,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  hintText: "Bio",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (profileFormKey.currentState!.validate()) {
                                profileFormKey.currentState!.save();
                                profileProvider.setName(nameController.text);
                                profileProvider.setBio(bioController.text);
                              }
                            },
                            child: Text(
                              "SAVE",
                              style: TextStyle(
                                color: Colors.blue[900],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              profileProvider.setName(null);
                              profileProvider.setBio(null);
                              nameController.clear();
                              bioController.clear();
                              profileProvider.setImage(null);
                            },
                            child: Text(
                              "CLEAR",
                              style: TextStyle(
                                color: Colors.blue[900],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                )
              else
                Container(),
              const Divider(),
              Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.sunny,
                    color: Colors.grey,
                  ),
                  title: const Text("Theme"),
                  subtitle: const Text("Change Theme"),
                  trailing: Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      value: settingProvider.isDark,
                      onChanged: (value) => settingProvider.isDark = value,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
