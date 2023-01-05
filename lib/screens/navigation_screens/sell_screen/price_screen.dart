import 'package:flutter/material.dart';
import 'package:vintedclone/screens/constants.dart';


class PriceScreen extends StatefulWidget {

  String? enteredPrice;

  PriceScreen({this.enteredPrice});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    if(widget.enteredPrice != null){
      _priceController.text = "€" + widget.enteredPrice!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: getAppBar(context: context, title: "Price"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTextFieldLabel(textFieldName: 'Price'),
            buildTextField(
              autoFocus: true,
              hintText: "€0.00",
              controller: _priceController,
              validatorFunc: (val) => null,
              marginPadding: 0.0
            ),
            const Spacer(),
            buildButton(
              content: "Done",
              buttonColor: getBlueColor(),
              contentColor: Colors.white,
              onPressed: (){
                Navigator.pop(context, double.parse(_priceController.text).toStringAsFixed(2));
              },
              splashColor: getBlueColor().withOpacity(0.15)
            )
          ],
        ),
      ),
    );
  }
}

