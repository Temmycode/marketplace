import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/state/providers/is_logged_in_provider.dart';
import 'package:marketplace/state/providers/user_id_shared_preference_provider.dart';
import 'package:marketplace/utils/constants/app_colors_constants.dart';
import 'package:marketplace/utils/constants/dimensions.dart';
import 'package:marketplace/utils/constants/enums/extensions/capitalize_enum_extension.dart';
import 'package:marketplace/utils/constants/enums/section_enums.dart';
import 'package:marketplace/views/search_product_page.dart';
import 'package:marketplace/views/tabs/discover_page/components/tab_views/tab_views.dart';
import 'components/app_bar.dart';
import 'components/drawer.dart';

class DiscoverPage extends ConsumerStatefulWidget {
  const DiscoverPage({super.key});

  @override
  ConsumerState<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends ConsumerState<DiscoverPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final PageController controller;
  int currentIndex = 0;

  @override
  void initState() {
    _tabController = TabController(
      length: ItemSection.values.length,
      vsync: this,
    );
    controller = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // PROVIDER TO CHECK IF THE USER IS SIGNED IN:
    final isLoggedIn = ref.watch(isLoggedInProvider);
    // USER ID FROM THE USER ID PROVIDER:
    final userId = ref.watch(userIdSharedPreferenceProvider);
    // PROVIDER OF THE CURRENT USER DETAILS:
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // APP BAR:
              const DiscoverAppBar(),
              const SizedBox(
                height: Dimensions.height10,
              ),
              // SEARCH BAR:
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: Dimensions.width16),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SearchProductPage(),
                            ),
                          );
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
                    const SizedBox(
                      width: Dimensions.width10,
                    ),
                    Builder(builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          if (Scaffold.of(context).isDrawerOpen) {
                            return;
                          }
                          Scaffold.of(context).openDrawer();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.width15,
                            vertical: Dimensions.height15,
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius10),
                            color: AppColors.greenColor,
                          ),
                          child: const ImageIcon(
                            AssetImage('assets/icons/menu.png'),
                            size: 20,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(
                height: Dimensions.height12,
              ),

              // FILTER TABBAR SECTION:
              TabBar(
                padding:
                    const EdgeInsets.symmetric(horizontal: Dimensions.width16),
                controller: _tabController,
                isScrollable: true,
                labelStyle: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w600),
                unselectedLabelStyle: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.normal),
                unselectedLabelColor: Colors.grey.shade400,
                labelColor: Colors.white,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius10),
                  color: AppColors.greenColor,
                ),
                splashBorderRadius: BorderRadius.circular(Dimensions.radius10),
                tabs: ItemSection.values
                    .map(
                      (item) => Tab(
                        text: item.captializeValue(item),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(
                height: Dimensions.height10,
              ),

              // TAB BAR VIEWS FOR THE ITEM SECTIONS:
              SizedBox(
                width: double.maxFinite,
                height: Dimensions.height1000,
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: ItemSection.values
                      .map(
                        (item) => TabsView(
                          itemSection: item.captializeValue(item.name),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: DrawerContainer(
        isLoggedIn: isLoggedIn,
      ),
    );
  }
}

List imageUrl = [
  'https://images.unsplash.com/photo-1621330396173-e41b1cafd17f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
  'https://images.unsplash.com/photo-1486401899868-0e435ed85128?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80',
  'https://images.unsplash.com/photo-1542291026-7eec264c27ff?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80',
];

List productName = [
  'Redmi Phones',
  'Sony Playstation 4',
  'Adidas shoes',
];

List price = [
  120,
  800,
  150,
];

class Electronics extends StatelessWidget {
  const Electronics({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('electronics');
  }
}

class Clothes extends StatelessWidget {
  const Clothes({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('clothes');
  }
}

class Realty extends StatelessWidget {
  const Realty({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Realty');
  }
}
