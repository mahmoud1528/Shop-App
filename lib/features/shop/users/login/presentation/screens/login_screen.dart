import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/layout/shop/shop_layout.dart';
import 'package:shop_app/core/shared/network/local/cache_helper.dart';
import 'package:shop_app/core/shared/widgets/my_button.dart';
import 'package:shop_app/core/shared/widgets/my_txt_button.dart';
import 'package:shop_app/core/shared/widgets/myformfield.dart';
import 'package:shop_app/core/shared/widgets/shop_widgets/toast_state.dart';
import 'package:shop_app/features/shop/users/login/presentation/controller/cubit.dart';
import 'package:shop_app/features/shop/users/login/presentation/controller/state.dart';
import 'package:shop_app/main.dart';

import '../../../../../../core/shared/const/constance.dart';
import '../../../../../../core/shared/theme/controller/cubit.dart';
import '../../../register/presentation/screens/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
        listener: (context, state) {
          if (state is ShopLoginGetUserSuccessState) {
            if (state.shopLoginModel.status) {
              showToast(
                msg: state.shopLoginModel.message,
                state: ToastStates.success,
              );
              CacheHelper.setData(
                key: 'token',
                value: state.shopLoginModel.data!.token,
              ).then((value) {
                if (context.mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => MyApp(
                            isDark: ThemeModeCubit.get(context).isDark,
                            startWidget: ShopLayout(),
                          ),
                    ),
                  );
                }
                token = state.shopLoginModel.data!.token;
              });
            } else {
              showToast(
                msg: state.shopLoginModel.message,
                state: ToastStates.error,
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = ShopLoginCubit.get(context);
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
                          'Login',
                          style: Theme.of(
                            context,
                          ).textTheme.headlineLarge!.copyWith(fontSize: 40.0),
                        ),
                        Text(
                          'Login to browse our hot offers',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
                        ),
                        SizedBox(height: 40.0),
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
                        SizedBox(height: 40.0),
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
                          condition: state is! ShopLoginGetUserLoadingState,
                          builder:
                              (context) => MyButton(
                                onPressed: () {
                                  if (cubit.formKey.currentState!.validate()) {
                                    cubit.getUser(
                                      email: cubit.emailController.text,
                                      password: cubit.passwordController.text,
                                    );
                                  }
                                },
                                text: 'Login',
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
                              'Don\'t have an account?!',
                              style: TextStyle(
                                fontSize: 16,
                                color:
                                    ThemeModeCubit.get(context).isDark
                                        ? Colors.black
                                        : Colors.white,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            MyTxtButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterScreen(),
                                  ),
                                );
                              },
                              text: 'Register',
                              isUpperCase: false,
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(color: Colors.blue),
                            ),
                            SizedBox(height: 30.0,)
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
