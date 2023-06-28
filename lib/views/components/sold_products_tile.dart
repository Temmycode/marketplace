import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/state/providers/general_providers/network_connection_provider.dart';
import 'package:marketplace/utils/constants/app_colors_constants.dart';
import 'package:marketplace/utils/constants/dimensions.dart';
import 'package:marketplace/utils/helpers/small_text.dart';
import 'package:marketplace/utils/helpers/title_text.dart';

class SoldProductsTile extends ConsumerWidget {
  final String name;
  final String thumbnail;
  final double price;
  final String category;
  final int stars;
  final double likePercentage;
  final int noSold;
  const SoldProductsTile({
    super.key,
    required this.name,
    required this.thumbnail,
    required this.price,
    required this.category,
    required this.stars,
    required this.likePercentage,
    required this.noSold,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final internetConnection = ref.watch(networkConnectionProvider);
    return Container(
      height: 155,
      margin: const EdgeInsets.only(bottom: Dimensions.height20),
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.width10,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(5, 3),
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Container(
              height: Dimensions.height60,
              width: Dimensions.height60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius10),
                image: internetConnection.when(
                  data: (theresNetwork) {
                    if (theresNetwork) {
                      return DecorationImage(
                        image: NetworkImage(thumbnail),
                        fit: BoxFit.cover,
                      );
                    } else {
                      return null;
                    }
                  },
                  error: (error, stk) {
                    throw Exception(error);
                  },
                  loading: () {
                    return;
                  },
                ),
              ),
            ),
            title: SmallText(
              text: name,
              weight: FontWeight.bold,
              color: AppColors.greenColor,
            ),
            subtitle: TitleText(
              text: '\$${price.toString()}',
              color: AppColors.blackColor,
              weight: FontWeight.normal,
            ),
            trailing: SmallText(text: '$likePercentage% liked'),
          ),
          const SizedBox(
            height: Dimensions.height5,
          ),
          Container(
            margin: const EdgeInsets.only(left: Dimensions.width16),
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.width6,
              vertical: Dimensions.height5,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius10),
              color: Colors.grey.shade300,
            ),
            child: SmallText(
              text: category,
              size: 14,
            ),
          ),
          const SizedBox(
            height: Dimensions.height5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.width16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.orangeAccent,
                ),
                SmallText(
                  text: 'No sold: $noSold',
                  weight: FontWeight.w500,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
