import 'package:shop_app/features/shop/users/login/data/shop_login_model_entity.dart';

abstract class ShopLoginState{}

class LoginInitialState extends ShopLoginState{}

class ShopLoginChangePasswordVisibilityState extends ShopLoginState{}

class ShopLoginGetUserLoadingState extends ShopLoginState{}
class ShopLoginGetUserSuccessState extends ShopLoginState{
  final ShopLoginModel shopLoginModel;
  ShopLoginGetUserSuccessState(this.shopLoginModel);
}
class ShopLoginGetUserErrorState extends ShopLoginState{
  final String error;
  ShopLoginGetUserErrorState(this.error);
}