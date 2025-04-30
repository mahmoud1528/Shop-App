import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:shop_app/core/layout/shop/controller/cubit.dart';
import 'package:shop_app/core/layout/shop/controller/state.dart';
import 'package:shop_app/core/shared/network/local/cache_helper.dart';
import 'package:shop_app/core/shared/widgets/my_button.dart';
import 'package:shop_app/core/shared/widgets/shop_widgets/toast_state.dart';
import 'package:shop_app/features/shop/setting/data/model/update_profile_model_entity.dart';
import 'package:shop_app/features/shop/users/login/presentation/screens/login_screen.dart';

import '../../../../../core/shared/theme/controller/cubit.dart';
import '../../../../../core/shared/widgets/myformfield.dart';
import '../../data/model/profile_model.dart';

class BuildSettingScreen extends StatelessWidget {
  final ProfileDataModel model;

  const BuildSettingScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutState>(
      listener: (context, state) {
        if (state is ShopUpdateProfileSuccessState) {
          if (state.updateProfileModel.status) {
            showToast(
              msg: state.updateProfileModel.message,
              state: ToastStates.success,
            );
          } else {
            showToast(
              msg: state.updateProfileModel.message,
              state: ToastStates.error,
            );
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopLayoutCubit.get(context);
        cubit.nameController.text = model.name;
        cubit.emailController.text = model.email;
        cubit.phoneController.text = model.phone;
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                if (state is ShopUpdateProfileLoadingState)
                  LinearProgressIndicator(),
                if (state is ShopUpdateProfileLoadingState)
                  SizedBox(height: 20.0),

                SizedBox(
                  height: 250.0,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          width: double.infinity,
                          height: 200.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.red,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(model.image),
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 60.0,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(model.image),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.0),
                MyFormField(
                  controller: cubit.nameController,
                  type: TextInputType.text,
                  prefix: Icons.person,
                  text: 'name',
                  style: Theme.of(context).textTheme.titleMedium,
                  coloroftext: Theme.of(context).textTheme.titleMedium!.color,
                  coloroftextfield: Theme.of(context).scaffoldBackgroundColor,
                ),
                SizedBox(height: 20.0),
                MyFormField(
                  controller: cubit.emailController,
                  type: TextInputType.emailAddress,
                  prefix: Icons.email_outlined,
                  text: 'Email',
                  style: Theme.of(context).textTheme.titleMedium,
                  coloroftext: Theme.of(context).textTheme.titleMedium!.color,
                  coloroftextfield: Theme.of(context).scaffoldBackgroundColor,
                ),
                SizedBox(height: 20.0),
                MyFormField(
                  controller: cubit.phoneController,
                  type: TextInputType.phone,
                  prefix: Icons.phone,
                  text: 'Phone',
                  style: TextStyle(color: Theme.of(context).textTheme.titleMedium!.color),
                  coloroftext: Theme.of(context).textTheme.titleMedium!.color,
                  coloroftextfield: Theme.of(context).scaffoldBackgroundColor,
                ),
                SizedBox(height: 40.0),
                MyButton(
                  onPressed: () {
                    cubit.updateProfile(
                      name: cubit.nameController.text,
                      email: cubit.emailController.text,
                      phone: cubit.phoneController.text,
                    );
                  },
                  text: 'Update',
                  background:
                      ThemeModeCubit.get(context).isDark
                          ? Colors.blue
                          : Colors.deepOrange,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(color: Colors.white),
                ),
                SizedBox(height: 40.0),
                MyButton(
                  onPressed: () {
                    CacheHelper.removeData(key: 'token').then((value) {
                      if (context.mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      }
                    });
                  },
                  text: 'LogOut',
                  isUpperCase: false,
                  background:
                      ThemeModeCubit.get(context).isDark
                          ? Colors.blue
                          : Colors.deepOrange,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
