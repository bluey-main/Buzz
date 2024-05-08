import 'package:first/models/blog_model.dart';
import 'package:first/utils/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ViewBlog extends StatelessWidget {
  final BlogModel blog;
  const ViewBlog({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Post"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width /1.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            softWrap: true,
                            maxLines: 3,
                            blog.title!,
                            style: const TextStyle(fontSize: 25.0),
                          ),
                          Row(
                            children: [
                              Text(
                                blog.subtitle!,
                                style: const TextStyle(fontSize: 15.0),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                formatDate(blog.dateCreated!),
                                style: const TextStyle(fontSize: 15.0),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 35.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    blog.body!,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}


    // Text(blog.title!, style: const TextStyle(fontSize: 35.0),),
                // Text(blog.subtitle!, style: const TextStyle(fontSize: 20.0),),
                // Text(blog.body!, style: const TextStyle(fontSize: 20.0),),
                