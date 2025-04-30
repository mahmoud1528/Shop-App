import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/shared/theme/controller/cubit.dart';
import '../../../home/data/model/category_home_model.dart';

class BuildCategoryScreen extends StatelessWidget {
  final CategoryHomeDetailsDataModel model;

  const BuildCategoryScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color:
                  ThemeModeCubit.get(context).isDark
                      ? Colors.grey[300]
                      : Colors.deepOrange,
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: model.image,
                    height: 150.0,
                    width: 150.0,
                    fit: BoxFit.cover,
                    placeholder:
                        (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey,
                          highlightColor: Colors.white,
                          child: Container(color: Colors.black),
                        ),
                    errorWidget:
                        (context, url, error) => Icon(
                          Icons.error_outline,
                          color: Colors.grey[300],
                          size: 100.0,
                        ),
                  ),
                ),
                SizedBox(width: 20.0),
                Expanded(
                  child: Text(
                    model.name,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios_outlined),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
