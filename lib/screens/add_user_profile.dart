import 'package:first/provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class AddProfileName extends StatefulWidget {
  AddProfileName({Key? key}) : super(key: key);

  @override
  State<AddProfileName> createState() => _AddProfileNameState();
}

class _AddProfileNameState extends State<AddProfileName> {
  final TextEditingController _profileNameTextEditingController =
      TextEditingController();
  final  _box = Hive.box("profile");
 

  @override
  void initState() {
    super.initState();
    // Call getProfileName when the widget is initialize
  }

  void setProfileName() {
    if (_profileNameTextEditingController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a name")),
      );
      return;
    }
    _box.put(
        "profileName", "@${_profileNameTextEditingController.text.trim()}");

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
     String? profileName = _box.get("profileName");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Profile Name"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display profile name if available
              Text(
                profileName ?? "",
                style: const TextStyle(
                    fontSize: 26.0, fontWeight: FontWeight.bold),
              ),

              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: _profileNameTextEditingController,
                decoration: const InputDecoration(
                  labelText: 'Enter Profile Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: setProfileName,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFAD88C6),
                ),
                child: const Text(
                  "Save Profile",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
