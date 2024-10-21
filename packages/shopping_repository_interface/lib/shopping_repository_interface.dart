// ignore_for_file: directives_ordering

/// models
library;

export "src/models/shop.dart";
export "src/models/product.dart";
export "src/models/category.dart";
export "src/models/shopping_cart.dart";

/// interfaces
export "src/interfaces/shop_repository_interface.dart";
export "src/interfaces/category_repository_interface.dart";
export "src/interfaces/product_repository_interface.dart";
export "src/interfaces/shopping_cart_repository_interface.dart";

/// local
export "src/local/local_shop_repository.dart";
export "src/local/local_category_repository.dart";
export "src/local/local_product_repository.dart";
export "src/local/local_shopping_cart_repository.dart";

/// services
export "src/services/shopping_service.dart";
