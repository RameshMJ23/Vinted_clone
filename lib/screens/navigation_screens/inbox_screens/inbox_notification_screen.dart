import 'package:flutter/material.dart';

import '../../constants.dart';

class InboxNotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Row(
              children: [
                getUserImage(
                  "https://www.vinted.com/assets/no-photo/user-clothing/system-photo/default.png",
                  size: 50.0,
                  borderRadius: 30.0
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Clothes you don't wear = extra cash. Sell them today.",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: "MaisonBook",
                            color: Colors.black87
                          ),
                          maxLines: 2,
                        ),
                        Text(
                          "6 days ago",
                          style: TextStyle(
                            fontFamily: "MaisonBook",
                            fontSize: 15.0,
                            color: Colors.grey.shade700
                          )
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
