import 'package:first/models/blog_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:first/graphql/graphql_config.dart';

class GraphqlService {
  static GraphqlConfig graphqlConfig = GraphqlConfig();
  GraphQLClient graphQLClient = graphqlConfig.clientToQuery();

  Future<List<BlogModel>> getBlogs() async {
    try {
      QueryResult result = await graphQLClient.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
            query fetchAllBlogs {
              allBlogPosts {
                id
                title
                subTitle
                body
                dateCreated
              }
            }
            """),
        ),
      );

      if (result.hasException) {
        throw Exception();
      }

      List? res = result.data?['allBlogPosts'];

      if (res == null || res.isEmpty) {
        return [];
      }

      List<BlogModel> blogs =
          res.map((blog) => BlogModel.fromMap(map: blog)).toList();
      return blogs;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> deleteBlog({required String id}) async {
    try {
      QueryResult result = await graphQLClient.mutate(
        MutationOptions(
          document: gql(
            """
        mutation deleteBlogPost(\$blogId: String!) {
        deleteBlog(blogId: \$blogId) {
        success
        }
      }
        
        """,
          ),
          variables: {"blogId": id},
        ),
      );

      if (result.hasException) {
        throw Exception();
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> createBlog(
      {required String id,
      required String title,
      required String subTitle,
      required String body,
      }) async {
    try {
      QueryResult result = await graphQLClient.mutate(
        MutationOptions(
          document: gql(
            """
    mutation createBlogPost(\$title: String!, \$subTitle: String!, \$body: String!) {
    createBlog(title: \$title, subTitle: \$subTitle, body: \$body) {
      success
      blogPost {
        id
        title
        subTitle
        body
        dateCreated
      }
    }
  }
        
        """,
          ),
          variables: {
            "id": id,
            "body": body,
            "subTitle": subTitle,
            "title": title
          },
        ),
      );

      if (result.hasException) {
        throw Exception();
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateBlog(
      {required String id,
      required String title,
      required String subTitle,
      required String body,
      required String dateCreated}) async {
    try {
      QueryResult result = await graphQLClient.mutate(
        MutationOptions(
          document: gql(
            """
      mutation updateBlogPost(\$blogId: String!, \$title: String!, \$subTitle: String!, \$body: String!) {
    updateBlog(blogId: \$blogId, title: \$title, subTitle: \$subTitle, body: \$body) {
      success
      blogPost {
        id
        title
        subTitle
        body
        dateCreated
      }
    }
  }
        
        """,
          ),
          variables: {
            "blogId": id,
            "body": body,
            "subTitle": subTitle,
            "title": title
          },
        ),
      );

      if (result.hasException) {
        throw Exception();
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }
}
