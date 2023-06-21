import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/utils/constants/app_colors_constants.dart';
import 'package:marketplace/utils/constants/dimensions.dart';
import 'package:marketplace/utils/helpers/small_text.dart';
import 'package:marketplace/utils/helpers/title_text.dart';
import 'package:marketplace/views/tabs/profile_page/tabs/personal_tab.dart';

class ProfilePage extends ConsumerStatefulWidget {
  final String username;
  final String email;
  final String bio;
  const ProfilePage({
    super.key,
    required this.username,
    required this.email,
    required this.bio,
  });

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        automaticallyImplyLeading: true,
        // leading: const Icon(Icons.arrow_back_ios),
        title: const TitleText(
          text: 'Profile',
          size: Dimensions.height30,
        ),
        centerTitle: false,
        bottom: TabBar(
          indicatorColor: AppColors.greenColor,
          controller: _tabController,
          tabs: const [
            Tab(
              child: SmallText(
                text: "PERSONAL",
                size: 14,
              ),
            ),
            Tab(
              child: SmallText(
                text: "SOLD",
                size: 14,
              ),
            ),
            Tab(
              child: SmallText(
                text: "ORDERS",
                size: 14,
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          PersonalTab(
              username: widget.username, email: widget.email, bio: widget.bio),
          const Text('Sold items'),
          const Text('Ordered items'),
        ],
      ),
    );
  }
}
