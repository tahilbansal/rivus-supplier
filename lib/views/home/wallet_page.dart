import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:rivus_supplier/common/app_style.dart';
import 'package:rivus_supplier/common/common_appbar.dart';
import 'package:rivus_supplier/common/custom_btn.dart';
import 'package:rivus_supplier/common/reusable_text.dart';
import 'package:rivus_supplier/common/shimmers/foodlist_shimmer.dart';
import 'package:rivus_supplier/common/statistics.dart';
import 'package:rivus_supplier/constants/constants.dart';
import 'package:rivus_supplier/controllers/login_controller.dart';
import 'package:rivus_supplier/controllers/payout_controller.dart';
import 'package:rivus_supplier/hooks/fetch_supplier.dart';
import 'package:rivus_supplier/models/payout_request.dart';
import 'package:rivus_supplier/models/supplier_response.dart';
import 'package:rivus_supplier/views/auth/widgets/email_textfield.dart';
import 'package:rivus_supplier/views/home/widgets/back_ground_container.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WalletPage extends StatefulHookWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final box = GetStorage();
  final TextEditingController bank = TextEditingController();
  final TextEditingController account = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final payoutController = Get.put(PayoutCotroller());
    String id = box.read('supplierId');
    SupplierResponse? supplier = controller.getSupplierData(id);

    final data = fetchSupplier(id);
    final ordersTotal = data.ordersTotal;
    final cancelledOrders = data.cancelledOrders;
    final processingOrders = data.processingOrders;
    final payout = data.payout;
    final revenueTotal = data.revenueTotal;
    final isLoading = data.isLoading;
    final error = data.error;
    final refetch = data.refetch;

    if (isLoading) {
      return Scaffold(
        appBar: CommonAppBar(titleText: "Wallet Page"),
        body: const BackGroundContainer(
            color: kLightWhite, child: FoodsListShimmer()),
      );
    }

    return Scaffold(
      backgroundColor: kLightWhite,
      appBar: CommonAppBar(titleText: "Wallet Page"),
      body: BackGroundContainer(
        color: kWhite,
        child: ListView(

          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(
                              text: supplier!.title,
                              style: appStyle(
                                  kFontSizeBodyLarge, kGray, FontWeight.w600)),
                          CircleAvatar(
                            radius: 15.r,
                            backgroundColor: kGray,
                            backgroundImage: NetworkImage(supplier.logoUrl),
                          ),
                        ]),
                  ),
                  const Divider(),
                  Statistics(
                    ordersTotal: ordersTotal,
                    cancelledOrders: cancelledOrders,
                    processingOrders: processingOrders,
                    revenueTotal: revenueTotal,
                  ),
                  const Divider(),
                  payout.isEmpty
                      ? const SizedBox.shrink()
                      : Column(
                    children: [
                      RowText(
                        first: "Latest Request",
                        second: payout[0]
                            .createdAt
                            .toString()
                            .substring(0, 10),
                        bold: true,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      RowText(
                        first: payout[0].id,
                        second:
                        "\$ ${payout[0].amount.toStringAsFixed(2)}",
                        bold: false,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomButton(
                    radius: 12,
                    btnWidth: width,
                    text: "Request Payout",
                    onTap: () {
                      controller.setRequest = !controller.payout;
                    },
                    color: kSecondary,
                  ),
                  Obx(
                        () => controller.payout
                        ? Column(
                      children: [
                        SizedBox(
                          height: 15.h,
                        ),
                        EmailTextField(
                          controller: bank,
                          hintText: "Bank Name",
                          prefixIcon: Icon(
                            AntDesign.bank,
                            color: Theme.of(context).dividerColor,
                            size: 20.h,
                          ),
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        EmailTextField(
                          controller: name,
                          hintText: "Account Name",
                          prefixIcon: Icon(
                            AntDesign.user,
                            color: Theme.of(context).dividerColor,
                            size: 20.h,
                          ),
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        EmailTextField(
                          controller: account,
                          hintText: "Account Number",
                          prefixIcon: Icon(
                            AntDesign.calculator,
                            color: Theme.of(context).dividerColor,
                            size: 20.h,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        EmailTextField(
                          controller: amount,
                          hintText: "Amount",
                          prefixIcon: Icon(
                            AntDesign.pay_circle_o1,
                            color: Theme.of(context).dividerColor,
                            size: 20.h,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomButton(
                          text: "Submit Payout",
                          color: kPrimary,
                          radius: 0,
                          onTap: () {
                            PayoutRequest payout = PayoutRequest(
                                supplier: id,
                                amount: amount.text,
                                accountNumber: account.text,
                                accountName: name.text,
                                accountBank: bank.text,
                                method: "bank_transfer");

                            String data = payoutRequestToJson(payout);

                            double amountDouble =
                            double.parse(amount.text);

                            if (amountDouble >
                                (revenueTotal - revenueTotal * 0.1)) {
                              // insufficient amount
                              insufficientFunds(context);
                            } else {
                              payoutController.payout(data, refetch);
                              controller.setRequest = !controller.payout;
                              amount.text = '';
                              name.text = '';
                              bank.text = '';
                              account.text = '';
                            }
                          },
                        )
                      ],
                    )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<dynamic> insufficientFunds(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
      title: ReusableText(
          text: 'Withdrawal Denied',
          style: appStyle(kFontSizeBodyRegular, kDark, FontWeight.bold)),
      contentPadding: const EdgeInsets.all(20.0),
      content: Text(
          'We regret to inform you that your withdrawal request cannot be processed at this time due to an insufficient account balance. To ensure a smooth transaction process, we kindly ask you to review your current balance and attempt the withdrawal once sufficient funds are available. Your understanding and cooperation are greatly appreciated, and we are here to assist with any further inquiries or support you may need regarding your account or this matter.',
          textAlign: TextAlign.justify,
          style: appStyle(kFontSizeBodySmall, kDark, FontWeight.normal)),
    ),
  );
}

class RowText extends StatelessWidget {
  const RowText({
    super.key,
    required this.first,
    required this.second,
    required this.bold,
  });

  final String first;
  final String second;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ReusableText(
          text: first,
          style: appStyle(
            16.sp, // Adjusted font size
            bold ? kGray : kGrayLight,
            bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),

        ReusableText(
          text: second,
          style: appStyle(
            16.sp, // Adjusted font size
            kGray,
            bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

