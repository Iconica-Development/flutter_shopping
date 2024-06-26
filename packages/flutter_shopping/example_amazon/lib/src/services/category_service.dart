import "package:amazon/src/models/my_category.dart";
import "package:amazon/src/models/my_product.dart";
import "package:flutter_shopping/flutter_shopping.dart";

Map<String, String> categories = {
  "Electronics": "Electronica",
  "Smart phones": "Telefoons",
  "TV's": "TV's",
};

List<MyProduct> allProducts() => [
      MyProduct(
        id: "1",
        name:
            "Skar Audio Single 8\" Complete 1,200 Watt EVL Series Subwoofer Bass Package - Includes Loaded Enclosure with...",
        price: 2.99,
        category: categories["Electronics"]!,
        imageUrl:
            "https://m.media-amazon.com/images/I/710n3hnbfXL._AC_UY218_.jpg",
      ),
      MyProduct(
        id: "2",
        name:
            "Frameo 10.1 Inch WiFi Digital Picture Frame, 1280x800 HD IPS Touch Screen Photo Frame Electronic, 32GB Memory, Auto...",
        price: 2.99,
        category: categories["Electronics"]!,
        imageUrl:
            "https://m.media-amazon.com/images/I/61O+aorCp0L._AC_UY218_.jpg",
      ),
      MyProduct(
        id: "3",
        name:
            "STREBITO Electronics Precision Screwdriver Sets 142-Piece with 120 Bits Magnetic Repair Tool Kit for iPhone, MacBook,...",
        price: 1.99,
        category: categories["Electronics"]!,
        imageUrl:
            "https://m.media-amazon.com/images/I/81-C7lGtQsL._AC_UY218_.jpg",
      ),
      MyProduct(
        id: "4",
        name:
            "Samsung Galaxy A15 (SM-155M/DSN), 128GB 6GB RAM, Dual SIM, Factory Unlocked GSM, International Version (Wall...",
        price: 1.99,
        category: categories["Smart phones"]!,
        imageUrl:
            "https://m.media-amazon.com/images/I/51rp0nqaPoL._AC_UY218_.jpg",
      ),
      MyProduct(
        id: "5",
        name:
            "SAMSUNG Galaxy S24 Ultra Cell Phone, 512GB AI Smartphone, Unlocked Android, 50MP Zoom Camera, Long...",
        price: 1.99,
        category: categories["Smart phones"]!,
        imageUrl:
            "https://m.media-amazon.com/images/I/71ZoDT7a2wL._AC_UY218_.jpg",
      ),
    ];

List<MyCategory> getCategories() => <MyCategory>[
      MyCategory(id: "1", name: categories["Electronics"]!),
      MyCategory(id: "2", name: categories["Smart phones"]!),
      MyCategory(id: "3", name: categories["TV's"]!),
      const MyCategory(id: "4", name: "Monitoren"),
      const MyCategory(id: "5", name: "Speakers"),
      const MyCategory(id: "6", name: "Toetsenborden"),
    ];

ProductPageContent getShopContent(String shopId) {
  var products = getProducts(shopId);
  return ProductPageContent(
    products: products,
  );
}

List<MyProduct> getProducts(String categoryId) {
  if (categoryId == "1") {
    return allProducts();
  } else if (categoryId == "2") {
    return allProducts()
        .where((product) => product.category == categories["Smart phones"]!)
        .toList();
  } else if (categoryId == "3") {
    return allProducts()
        .where((product) => product.category == categories["TV's"]!)
        .toList();
  } else {
    return [];
  }
}
