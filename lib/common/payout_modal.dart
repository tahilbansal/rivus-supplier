import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sivo_suppliers/common/app_style.dart';
import 'package:sivo_suppliers/common/custom_btn.dart';
import 'package:sivo_suppliers/common/reusable_text.dart';
import 'package:sivo_suppliers/constants/constants.dart';

Future<dynamic> showPayOutSheet(BuildContext context) {
  return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      showDragHandle: true,
      barrierColor: kGrayLight.withOpacity(0.2),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 700.h,
          width: width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/images/restaurant_bk.png",
                  ),
                  fit: BoxFit.fill),
              color: kOffWhite,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12))),
          child: Padding(
            padding: EdgeInsets.all(8.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                ReusableText(
                    text: "Add Default Address",
                    style: appStyle(20, kPrimary, FontWeight.bold)),
                SizedBox(
                  height: 300.h,
                ),
                SizedBox(
                  height: 15.h,
                ),
                CustomButton(
                    onTap: () {},
                    btnHieght: 40.h,
                    text: "Proceed To Address Page"),
              ],
            ),
          ),
        );
      });
}
