import "package:shopping_repository_interface/shopping_repository_interface.dart";

/// The shopping service.
class ShoppingService {
  /// The Construtor of the shopping service.
  ShoppingService({
    ShopRepositoryInterface? shopRepository,
    ProductRepositoryInterface? productRepository,
    CategoryRepositoryInterface? categoryRepository,
    ShoppingCartRepositoryInterface? shoppingCartRepository,
  })  : shopRepository = shopRepository ?? LocalShopRepository(),
        productRepository = productRepository ?? LocalProductRepository(),
        categoryRepository = categoryRepository ?? LocalCategoryRepository(),
        shoppingCartRepository =
            shoppingCartRepository ?? LocalShoppingCartRepository();

  /// The shop repository.
  final ShopRepositoryInterface shopRepository;

  /// The product repository.
  final ProductRepositoryInterface productRepository;

  /// The category repository.
  final CategoryRepositoryInterface categoryRepository;

  /// The shopping cart repository.
  final ShoppingCartRepositoryInterface shoppingCartRepository;

  /// The selected categories.
  final List<Category> selectedCategories = [];

  /// The selected shop.
  Shop? selectedShop;

  /// Get the shops.
  Stream<List<Shop>> getShops() => shopRepository.getShops();

  /// Select a shop.
  Shop? selectShop(String shopId) {
    selectedShop = shopRepository.selectShop(shopId);
    return selectedShop;
  }

  /// Get the selected shop.
  Shop? getSelectedShop() => shopRepository.getSelectedShop();

  /// Get the shop.
  Shop? getShop(String? shopId) => shopRepository.getShop(shopId);

  /// Get the products.
  Stream<List<Product>> getProducts(String shopId) =>
      productRepository.getProducts(
        selectedCategories,
        shopId,
      );

  /// Select a product.
  Product? selectProduct(String? productId) =>
      productRepository.selectProduct(productId);

  /// Get the product.
  Product? getProduct(String? productId) =>
      productRepository.getProduct(productId);

  /// Get the weekly offer.
  Product? getWeeklyOffer() => productRepository.getWeeklyOffer();

  /// Get the categories.
  Stream<List<Category>> getCategories() => categoryRepository.getCategories();

  /// Select a category.
  Category? selectCategory(String? categoryId) {
    var category = categoryRepository.selectCategory(categoryId);
    if (category != null) selectedCategories.add(category);
    getProducts(selectedShop?.id ?? "");
    return category;
  }

  /// Get the selected category stream.
  Stream<List<Category>?> getSelectedCategoryStream() =>
      categoryRepository.getSelectedCategoryStream();

  /// Deselect a category.
  void deselectCategory(String? categoryId) {
    selectedCategories.removeWhere((category) => category.id == categoryId);
    getProducts(selectedShop?.id ?? "");
    categoryRepository.deselectCategory(categoryId);
  }

  /// Get the cart length.
  Stream<int> getCartLength() => shoppingCartRepository.getCartLength();

  /// Get the shopping cart.
  Stream<ShoppingCart> getShoppingCart() =>
      shoppingCartRepository.getShoppingCart();

  /// Add a product to the cart.
  Future<void> addProductToCart(Product product) =>
      shoppingCartRepository.addProductToCart(product);

  /// Remove a product from the cart.
  Future<void> removeProductFromCart(Product product) =>
      shoppingCartRepository.removeProductFromCart(product);
}
