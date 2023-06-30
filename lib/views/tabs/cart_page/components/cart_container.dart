import 'package:flutter/material.dart';
import 'package:marketplace/utils/constants/dimensions.dart';
import 'package:marketplace/utils/helpers/small_text.dart';
import 'package:marketplace/utils/helpers/title_text.dart';

class CartContainer extends StatelessWidget {
  final String image;
  final String name;
  final String description;
  final double price;

  const CartContainer({
    super.key,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: Dimensions.height10),
      height: Dimensions.height150,
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius10),
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                width: Dimensions.width10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: Dimensions.height15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Dimensions.height200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleText(
                            text: name,
                            size: Dimensions.height16,
                          ),
                          const SizedBox(
                            height: Dimensions.height5,
                          ),
                          TitleText(
                            text: description,
                            size: Dimensions.height16,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmallText(
                          text: "Size: M",
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(
                          height: Dimensions.height5,
                        ),
                        SmallText(
                          text: "Color: Black",
                          color: Colors.grey.shade400,
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
