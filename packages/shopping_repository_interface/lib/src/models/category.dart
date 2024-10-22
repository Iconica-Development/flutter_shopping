/// Category model
class Category {
  /// Constructor for the category.
  const Category({
    required this.id,
    required this.name,
  });

  /// Create a category from a map.
  factory Category.fromMap(String id, Map<String, dynamic> map) => Category(
        id: id,
        name: map["name"],
      );

  /// The id of the category.
  final String id;

  /// The name of the category.
  final String name;

  /// Convert the category to a map.
  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
