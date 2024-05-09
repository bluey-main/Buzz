import 'package:first/models/blog_model.dart';
import 'package:first/provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class UpdateBlog extends StatefulWidget {
  final BlogModel blog;
  UpdateBlog({Key? key, required this.blog}) : super(key: key);

  @override
  _UpdateBlogState createState() => _UpdateBlogState();
}

class _UpdateBlogState extends State<UpdateBlog> {
  late TextEditingController _titleTextEditingController;
  late TextEditingController _bodyTextEditingController;
  final  _box = Hive.box("profile");


  @override
  void initState() {
    super.initState();
    _titleTextEditingController = TextEditingController(text: widget.blog.title);
    _bodyTextEditingController = TextEditingController(text: widget.blog.body);
  }

  @override
  void dispose() {
    _titleTextEditingController.dispose();
    _bodyTextEditingController.dispose();
    super.dispose();
  }

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
              if (_bodyTextEditingController.text.trim().isEmpty ||
                  _titleTextEditingController.text.trim().isEmpty) {
                _showSnackBar(context, 'Fill EVERYTHING');
                return;
              }
              blogs.updateBlog(
                widget.blog.id!,
                _titleTextEditingController.text.trim(),
               profileName ?? "",
                _bodyTextEditingController.text.trim(),
                widget.blog.dateCreated!,
              );
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFAD88C6),
            ),
            child: const Text(
              'Update',
              style: TextStyle(color: Colors.white, fontSize: 15.0),
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             CircleAvatar(radius: 25.00, child: Text(profileName.toString().characters.elementAt(1).toUpperCase())),
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

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
