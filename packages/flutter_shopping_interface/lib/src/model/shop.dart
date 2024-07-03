/// Shop interface
abstract class ShopInterface {
  /// ShopInterface constructor
  const ShopInterface({
    required this.id,
    required this.name,
  });

  /// Shop id
  final String id;

  /// Shop name
  final String name;
}

/// Shop model
class Shop implements ShopInterface {
  /// Shop constructor
  const Shop({
    required this.id,
    required this.name,
  });
  @override
  final String id;

  @override
  final String name;
}
