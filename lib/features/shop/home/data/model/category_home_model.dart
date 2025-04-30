class CategoryHomeModel {
  final bool status;
  final CategoryHomeDataModel  data;

  CategoryHomeModel({
    required this.status,
    required this.data,
  });

  factory CategoryHomeModel.fromJson(Map<String,dynamic>json){

    return CategoryHomeModel(
      status: json['status'],
      data: CategoryHomeDataModel.fromJson(json['data']),
    );
  }

}

class CategoryHomeDataModel {
  final int currentPage;
  final List<CategoryHomeDetailsDataModel>data;

  CategoryHomeDataModel({
    required this.currentPage,
    required this.data,
  });
  factory CategoryHomeDataModel.fromJson(Map<String,dynamic>json){
    List<CategoryHomeDetailsDataModel>data = [];
    if(json['data'] != null){
      json['data'].forEach((ele) {
        data.add(CategoryHomeDetailsDataModel.fromJson(ele));
      });
    }
    return CategoryHomeDataModel(
      currentPage: json['current_page'],
      data: data,
    );
  }
}

class CategoryHomeDetailsDataModel {
  final int id;
  final String name;
  final String image;
  CategoryHomeDetailsDataModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory CategoryHomeDetailsDataModel.fromJson(Map<String,dynamic>json)=>
      CategoryHomeDetailsDataModel(
        id: json['id'],
        name: json['name'],
        image: json['image'],
      );
}
