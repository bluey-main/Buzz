import 'package:first/provider/data_provider.dart';
import 'package:first/screens/add_user_profile.dart';
import 'package:first/screens/create_blog.dart';
import 'package:first/widgets/blog_list_tile.dart';
import 'package:first/widgets/bottom_to_top_page_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _box = Hive.box("profile");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final blogs = Provider.of<DataProvider>(context);
     String? profileName = _box.get("profileName");


    // Listen to changes in the provider's state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      blogs.load();
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: (){
          Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddProfileName(),
                ),
              );
            },
            child: CircleAvatar(
              maxRadius: 5.0,
              child: Text( profileName.toString().characters.elementAt(1).toUpperCase()),
            ),
          ),
        ),
        title: const Text(
          'Buzzz',
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
       
      ),
      floatingActionButton: profileName == null ? const Text(""): FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            BottomTopPageRoute(builder: (context) => CreateBlog()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: profileName == null
          ? Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddProfileName(),
                      ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFAD88C6),
                ),
                child: const Text(
                  "ADD A USERNAME",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          : blogs.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SafeArea(
                  child: blogs.blogs == null
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : blogs.blogs!.isEmpty
                          ? const Center(
                              child: Text("No Blogs"),
                            )
                          : ListView.builder(
                              itemCount: blogs.blogs!.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    BlogListTile(
                                        blog: blogs.blogs![index],
                                        index: index),
                                    const Divider()
                                  ],
                                );
                              },
                            ),
                ),
    );
  }
}
