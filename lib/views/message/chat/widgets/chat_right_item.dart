import 'package:rivus_supplier/common/entities/entities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rivus_supplier/common/routes/names.dart';
import 'package:rivus_supplier/constants/constants.dart';
import 'package:get/get.dart';
import 'package:rivus_supplier/views/order/invoice_page.dart';
import 'package:rivus_supplier/views/order/send_invoice.dart';

import '../../../../common/custom_btn.dart';
import '../../../order/active_page.dart';

//import '../../../../common/routes/names.dart';

Widget ChatRightItem(Msgcontent item) {
  return Container(
    padding: EdgeInsets.only(top: 10.w, left: 15.w, right: 15.w, bottom: 10.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 230.w, minHeight: 40.w),
            child: Container(
                margin: EdgeInsets.only(right: 10.w, top: 0.w),
                padding: EdgeInsets.only(
                  top: 10.w,
                  left: 10.w,
                  right: 10.w,
                ),
                decoration: BoxDecoration(
                    color: kSecondary.withOpacity(0.5),
                    borderRadius: BorderRadius.all(Radius.circular(10.w))),
                child: item.type == "text"
                    ? Text("${item.content}")
                    : item.type == "order"
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.content ?? "",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp.clamp(16, 20),
                                ),
                              ),
                              SizedBox(height: 8.w),
                              CustomButton(
                                onTap: () {
                                  // Navigate to the order details page
                                  //Get.to(() => OrderDetailsPage(orderId: item.orderId));
                                  Get.to(() => ActivePage(),
                                      arguments: item.orderId);
                                },
                                radius: 9,
                                color: kPrimary,
                                btnWidth: width * 0.95,
                                btnHieght: 34.h,
                                text: "VIEW ORDER DETAILS",
                              ),
                              SizedBox(height: 4.w),
                              CustomButton(
                                onTap: () {
                                  // Navigate to the order details page
                                  //Get.to(() => OrderDetailsPage(orderId: item.orderId));
                                  Get.to(() => SendInvoicePage(),
                                      arguments: item.orderId);
                                },
                                radius: 9,
                                color: kSecondary,
                                btnWidth: width * 0.95,
                                btnHieght: 34.h,
                                text: "SEND INVOICE",
                              ),
                              SizedBox(height: 4.w),
                            ],
                          )
                        : item.type == "invoice"
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${item.content}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.sp.clamp(16, 20),
                                    ),
                                  ),
                                  SizedBox(height: 8.w),
                                  CustomButton(
                                    onTap: () {
                                      // Navigate to invoice page or perform action
                                      Get.to(() => InvoicePage(),
                                          arguments: item.orderId);
                                    },
                                    radius: 9,
                                    color: kPrimary,
                                    btnWidth: width * 0.95,
                                    btnHieght: 34.h,
                                    text: "VIEW INVOICE",
                                  ),
                                  SizedBox(height: 4.w),
                                ],
                              )
                            : ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: 200.w,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.Photoimgview,
                                        parameters: {
                                          "url": item.content ?? ""
                                        });
                                  },
                                  child: CachedNetworkImage(
                                    imageUrl: "${item.content}",
                                  ),
                                ),
                              )))
      ],
    ),
  );
}
