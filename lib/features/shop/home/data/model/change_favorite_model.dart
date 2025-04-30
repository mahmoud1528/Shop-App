class ChangeFavoriteModel {
  final bool status;
  final String message;
  final ChangeFavoriteDataModel? data;

  ChangeFavoriteModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ChangeFavoriteModel.fromJson(Map<String, dynamic> json) {
    return ChangeFavoriteModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? ChangeFavoriteDataModel.fromJson(json['data']) : null,
    );
  }
}

class ChangeFavoriteDataModel {
  final int id;
  final ChangeFavoriteProductsDataModel product;

  ChangeFavoriteDataModel({required this.id, required this.product});

  factory ChangeFavoriteDataModel.fromJson(Map<String, dynamic> json) {
    return ChangeFavoriteDataModel(
      id: json['id'],
      product: ChangeFavoriteProductsDataModel.fromJson(json['product']),
    );
  }
}

class ChangeFavoriteProductsDataModel {
  final int id;
  final int price;
  final int oldPrice;
  final int discount;
  final String image;

  ChangeFavoriteProductsDataModel({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
  });

  factory ChangeFavoriteProductsDataModel.fromJson(Map<String, dynamic> json) =>
      ChangeFavoriteProductsDataModel(
        id: json['id'],
        price: json['price'],
        oldPrice: json['old_price'],
        discount: json['discount'],
        image: json['image'],
      );
}
