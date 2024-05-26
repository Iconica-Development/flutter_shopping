import "package:example/src/models/my_product.dart";
import "package:example/src/models/my_shop.dart";
import "package:flutter_product_page/flutter_product_page.dart";

/// This function should have your own implementation. Generally this would
/// contain some API call to fetch the list of shops.
List<MyShop> getShops() => <MyShop>[
      const MyShop(id: "1", name: "Shop 1"),
      const MyShop(id: "2", name: "Shop 2"),
      const MyShop(id: "3", name: "Shop 3"),
    ];

ProductPageContent getShopContent(String shopId) {
  var products = getProducts(shopId);
  return ProductPageContent(
    discountedProduct: products.first,
    products: products,
  );
}

/// This function should have your own implementation. Generally this would
/// contain some API call to fetch the list of products for a shop.
List<MyProduct> getProducts(String shopId) => <MyProduct>[
      MyProduct(
        id: "1",
        name: "White bread",
        price: 2.99,
        category: "Loaves",
        imageUrl: "https://via.placeholder.com/150",
        hasDiscount: true,
        discountPrice: 1.99,
      ),
      MyProduct(
        id: "2",
        name: "Brown bread",
        price: 2.99,
        category: "Loaves",
        imageUrl: "https://via.placeholder.com/150",
      ),
      MyProduct(
        id: "3",
        name: "Cheese sandwich",
        price: 1.99,
        category: "Sandwiches",
        imageUrl: "https://via.placeholder.com/150",
      ),
    ];
