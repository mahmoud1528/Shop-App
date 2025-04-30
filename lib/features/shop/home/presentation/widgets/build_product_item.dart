import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/features/shop/products_details/presentation/screens/product_details_screen.dart';

import '../../../../../core/layout/shop/controller/cubit.dart';
import '../../data/model/shop_home_model.dart';

class BuildProductItem extends StatelessWidget {
  final ProductsModel model;

  const BuildProductItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(id: model.id),
            ),
          );
        },
        child: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: model.image,
                      width: 150,
                      height: 150,
                      fit: BoxFit.fill,
                      placeholder:
                          (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey,
                            highlightColor: Colors.white,
                            child: Container(color: Colors.black),
                          ),
                      errorWidget:
                          (context, url, error) => Icon(
                            Icons.error_outline,
                            size: 50.0,
                            color: Colors.grey,
                          ),
                    ),
                  ),
                  if (model.discount != 0)
                    Container(
                      decoration: BoxDecoration(color: Colors.red),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Discount',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              model.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(height: 1.2),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  model.price.round().toString(),
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(color: Colors.blue),
                ),
                SizedBox(width: 10),
                if (model.discount != 0)
                  Text(
                    model.oldPrice.round().toString(),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.red,
                      decorationThickness: 2.0,
                    ),
                  ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    ShopLayoutCubit.get(context).changeFavorite(model.id);
                  },
                  icon: CircleAvatar(
                    radius: 14.0,
                    backgroundColor:
                        ShopLayoutCubit.get(context).favorites[model.id] == true
                            ? Colors.blue
                            : Colors.grey,
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 14.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
