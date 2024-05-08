import 'package:first/models/blog_model.dart';
import 'package:first/provider/data_provider.dart';
import 'package:first/screens/update_blog.dart';
import 'package:first/screens/view_blog.dart';
import 'package:first/utils/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class BlogListTile extends StatelessWidget {
  final int index;
  final BlogModel blog;
  const BlogListTile({super.key, required this.blog, required this.index});

  @override
  Widget build(BuildContext context) {
    final blogs = Provider.of<DataProvider>(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewBlog(blog: blog),
            ));
      },
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(onDismissed: () {
            blogs.deleteBlog(blog.id);
          }),
          children: [
            SlidableAction(
              onPressed: (context) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateBlog(blog: blog),
                    ));
              },
              backgroundColor: Color(0xFFFFC100),
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
            SlidableAction(
              onPressed: (context) {
                blogs.deleteBlog(blog.id);
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 22.0,
          ),
          constraints: const BoxConstraints(
            minHeight: 70.0,
          ),
          // decoration: BoxDecoration(
          //   color: ColorChange(
          //       index, const Color(0xFFAD88C6), const Color(0xFFFFFFFF)),
          // ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 5,
                height: 40.0,
                child: CircleAvatar(
                  child: Text(blog.title!.isNotEmpty
                      ? blog.title!.characters.first.toUpperCase()
                      : ""),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              blog.title!,
                              style: const TextStyle(
                                overflow: TextOverflow.clip,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFAD88C6),
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          SizedBox(width: 20,),
                          Expanded(
                            child: Text(
                              blog.subtitle!,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Color(0xFFAD88C6),
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                         
                        ],
                      ),
                      
                          Text(
                            formatDate(blog.dateCreated!),
                            style: const TextStyle(
                              color:  Color(0xFFAD88C6),
                              fontSize: 14.0,
                            ),
                          ),
                       const SizedBox(height: 10.0),

                      Text(
                        blog.body!,
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // IconButton(
              //   onPressed: () {
              //     blogs.deleteBlog(blog.id!);
              //   },
              //   icon: const Icon(Icons.delete),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
