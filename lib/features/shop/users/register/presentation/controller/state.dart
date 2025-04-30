import '../../data/shop_Register_model_entity.dart';

abstract class ShopRegisterState{}

class RegisterInitialState extends ShopRegisterState{}

class ShopRegisterChangePasswordVisibilityState extends ShopRegisterState{}

class ShopRegisterGetUserLoadingState extends ShopRegisterState{}
class ShopRegisterGetUserSuccessState extends ShopRegisterState{
  final ShopRegisterModel? shopRegisterModel;
  ShopRegisterGetUserSuccessState(this.shopRegisterModel);
}
class ShopRegisterGetUserErrorState extends ShopRegisterState{
  final String error;
  ShopRegisterGetUserErrorState(this.error);
}