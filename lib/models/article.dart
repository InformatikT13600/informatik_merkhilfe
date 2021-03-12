class Article {

  String language;
  String category;
  int orderPriority;
  String name;
  List<String> content;

  Article(this.language, this.category, this.name, this.content, this.orderPriority);

  Article.fromJSON(Map<String, dynamic> json) {
    name = json['name'];
    orderPriority = json['orderPriority'];
    language = json['language'];
    category = json['parentCategory'];
    content = json['content'];
  }

}
