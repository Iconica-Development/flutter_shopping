/// Shop model
class Shop {
  /// Constructor for the shop.
  const Shop({
    required this.id,
    required this.name,
    required this.adress,
  });

  /// Create a shop from a map.
  factory Shop.fromMap(String id, Map<String, dynamic> map) => Shop(
        id: id,
        name: map["name"],
        adress: map["adress"],
      );

  /// The id of the shop.
  final String id;

  /// The name of the shop.
  final String name;

  /// The adress of the shop.
  final String adress;

  /// Convert the shop to a map.
  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "adress": adress,
      };
}
