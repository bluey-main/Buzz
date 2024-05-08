class BlogModel {
  final String? id;
  final String? title;
  final String? subtitle;
  final String? body;
  final String? dateCreated;

  BlogModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.dateCreated,

  });

  static BlogModel fromMap({required Map map}) => BlogModel(
        id: map['id'],
        title: map['title'],
        subtitle: map['subTitle'],
        body: map['body'],
        dateCreated:map['dateCreated'],
      );

    // BlogModel.fromJson(Map<String, dynamic> json)
    // : id = json['id'],
    //   title = json['title'];
 
}
