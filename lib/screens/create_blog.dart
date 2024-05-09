import 'package:first/provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CreateBlog extends StatelessWidget {
  CreateBlog({super.key});

  final TextEditingController _titleTextEditingController =
      TextEditingController();

  final TextEditingController _bodyTextEditingController =
      TextEditingController();
  final  _box = Hive.box("profile");


  static const uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    final blogs = Provider.of<DataProvider>(context);
     String? profileName = _box.get("profileName");

    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.cancel,
            size: 30.0,
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              final snackBar = SnackBar(
              content: const Text('Fill EVERYTHING'),
              duration: const Duration(seconds: 2), // Set the duration for how long the Snackbar should be displayed
              action: SnackBarAction(
                label: 'Close',
                onPressed: () {
                  // Perform some action when the user taps on the action button
                },
              ),
            );

            
              if(_bodyTextEditingController.text.isEmpty || _bodyTextEditingController.text.isEmpty ){
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                return;
              }
              blogs.createBlog(uuid.v4(), _titleTextEditingController.text.trim(), profileName ?? "" , _bodyTextEditingController.text.trim());
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFAD88C6),
            ),
            child: const Text(
              'post',
              style: TextStyle(color: Colors.white, fontSize: 15.0),
            ),
          ),
          const SizedBox(
            width: 15,
          )
        ],
      ),
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(radius: 25.0, child: Text(profileName.toString().characters.elementAt(1).toUpperCase())),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                children: [
                  TextField(
                    autofocus: true,
                    textCapitalization: TextCapitalization.words,
                    style: const TextStyle(fontSize: 30.0),
                    controller: _titleTextEditingController,
                    decoration: const InputDecoration(
                      hintText: "Post Title",
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.multiline,
                    minLines:  1,
                    maxLines: 4, // Allow for unlimited number of lines
                  ),
                  const Divider(),
                  Expanded(
                    child: TextField(
                      controller: _bodyTextEditingController,
                      decoration: const InputDecoration(
                        hintText: "What's Happening",
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.multiline,
                      
                      maxLines: 23, // Allow for unlimited number of lines
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
