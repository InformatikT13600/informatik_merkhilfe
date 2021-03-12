class Category {

  String language;
  String parentCategory;
  int orderPriority;
  String name;

  Category(this.language, this.parentCategory, this.name, this.orderPriority);

  Category.fromJSON(Map<String, dynamic> json) {
    name = json['name'];
    orderPriority = json['orderPriority'];
    language = json['language'];
    parentCategory = json['parentCategory'];
  }

}
