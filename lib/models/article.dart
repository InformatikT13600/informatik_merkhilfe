class Article {

  String language;
  String category;
  int orderPriority;
  String name;
  List<String> content = [];
  List<String> tags = [];

  Article(this.language, this.category, this.name, this.content, this.orderPriority);

  Article.fromJSON(Map<String, dynamic> json) {
    name = json['name'];
    orderPriority = json['orderPriority'];
    language = json['language'];
    category = json['category'];

    List<dynamic> contentList = json['content'];
    contentList.forEach((contentLine) => content.add(contentLine));

    List<dynamic> tagList = json['tags'];
    tagList.forEach((tag) => content.add(tag));
  }

  bool isValid() => name.isNotEmpty && content.isNotEmpty && category.isNotEmpty && language.isNotEmpty;

}
