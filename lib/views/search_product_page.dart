import 'package:flutter/material.dart';
import 'package:marketplace/utils/helpers/small_text.dart';
import 'package:marketplace/utils/helpers/title_text.dart';
import '../utils/constants/app_colors_constants.dart';
import '../utils/constants/dimensions.dart';
import 'components/product_container.dart';

class SearchProductPage extends StatefulWidget {
  const SearchProductPage({super.key});

  @override
  State<SearchProductPage> createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  late final TextEditingController _searchController;
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                title: const TitleText(
                  text: 'Search',
                  size: 20,
                  weight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: Dimensions.height16,
              ),

              // SEARCH BAR:
              Container(
                alignment: Alignment.center,
                height: Dimensions.height58,
                margin:
                    const EdgeInsets.symmetric(horizontal: Dimensions.width16),
                padding:
                    const EdgeInsets.symmetric(horizontal: Dimensions.width20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius10),
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
                    Expanded(
                      child: TextField(
                        focusNode: focusNode,
                        textInputAction: TextInputAction.search,
                        textAlign: TextAlign.justify,
                        controller: _searchController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: Dimensions.height20,
              ),

              // POPULAR PRODUCTS:
              Container(
                margin: const EdgeInsets.only(left: Dimensions.width16),
                alignment: Alignment.centerLeft,
                child: const SmallText(
                  text: 'Popular Products',
                  weight: FontWeight.bold,
                  size: 16,
                ),
              ),
              // SEE ALL:
              Container(
                margin: const EdgeInsets.only(
                    right: Dimensions.width16, bottom: Dimensions.height10),
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: SmallText(
                    color: AppColors.greenColor,
                    text: 'See all',
                    weight: FontWeight.normal,
                    size: 14,
                  ),
                ),
              ),

              // GRID VIEW OF THE CURRENT POPULAR ITEMS:
              GridView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: Dimensions.width16),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.79,
                ),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return const ProductContainer();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
