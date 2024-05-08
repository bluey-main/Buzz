import 'package:first/provider/data_provider.dart';
import 'package:first/screens/create_blog.dart';
import 'package:first/widgets/blog_list_tile.dart';
import 'package:first/widgets/bottom_to_top_page_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final blogs = Provider.of<DataProvider>(context);

    // Listen to changes in the provider's state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      blogs.load();
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            maxRadius: 5.0,
          ),
        ),
        title: const Text('Buzzz', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            BottomTopPageRoute(builder: (context) => CreateBlog()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: blogs.isLoading ? const Center(child: CircularProgressIndicator(),) : SafeArea(
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
                              blog: blogs.blogs![index], index: index),
                          const Divider()
                        ],
                      );
                    },
                  ),
      ),
    );
  }
}
