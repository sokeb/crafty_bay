import 'package:crafty_bay_app/presentation/state_holder/categories_list_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/new_product_list_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/popular_product_list_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/special_product_list_controller.dart';
import 'package:crafty_bay_app/presentation/ui/screen/remark_product_list_screen.dart';
import 'package:crafty_bay_app/presentation/ui/screen/profile_screen.dart';
import 'package:crafty_bay_app/presentation/ui/utils/assets_path.dart';
import 'package:crafty_bay_app/presentation/ui/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../state_holder/bottom_navbar_controller.dart';
import '../widgets/appbar_icon_button.dart';
import '../widgets/categories_card.dart';
import '../widgets/home_screen_widget/home_banner_slider2.dart';
import '../widgets/home_screen_widget/horizontal_product_list_view.dart';
import '../widgets/home_screen_widget/search_field.dart';
import '../widgets/home_screen_widget/section_header.dart';
import 'package:get/get.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                const SizedBox(height: 8),
                const SearchField(),
                const SizedBox(height: 8),
                const SizedBox(
                  height: 150,
                  child: HomeBannerSlider2(),
                ),
                const SizedBox(height: 0),
                SectionHeader(
                    onTap: () {
                      Get.find<BottomNavbarController>().selectCategory();
                    },
                    title: 'All Categories'),
                _buildCategoriesListView(),
                const SizedBox(height: 10),
                _buildPopularProductSection(),
                const SizedBox(height: 10),
                _buildSpecialProductSection(),
                const SizedBox(height: 10),
                _buildNewProductSection(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNewProductSection() {
    return GetBuilder<NewProductListController>(
        builder: (newProductListController) {
      return Column(
        children: [
          SectionHeader(
              onTap: () {
                Get.to(() => ProductListByRemarkScreen(
                    productList: newProductListController.newProductList,
                    name: "New"));
              },
              title: 'New'),
          Visibility(
            visible: !newProductListController.inProgress,
            replacement: const LoadingIndicator(),
            child: HorizontalProductListView(
              productList: newProductListController.newProductList,
            ),
          )
        ],
      );
    });
  }

  Widget _buildSpecialProductSection() {
    return GetBuilder<SpecialProductListController>(
        builder: (specialProductListController) {
      return Column(
        children: [
          SectionHeader(
              onTap: () {
                Get.to(() => ProductListByRemarkScreen(
                    productList:
                        specialProductListController.specialProductList,
                    name: "Special"));
              },
              title: 'Special'),
          Visibility(
            visible: !specialProductListController.inProgress,
            replacement: const LoadingIndicator(),
            child: HorizontalProductListView(
              productList: specialProductListController.specialProductList,
            ),
          )
        ],
      );
    });
  }

  Widget _buildPopularProductSection() {
    return GetBuilder<PopularProductListController>(
        builder: (popularProductListController) {
      return Column(
        children: [
          SectionHeader(
              onTap: () {
                Get.to(() => ProductListByRemarkScreen(
                    productList:
                        popularProductListController.popularProductList,
                    name: "Popular"));
              },
              title: 'Popular'),
          Visibility(
              child: HorizontalProductListView(
                  productList: popularProductListController.popularProductList))
        ],
      );
    });
  }

  Widget _buildCategoriesListView() {
    return SizedBox(
      height: 109,
      child: GetBuilder<CategoriesListController>(
          builder: (categoriesListController) {
        return Visibility(
          visible: !categoriesListController.inProgress,
          replacement: const LoadingIndicator(),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return CategoriesCard(
                categories: categoriesListController.categories[index],
              );
            },
            separatorBuilder: (_, __) => const SizedBox(width: 15),
            itemCount: categoriesListController.categories.length,
          ),
        );
      }),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: SvgPicture.asset(AssetsPath.appbarLogo),
      actions: [
        AppbarIconButtonWidget(onTap: () {
          Get.to(()=> const ProfileInfoScreen());
        }, iconData: Icons.person_2_outlined),
        const SizedBox(width: 8),
        AppbarIconButtonWidget(onTap: () {}, iconData: Icons.call_outlined),
        const SizedBox(width: 8),
        AppbarIconButtonWidget(
            onTap: () {}, iconData: Icons.notifications_active_outlined),
        const SizedBox(width: 8),
      ],
    );
  }
}
