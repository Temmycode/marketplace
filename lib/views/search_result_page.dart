import 'package:flutter/material.dart';
import 'package:marketplace/utils/constants/app_colors_constants.dart';
import 'package:marketplace/utils/constants/dimensions.dart';

import 'components/product_container.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // SEARCH BAR:
              Padding(
                padding: const EdgeInsets.only(
                  left: Dimensions.width16,
                  right: Dimensions.width16,
                  top: Dimensions.height16,
                  bottom: Dimensions.height20,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.height20,
                              vertical: Dimensions.height15),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius10),
                            color: AppColors.greyColor,
                          ),
                          child: Row(
                            children: [
                              ImageIcon(
                                const AssetImage('assets/icons/search.png'),
                                size: 20,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(
                                width: Dimensions.width16,
                              ),
                              Text(
                                'search',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: Colors.grey.shade300,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // GRIDVIEW:
              GridView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: Dimensions.width16),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.79,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const ProductContainer();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
