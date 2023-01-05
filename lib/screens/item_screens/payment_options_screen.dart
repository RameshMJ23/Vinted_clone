import 'package:flutter/material.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/profile_screens/settings_screen/payments_screen/add_card_screen.dart';
import 'package:vintedclone/screens/router/profile_route/profile_route_names.dart';

class PaymentOptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: "Payment options"),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15.0,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 60.0,
                    height: 160.0,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin:  const EdgeInsets.only(
                            right: 15.0,
                          ),
                          child: const Icon(Icons.credit_card, color: Colors.black87,),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(color: Colors.grey.shade300)
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Bank card",
                          style: TextStyle(
                            fontFamily: "MaisonMedium",
                            color: Colors.black87,
                            fontSize: 16.0
                          ),
                        ),
                        Text(
                          "Your payment information will never be shared with the "
                              "seller. Vinted won't store theese details without"
                              "your permission.",
                          style: TextStyle(
                            fontFamily: "MaisonMedium",
                            color: Colors.grey.shade600,
                            fontSize: 16.0
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                          ),
                          child: Row(
                            children: [
                              buildMasterCard(height: 30, width: 40 ),
                              buildVisaCard(height: 30, width: 40 ),
                              buildDiscoverCard(height: 30, width: 40 )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: customRadioButton(true),
                  )
                ],
              ),
            ),
            Divider(height: 0.5, color: Colors.grey.shade600,),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
              ),
              child: buildButton(
                content: "Proceed",
                buttonColor: getBlueColor(),
                contentColor: Colors.white,
                onPressed: (){
                  Navigator.pushNamed(
                    context,
                    ProfileRouteNames.addCardScreen,
                    arguments: {
                      "childCurrent": this,
                      "cardDetailScreenEnum": CardDetailScreenEnum.fromBuyNowScreen
                    }
                  );
                },
                splashColor: Colors.white24
              ),
            )
          ],
        ),
      ),
    );
  }
}
