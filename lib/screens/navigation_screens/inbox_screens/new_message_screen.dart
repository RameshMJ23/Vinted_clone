import 'package:flutter/material.dart';
import 'package:vintedclone/screens/constants.dart';

class NewMessageScreen extends StatelessWidget {

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: getAppBar(context: context, title: "New message"),
      body: Container(
        padding: const EdgeInsets.only(
          left: 15.0,
          right: 15.0,
          top: 5.0,
          bottom: 12.0
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Text(
                "To: ",
                style: TextStyle(
                  fontFamily: "MaisonBook",
                  fontSize: 16.0,
                  color: Colors.grey.shade600
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: buildTextField(
                  hintText: "Select a member",
                  controller: _controller,
                  validatorFunc: (val) => null
                ),
              ),
            )
          ],
        ),
        color: Colors.white,
      ),
    );
  }
}
