class ProductDetailsModel {
  final bool status;
  final ProductDetailsModelData? data;

  ProductDetailsModel({required this.status, required this.data});

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      status: json['status'],
      data:
          json['data'] != null
              ? ProductDetailsModelData.fromJson(json['data'])
              : null,
    );
  }
}

class ProductDetailsModelData {
  final int id;
  final int price;
  final int oldPrice;
  final int discount;
  final String image;
  final String name;
  final String description;
  final bool inFavorites;
  final bool inCart;
  final List<String> images;

  ProductDetailsModelData({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
    required this.inFavorites,
    required this.inCart,
    required this.images,
  });

  factory ProductDetailsModelData.fromJson(Map<String, dynamic> json) {
   return ProductDetailsModelData(
     id: json['id'],
     price: json['price'],
     oldPrice: json['old_price'],
     discount: json['discount'],
     image: json['image'],
     name: json['name'],
     description: json['description'],
     inFavorites: json['in_favorites'],
     inCart: json['in_cart'],
     images: List<String>.from(json['images'].map((e) => e)),
   );
  }

}
