import 'package:shop_app/features/shop/setting/data/model/update_profile_model_entity.dart';

import '../../../../features/shop/home/data/model/change_favorite_model.dart';

abstract class ShopLayoutState {}

class ShopInitialState extends ShopLayoutState {}

class ShopChangeBottomNavState extends ShopLayoutState {}

class ShopGetHomeLoadingState extends ShopLayoutState{}
class ShopGetHomeSuccessState extends ShopLayoutState{}
class ShopGetHomeErrorState extends ShopLayoutState{
  final String error;
  ShopGetHomeErrorState(this.error);
}

class ShopGetCategoryHomeLoadingState extends ShopLayoutState{}
class ShopGetCategoryHomeSuccessState extends ShopLayoutState{}
class ShopGetCategoryHomeErrorState extends ShopLayoutState{
  final String error;
  ShopGetCategoryHomeErrorState(this.error);
}

class ShopChangeFavoriteLoadingState extends ShopLayoutState{}
class ShopChangeFavoriteSuccessState extends ShopLayoutState{
  final ChangeFavoriteModel changeFavoriteModel;
  ShopChangeFavoriteSuccessState(this.changeFavoriteModel);
}
class ShopChangeFavoriteErrorState extends ShopLayoutState{
  final String error;
  ShopChangeFavoriteErrorState(this.error);
}

class ShopGetFavoriteLoadingState extends ShopLayoutState{}
class ShopGetFavoriteSuccessState extends ShopLayoutState{}
class ShopGetFavoriteErrorState extends ShopLayoutState{
  final String error;
  ShopGetFavoriteErrorState(this.error);
}

class ShopGetProfileLoadingState extends ShopLayoutState{}
class ShopGetProfileSuccessState extends ShopLayoutState{}
class ShopGetProfileErrorState extends ShopLayoutState{
  final String error;
  ShopGetProfileErrorState(this.error);
}


class ShopUpdateProfileLoadingState extends ShopLayoutState{}
class ShopUpdateProfileSuccessState extends ShopLayoutState{
  final UpdateProfileModel updateProfileModel;
  ShopUpdateProfileSuccessState(this.updateProfileModel);
}
class ShopUpdateProfileErrorState extends ShopLayoutState{
  final String error;
  ShopUpdateProfileErrorState(this.error);
}


class ShopGetProductDetailsLoadingState extends ShopLayoutState{}
class ShopGetProductDetailsSuccessState extends ShopLayoutState{}
class ShopGetProductDetailsErrorState extends ShopLayoutState{
  final String error;
  ShopGetProductDetailsErrorState(this.error);
}

class ShopChangeSmoothIndicatorState extends ShopLayoutState{}

class ShopChangeLanguageState extends ShopLayoutState{}
