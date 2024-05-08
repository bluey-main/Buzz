import 'package:first/models/blog_model.dart';
import 'package:first/graphql/graphql_service.dart';
import 'package:first/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DataProvider extends ChangeNotifier {
  List<BlogModel>? _blogs;
  final GraphqlService _graphqlService = GraphqlService();
  bool _isLoading = false;
  final _myBox = Hive.box("profile");
  String? _profileName;
  
  

  List<BlogModel>? get blogs => _blogs;
  GraphqlService get graphqlService => _graphqlService;
  bool get isLoading => _isLoading;
  String? get profileName => _profileName;

  void getProfileName() {
    _profileName = _myBox.get('profileName');
    if (_profileName == null) {
      _myBox.put('profileName', '');
    }
    print(_profileName);
    notifyListeners();
  }

  void addProfileName(String newProfileName, BuildContext context) {
    _myBox.put('profileName', newProfileName);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );
    notifyListeners();
  }

  void deleteProfileName() {
    _myBox.put("profileName", '');

    notifyListeners();
  }

  void load() async {
    _blogs = null;
    _blogs = await _graphqlService.getBlogs();
    notifyListeners();
  }

  void deleteBlog(String? id) async {
    _isLoading = true;
    _graphqlService.deleteBlog(id: id!);
    notifyListeners();
    _isLoading = false;
  }

  void createBlog(
    String id,
    String title,
    String subTitle,
    String body,
  ) async {
    _graphqlService.createBlog(
      id: id,
      title: title,
      subTitle: subTitle,
      body: body,
    );
    notifyListeners();
  }

  void updateBlog(String id, String title, String subTitle, String body,
      String dateCreated) async {
    _graphqlService.updateBlog(
        id: id,
        title: title,
        subTitle: subTitle,
        body: body,
        dateCreated: dateCreated);
    notifyListeners();
  }
}
