import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:rivus_supplier/common/app_style.dart';
import 'package:rivus_supplier/common/reusable_text.dart';
import 'package:rivus_supplier/constants/constants.dart';
import 'package:rivus_supplier/controllers/order_controller.dart';
import 'package:rivus_supplier/controllers/tab_controller.dart';
import 'package:rivus_supplier/views/home/catalog_page.dart';
import 'package:rivus_supplier/views/home/home_page.dart';
import 'package:rivus_supplier/views/order/no_selection.dart';
import 'package:rivus_supplier/views/profile/profile_page.dart';
import 'package:get/get.dart';

Widget activeOrder = const NoSelection();

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final controller = Get.put(OrdersController());

  List<Widget> pageList = <Widget>[
    const HomePage(),
    const CatalogPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final entryController = Get.put(MainScreenController());
    final controller = Get.put(OrdersController());

    return Obx(() => Scaffold(
          body: Stack(
            children: [
              pageList[entryController.tabIndex],
              Align(
                alignment: Alignment.bottomCenter,
                child: Theme(
                  data: Theme.of(context).copyWith(canvasColor: kPrimary),
                  child: BottomNavigationBar(
                      selectedFontSize: 12,
                      elevation: 0,
                      backgroundColor:  entryController.tabIndex == 1 ? Colors.transparent :kPrimary,
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      unselectedIconTheme:
                          const IconThemeData(color: Colors.black38),
                      items: [
                        BottomNavigationBarItem(
                          icon: entryController.tabIndex == 0
                              ? const Icon(
                                  AntDesign.appstore1,
                                  color: kSecondary,
                                  size: 24,
                                )
                              : const Icon(AntDesign.appstore1),
                          label: 'Home',
                        ),
                        BottomNavigationBarItem(
                          icon: entryController.tabIndex == 2
                              ? Badge(
                                  label: Obx(() => ReusableText(
                                      text: controller.count.toString(),
                                      style: appStyle(
                                          8, kLightWhite, FontWeight.normal))),
                                  child: const Icon(
                                    Ionicons.list_outline,
                                    size: 24,
                                  ))
                              : Badge(
                                  label: Obx(() => ReusableText(
                                      text: controller.count.toString(),
                                      style: appStyle(
                                          8, kLightWhite, FontWeight.normal))),
                                  child: const Icon(
                                    Ionicons.list_circle_sharp,
                                  ),
                                ),
                          label: 'Profile',
                        ),
                        BottomNavigationBarItem(
                          icon: entryController.tabIndex == 3
                              ? const Icon(
                                  FontAwesome.user_circle,
                                  size: 24,
                                )
                              : const Icon(
                                  FontAwesome.user_circle_o,
                                ),
                          label: 'Profile',
                        ),
                      ],
                      currentIndex: entryController.tabIndex,
                      unselectedItemColor: kGray,
                      selectedItemColor: kSecondary,
                      onTap: ((value) {
                        entryController.setTabIndex = value;
                      })),
                ),
              ),
            ],
          ),
        ));
  }
}
