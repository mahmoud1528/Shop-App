import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/layout/shop/controller/cubit.dart';
import 'package:shop_app/core/layout/shop/controller/state.dart';
import 'package:shop_app/core/shared/widgets/myformfield.dart';
import '../widgets/build_search_item.dart';

class SearchScreen extends StatelessWidget {
  final bool isSearch;

  const SearchScreen({super.key, this.isSearch = true});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopLayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                cubit.searchController.clear();
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                MyFormField(
                  controller: cubit.searchController,
                  type: TextInputType.text,
                  prefix: Icons.search,
                  text: 'search',
                  onChanged: (value) {
                    cubit.getSearch(text: value);
                  },
                ),
                Expanded(
                  child: ConditionalBuilder(
                    condition: cubit.searchModel != null,
                    builder: (context) =>
                        ListView.separated(itemBuilder: (context, index) =>
                            BuildSearchItem(
                              model: cubit.searchModel!.data!.data[index],
                            ),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 10),
                          itemCount:
                          cubit.searchModel!.data!.data.length,),
                    fallback:
                        (context) =>
                    isSearch
                        ? Container()
                        : Center(child: CircularProgressIndicator()),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}