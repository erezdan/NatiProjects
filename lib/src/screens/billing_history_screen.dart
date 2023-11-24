import 'package:audio_text/src/app/custom_colors.dart';
import 'package:audio_text/src/ui_component/boss_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BillingHistoryScreen extends StatefulWidget {
  const BillingHistoryScreen({super.key});

  @override
  State<BillingHistoryScreen> createState() => _BillingHistoryScreenState();
}

class _BillingHistoryScreenState extends State<BillingHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BossAppBar(context: context,title: "Billing History",),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              // customVerticalSpace(30),
              // _buildTimeSelectorRow(),
    
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container();
                  //  _buildBillingHistoryCard(_billingHistoryCardContent(vm.myOrder![index]));
                },
                separatorBuilder: (context, index) {
                  return Container(height:20);
                },
                itemCount: 2,
              ),
              // customVerticalSpace(20),
              _buildTotalAndTaxes(context, {"title": "totalPay", "value": "\$"}),
              _buildTotalAndTaxes(context, {"title": "taxes", "value": "\$"}),
            ],
          ),
        ),
      ),
    );
  }

  // double calculateTotal(List<Order> orders) {
  //   double total = 0;
  //   for (int i = 0; i < orders.length; i++) {
  //     total += double.parse(orders[i].paymentPrice);
  //   }
  //   return total;
  // }

  Widget _buildTotalAndTaxes(BuildContext context, Map<String, dynamic> json) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
         "title",
          style: GoogleFonts.poppins(
            color: CustomColors.black,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          json["value"],
          style: GoogleFonts.poppins(
            color: CustomColors.black,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }

  // Widget _buildTimeSelectorRow() {
  //   return Row(
  //     children: [
  //       Expanded(
  //           child: QureDateSelectorTextfield(
  //         onChanged: (val) {},
  //       )),
  //       const SizedBox(
  //         width: 25,
  //       ),
  //       Expanded(
  //           child: QureDateSelectorTextfield(
  //         onChanged: (val) {},
  //       )),
  //     ],
  //   );
  // }

  // Widget _billingHistoryCardContent() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             "Test",
  //             style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 17),
  //           ),
  //           Text(
  //             order.serviceName,
  //             style: GoogleFonts.poppins(
  //               fontSize: 16,
  //             ),
  //           ),
  //           Text(
  //             "${order.selectedDate} ${order.timeDuration}",
  //             style: GoogleFonts.poppins(
  //               fontSize: 16,
  //             ),
  //           ),
  //         ],
  //       ),
  //       Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             "\$${order.paymentPrice}",
  //             style: GoogleFonts.poppins(
  //               fontSize: 17,
  //               fontWeight: FontWeight.w600,
  //             ),
  //           ),
  //           Text(
  //             order.orderStatus,
  //             style: GoogleFonts.poppins(
  //               color: order.orderStatus.toLowerCase() == OrderStatus.OPEN.toShortString().toLowerCase()
  //                   ? CustomColors.greenColor
  //                   : CustomColors.textFieldGreyColor,
  //               fontSize: 15,
  //               fontWeight: FontWeight.w500,
  //             ),
  //           )
  //         ],
  //       )
  //     ],
  //   );
  // }

  Widget _buildBillingHistoryCard(Widget child) {
    return Container(
        padding: const EdgeInsets.only(left: 10, top: 15, bottom: 15, right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(5, 5),
              blurRadius: 15,
              spreadRadius: 2,
              color: CustomColors.primary.withOpacity(0.1),
            )
          ],
        ),
        child: child);
  }
}
