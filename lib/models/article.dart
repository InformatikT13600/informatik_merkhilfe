class Article {

  String language;
  String category;
  int orderPriority;
  String name;
  List<String> content = [];

  Article(this.language, this.category, this.name, this.content, this.orderPriority);

  Article.fromJSON(Map<String, dynamic> json) {
    name = json['name'];
    orderPriority = json['orderPriority'];
    language = json['language'];
    category = json['category'];

    List<dynamic> contentList = json['content'];
    for(String contentLine in contentList) content.add(contentLine);
  }

  bool isValid() => name.isNotEmpty && content.isNotEmpty && category.isNotEmpty && language.isNotEmpty;

}
