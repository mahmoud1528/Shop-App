import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/shared/network/local/cache_helper.dart';
import 'package:shop_app/core/shared/widgets/my_button.dart';
import 'package:shop_app/core/shared/widgets/my_txt_button.dart';
import 'package:shop_app/core/shared/widgets/myformfield.dart';
import 'package:shop_app/core/shared/widgets/shop_widgets/toast_state.dart';
import 'package:shop_app/features/shop/users/login/presentation/screens/login_screen.dart';
import '../../../../../../core/shared/const/constance.dart';
import '../../../../../../core/shared/theme/controller/cubit.dart';
import '../controller/cubit.dart';
import '../controller/state.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterState>(
        listener: (context, state) {
          if (state is ShopRegisterGetUserSuccessState) {
            if (state.shopRegisterModel!.status) {
              showToast(
                msg: state.shopRegisterModel!.message,
                state: ToastStates.success,
              );
              CacheHelper.setData(
                key: 'token',
                value: state.shopRegisterModel!.data!.token,
              ).then((value){
                if(context.mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                }
              });
              token = state.shopRegisterModel!.data!.token;
            } else {
              showToast(
                msg: state.shopRegisterModel!.message,
                state: ToastStates.error,
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = ShopRegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(automaticallyImplyLeading: false),
            body: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Form(
                  key: cubit.formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: Theme.of(
                            context,
                          ).textTheme.headlineLarge!.copyWith(fontSize: 40.0),
                        ),
                        Text(
                          'Register to browse our hot offers',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
                        ),
                        SizedBox(height: 40.0),
                        MyFormField(
                          controller: cubit.nameController,
                          type: TextInputType.text,
                          prefix: Icons.person,
                          text: 'Name',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
                        MyFormField(
                          controller: cubit.emailController,
                          type: TextInputType.emailAddress,
                          prefix: Icons.email_outlined,
                          text: 'Email Address',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your email address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
                        MyFormField(
                          controller: cubit.phoneController,
                          type: TextInputType.phone,
                          prefix: Icons.phone,
                          text: 'Phone',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your Phone';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
                        MyFormField(
                          controller: cubit.passwordController,
                          type: TextInputType.visiblePassword,
                          prefix: Icons.lock_outlined,
                          text: 'Password',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your Password';
                            }
                            return null;
                          },
                          isPassword: cubit.isPassword,
                          suffix: cubit.suffix,
                          onSuffixPressed: cubit.changePasswordVisibility,
                        ),
                        SizedBox(height: 30.0),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterGetUserLoadingState,
                          builder:
                              (context) => MyButton(
                                onPressed: () {
                                  if (cubit.formKey.currentState!.validate()) {
                                    cubit.userRegister(
                                      name: cubit.nameController.text,
                                      email: cubit.emailController.text,
                                      phone: cubit.phoneController.text,
                                      password: cubit.passwordController.text,
                                    );
                                  }
                                },
                                text: 'Register',
                                style: Theme.of(context).textTheme.titleLarge!
                                    .copyWith(color: Colors.white),
                              ),
                          fallback:
                              (context) =>
                                  Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?!',
                              style: TextStyle(fontSize: 16,color: ThemeModeCubit.get(context).isDark ? Colors.black : Colors.white),

                            ),
                            SizedBox(width: 5.0),
                            MyTxtButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              text: 'Login',
                              isUpperCase: false,
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(color: Colors.blue),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
