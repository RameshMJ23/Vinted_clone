import 'package:flutter/material.dart';
import 'package:vintedclone/screens/constants.dart';

class MembersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: "Followed members"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children:  const [
             Icon(
              Icons.person,
              size: 100.0,
              color: Colors.grey,
            ),
            Text(
              "This member doesn't have followers yet",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16.0,
                fontFamily: "MaisonMedium"
              ),
            )
          ],
        ),
      ),
    );
  }
}
