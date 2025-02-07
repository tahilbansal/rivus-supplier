import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sivo_suppliers/common/app_style.dart';
import 'package:sivo_suppliers/common/reusable_text.dart';
import 'package:sivo_suppliers/common/shimmers/foodlist_shimmer.dart';
import 'package:sivo_suppliers/constants/constants.dart';
import 'package:sivo_suppliers/controllers/items_controller.dart';
import 'package:sivo_suppliers/hooks/fetchAllCategories.dart';
import 'package:sivo_suppliers/models/categories.dart';
import 'package:sivo_suppliers/views/home/widgets/back_ground_container.dart';
import 'package:get/get.dart';

class AllCategories extends HookWidget {
  const AllCategories({
    super.key,
    required this.next,
  });

  final Function() next;

  @override
  Widget build(BuildContext context) {
    final foodsController = Get.put(ItemsController());
    final hookResult = useFetchAllCategories();
    final categories = hookResult.data;
    final isLoading = hookResult.isLoading;

    return isLoading
        ? const itemsListShimmer()
        : BackGroundContainer(
            child: Container(
              padding: const EdgeInsets.only(
                  left: 12, top: 10, right: 12, bottom: 10),
              height: hieght * 0.7,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusableText(
                          text: "Pick Category",
                          style: appStyle(
                              kFontSizeBodyRegular, kGray, FontWeight.w600),
                        ),
                        ReusableText(
                          text:
                              "You are required to pick a category for your food item",
                          style: appStyle(
                              kFontSizeSubtext, kGray, FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: hieght * 0.7,
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          Categories category = categories[index];
                          return ListTile(
                            onTap: () {
                              foodsController.category = category.id;
                              next();
                            },
                            leading: CircleAvatar(
                              radius: 18,
                              backgroundColor: kGrayLight,
                              child: Image.network(
                                category.imageUrl,
                                fit: BoxFit.contain,
                              ),
                            ),
                            title: ReusableText(
                                text: category.title,
                                style: appStyle(kFontSizeBodySmall, kGray,
                                    FontWeight.normal)),
                            trailing: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: kGray,
                              size: 15,
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
  }
}
