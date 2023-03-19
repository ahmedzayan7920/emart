class CategoryModel {
  final List<Categories>? categories;

  CategoryModel({
    this.categories,
  });

  CategoryModel.fromJson(Map<String, dynamic> json)
      : categories = (json['categories'] as List?)
            ?.map((dynamic e) => Categories.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {'categories': categories?.map((e) => e.toJson()).toList()};
}

class Categories {
  final String? name;
  final List<String>? subCategories;

  Categories({
    this.name,
    this.subCategories,
  });

  Categories.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        subCategories = (json['subCategories'] as List?)?.map((dynamic e) => e as String).toList();

  Map<String, dynamic> toJson() => {'name': name, 'subCategories': subCategories};
}
