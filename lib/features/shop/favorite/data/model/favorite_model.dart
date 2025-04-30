class FavoriteModel {
  final bool status;
  final FavoriteDataModel? data;

  FavoriteModel({
    required this.status,
    required this.data,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
    status: json['status'],
    data: json['data'] != null ? FavoriteDataModel.fromJson(json['data']) : null,
  );
}

class FavoriteDataModel {
  final int currentPage;
  final List<FavoriteDetailsDataModel> data;

  FavoriteDataModel({
    required this.currentPage,
    required this.data,
  });

  factory FavoriteDataModel.fromJson(Map<String, dynamic> json) {
    List<FavoriteDetailsDataModel> data = [];
    if(json['data'] != null){
      json['data'].forEach((ele){
        data.add(FavoriteDetailsDataModel.fromJson(ele));
      });
    }
    return FavoriteDataModel(
      currentPage: json['current_page'],
      data:data,
    );
  }
}

class FavoriteDetailsDataModel {
  final int id;
  final FavoriteProductModel product;

  FavoriteDetailsDataModel({
    required this.id,
    required this.product,
  });

  factory FavoriteDetailsDataModel.fromJson(Map<String, dynamic> json) => FavoriteDetailsDataModel(
    id: json['id'],
    product: FavoriteProductModel.fromJson(json['product']),
  );
}

class FavoriteProductModel {
  final int id;
  final dynamic price;
  final dynamic oldPrice;
  final dynamic discount;
  final String image;
  final String name;
  final String description;


  FavoriteProductModel({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
  });

  factory FavoriteProductModel.fromJson(Map<String, dynamic> json) => FavoriteProductModel(
    id: json['id'],
    price: json['price'],
    oldPrice: json['old_price'],
    discount: json['discount'],
    image: json['image'],
    name: json['name'],
    description: json['description'],
  );
}