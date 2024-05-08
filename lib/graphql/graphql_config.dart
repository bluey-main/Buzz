

import 'package:graphql_flutter/graphql_flutter.dart';

class GraphqlConfig {
  static HttpLink httpLink = HttpLink(
      "https://uat-api.vmodel.app/graphql/");

  GraphQLClient clientToQuery() =>
      GraphQLClient(link: httpLink, cache: GraphQLCache());
}
