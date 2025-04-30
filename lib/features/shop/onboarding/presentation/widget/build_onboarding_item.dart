import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/onboardong_model.dart';

class BuildOnboardingItem extends StatelessWidget {
  final OnBoardingModel model;

  const BuildOnboardingItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(image: AssetImage(model.image)),
        SizedBox(height: 40),
        Text(model.title, style: Theme.of(context).textTheme.titleLarge),
        SizedBox(height: 20),
        Text(model.body, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
