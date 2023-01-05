import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/router/profile_route/profile_route_names.dart';

class BalanceScreen extends StatelessWidget {

  final today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: "Balance",
        trailingWidget: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Icon(
                Icons.settings,
                color: Colors.grey.shade500,
              ),
            ),
            onTap: (){
              Navigator.of(context, rootNavigator: true).pushNamed(
                ProfileRouteNames.balanceConfirmationScreen,
                arguments: {
                  "childCurrent": this
                }
              );
            },
          )
        ]
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                buildGuideWithMultiTrail(
                  title: "Pending balance",
                  trailingText: "€0.00",
                  trailingIcon: Icons.info_outline,
                ),
                Divider(height: 0.5, color: Colors.grey.shade400,),
                SizedBox(
                  height: 180.0,
                  child: Column(
                    children: [
                      Padding(
                        padding:  const EdgeInsets.symmetric(vertical: 12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                "€0.00",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 26.0,
                                  fontFamily: "MaisonMedium"
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                "Available balance",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 16.0,
                                  fontFamily: "MaisonMedium"
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: buildButton(
                          content: "Activate balance",
                          buttonColor: getBlueColor(),
                          contentColor: Colors.white,
                          onPressed: (){
                            Navigator.of(context, rootNavigator: true).pushNamed(
                              ProfileRouteNames.balanceConfirmationScreen,
                              arguments: {
                                "childCurrent": this
                              }
                            );
                          },
                          splashColor: Colors.white24
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          buildSpacingText(
            content:  "Activate your Balance to track what you earn and spend on Vinted. "
                "Your earnings from sales are stored here."
          ),
          buildAccountsTile(
            vertPad: 15.0,
            leading: SvgPicture.asset(
              "assets/ukraine_heart.svg"
            ),
            title: "Donate to support Ukraine",
            subTitle: Text(
              "Our payment provider will match the amount to double your donation!",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 16.0,
                fontFamily: "maisonMedium"
              ),
            ),
            trailing: Column(
              children: [
                const SizedBox(height: 16.0,),
                buildAccountButton(
                  buttonName: "Donate now",
                  onTap: (){

                  },
                  width: 100.0
                ),
              ],
            )
          ),
          getSpacingWidget(context),
          ListTile(
            title: const Text(
              "Starting balance",
              style: TextStyle(
                fontFamily: "MaisonMedium",
                color: Colors.black87,
                fontSize: 16.0
              )
            ),
            subtitle: Text(
              Jiffy([today.year, today.month, today.day]).yMMMMd,
              style: TextStyle(
                fontFamily: "MaisonBook",
                color: Colors.grey.shade600,
                fontSize: 16.0
              ),
            ),
            trailing: Text(
              "€0.00",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 16.0,
                fontFamily: "MaisonMedium"
              ),
            ),
          ),
          getSpacingWidget(context)
        ],
      ),
    );
  }
}
