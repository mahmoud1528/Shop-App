import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/layout/shop/controller/state.dart';
import 'package:shop_app/core/shared/const/constance.dart';
import 'package:shop_app/core/shared/network/remote/shop_helper.dart';
import 'package:shop_app/features/shop/home/data/model/category_home_model.dart';
import 'package:shop_app/features/shop/home/data/model/shop_home_model.dart';
import 'package:shop_app/features/shop/home/presentation/screens/home_screen.dart';
import 'package:shop_app/features/shop/search/data/model/search_model_entity.dart';

import '../../../../features/shop/products_details/model/product_details_model.dart';
import '../../../../features/shop/setting/data/model/profile_model.dart';
import '../../../../features/shop/category/presentation/screens/category_screen.dart';
import '../../../../features/shop/favorite/data/model/favorite_model.dart';
import '../../../../features/shop/favorite/presentation/screens/favorite_screen.dart';
import '../../../../features/shop/home/data/model/change_favorite_model.dart';
import '../../../../features/shop/setting/data/model/update_profile_model_entity.dart';
import '../../../../features/shop/setting/presentation/screens/setting_screen.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutState> {
  ShopLayoutCubit() : super(ShopInitialState());

  static ShopLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  int current = 0;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var searchController = TextEditingController();

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];
  List<String> titles = ['Home', 'Categories', 'Favorites', 'Settings'];
  List<Widget> screens = [
    HomeScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    SettingScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  void changeSmoothIndicator(int index) {
    current = index;
    emit(ShopChangeSmoothIndicatorState());
  }

  void changeLanguage() {
    if (language == 'ar') {
      language = 'en';
    } else {
      language = 'ar';
    }
    emit(ShopChangeLanguageState());
  }

  ShopHomeModel? shopHomeModel;
  Map<int, bool> favorites = {};

  void getHome() {
    emit(ShopGetHomeLoadingState());
    ShopHelper.getDate(url: homeEndPoint, token: token, lang: language)
        .then((value) {
          shopHomeModel = ShopHomeModel.fromJson(value.data);
          debugPrint('The User is : ${value.data}');
          shopHomeModel!.data!.products.forEach((ele) {
            favorites.addAll({ele.id: ele.inFavorites});
          });
          debugPrint('The Favorites Home is : $favorites');
          emit(ShopGetHomeSuccessState());
        })
        .catchError((error) {
          emit(ShopGetHomeErrorState(error.toString()));
          debugPrint(error.toString());
        });
  }

  CategoryHomeModel? categoryHomeModel;

  void getCategory() {
    emit(ShopGetCategoryHomeLoadingState());
    ShopHelper.getDate(url: categoryEndPoint, lang: language)
        .then((value) {
          categoryHomeModel = CategoryHomeModel.fromJson(value.data);
          debugPrint('The Category is : ${value.data}');
          emit(ShopGetCategoryHomeSuccessState());
        })
        .catchError((error) {
          emit(ShopGetCategoryHomeErrorState(error.toString()));
          debugPrint(error.toString());
        });
  }

  ChangeFavoriteModel? changeFavoriteModel;

  void changeFavorite(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoriteLoadingState());
    ShopHelper.postDate(
          url: changeFavoriteEndPoint,
          data: {'product_id': productId},
          token: token,
          lang: language,
        )
        .then((value) {
          changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
          if (!changeFavoriteModel!.status) {
            favorites[productId] = !favorites[productId]!;
          } else {
            getFavorite();
          }
          emit(ShopChangeFavoriteSuccessState(changeFavoriteModel!));
        })
        .catchError((error) {
          emit(ShopChangeFavoriteErrorState(error.toString()));
          debugPrint(error.toString());
        });
  }

  FavoriteModel? favoriteModel;

  void getFavorite() {
    emit(ShopGetFavoriteLoadingState());
    ShopHelper.getDate(url: favoriteEndPoint, token: token, lang: language)
        .then((value) {
          favoriteModel = FavoriteModel.fromJson(value.data);
          debugPrint('The Favorites is : ${value.data}');
          emit(ShopGetFavoriteSuccessState());
        })
        .catchError((error) {
          emit(ShopGetFavoriteErrorState(error.toString()));
          debugPrint(error.toString());
        });
  }

  ProfileModel? profileModel;

  void getProfile() {
    emit(ShopGetProfileLoadingState());
    ShopHelper.getDate(url: profileEndPoint, token: token, lang: language)
        .then((value) {
          profileModel = ProfileModel.fromJson(value.data);
          debugPrint('The Profile is : ${value.data}');
          emit(ShopGetProfileSuccessState());
        })
        .catchError((error) {
          emit(ShopGetProfileErrorState(error.toString()));
          debugPrint(error.toString());
        });
  }

  UpdateProfileModel? updateProfileModel;

  void updateProfile({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopUpdateProfileLoadingState());
    ShopHelper.putDate(
          url: updateProfileEndPoint,
          data: {'name': name, 'email': email, 'phone': phone},
          token: token,
          lang: language,
        )
        .then((value) {
          updateProfileModel = UpdateProfileModel.fromJson(value.data);
          getProfile();
          debugPrint('The Update Profile is : ${value.data}');
          emit(ShopUpdateProfileSuccessState(updateProfileModel!));
        })
        .catchError((error) {
          emit(ShopUpdateProfileErrorState(error.toString()));
          debugPrint(error.toString());
        });
  }

  ProductDetailsModel? productDetailsModel;

  void productsDetails(int id) {
    emit(ShopGetProductDetailsLoadingState());
    ShopHelper.getDate(
          url: productDetailsEndPoint(id),
          token: token,
          lang: language,
        )
        .then((value) {
          productDetailsModel = ProductDetailsModel.fromJson(value.data);
          debugPrint('The Product Details is : ${value.data}');
          emit(ShopGetProductDetailsSuccessState());
        })
        .catchError((error) {
          emit(ShopGetProductDetailsErrorState(error.toString()));
          debugPrint(error.toString());
        });
  }

  SearchModel? searchModel;

  void getSearch({required String text}) {
    emit(ShopGetSearchLoadingState());
    ShopHelper.postDate(
          url: searchEndPoint,
          data: {'text': text},
          token: token,
          lang: language,
        )
        .then((value) {
          searchModel = SearchModel.fromJson(value.data);
          debugPrint('The Search is : ${value.data}');
          emit(ShopGetSearchSuccessState());
        })
        .catchError((error) {
          emit(ShopGetSearchErrorState(error.toString()));
          debugPrint(error.toString());
        });
  }
}
