import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vintedclone/screens/constants.dart';

class BundleDiscountsScreen extends StatelessWidget {

  final ValueNotifier<String> _2ItemDiscount = ValueNotifier<String>("5");
  final ValueNotifier<String> _3ItemDiscount = ValueNotifier<String>("10");
  final ValueNotifier<String> _5ItemDiscount = ValueNotifier<String>("15");

  final List<String> discountValueList = [
    "0",
    "5",
    "10",
    "15",
    "20",
    "25",
    "30",
    "40",
    "50"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: getAppBar(context: context, title: "Bundle discount"),
      body: Column(
        children: [
          getSwitchListTile(
            tileName: "Select discount",
            isSelected: false,
            initialVal: true
          ),
          getSpacingWidget(context),
          buildBaseContainer(
            showBorder: false,
            containerName: "Set up discounts",
            children:  [
              ValueListenableBuilder(
                valueListenable: _2ItemDiscount,
                builder: (context, String value, child){
                  return _buildDiscountTile(
                    "2 items",
                   _getVisibleValue(value),
                    () {
                      _showDiscountDialog(
                        context: context,
                        discountValueNotifier: _2ItemDiscount,
                        onChangeCheckFunc: (String value){
                          int selectedVal = int.parse(value);
  
                          int threeItemDiscount = int.parse(_3ItemDiscount.value);
  
                          int fiveItemDiscount = int.parse(_5ItemDiscount.value);
  
                          if(selectedVal > threeItemDiscount){
                            _3ItemDiscount.value = value;
                          }
  
                          if(selectedVal > fiveItemDiscount){
                            _5ItemDiscount.value = value;
                          }
                        }
                      );
                    });
                }
              ),
              ValueListenableBuilder(
                  valueListenable: _3ItemDiscount,
                  builder: (context,String value, child){
                    return _buildDiscountTile(
                      "3 items", 
                      _getVisibleValue(value),
                      () {
                        _showDiscountDialog(
                          context: context,
                          discountValueNotifier: _3ItemDiscount,
                          onChangeCheckFunc: (String value){
                            int selectedVal = int.parse(value);
  
                            int twoItemDiscount = int.parse(_2ItemDiscount.value);
  
                            int fiveItemDiscount = int.parse(_5ItemDiscount.value);
  
                            if(selectedVal > fiveItemDiscount){
                              _5ItemDiscount.value = value;
                            }
  
                            if(selectedVal < twoItemDiscount){
                              _2ItemDiscount.value = value;
                            }
                          }
                        );
                    });
                  }
              ),
              ValueListenableBuilder(
                valueListenable: _5ItemDiscount,
                builder: (context,String value, child){
                  return _buildDiscountTile(
                    "5 items",
                    _getVisibleValue(value),
                    () {
                      _showDiscountDialog(
                        context: context,
                        discountValueNotifier: _5ItemDiscount,
                        onChangeCheckFunc: (String value){
                          int selectedVal = int.parse(value);
  
                          int threeItemDiscount = int.parse(_3ItemDiscount.value);
  
                          int twoItemDiscount = int.parse(_2ItemDiscount.value);
  
                          if(selectedVal < twoItemDiscount){
                            _2ItemDiscount.value = value;
                          }
  
                          if(selectedVal < threeItemDiscount){
                            _3ItemDiscount.value = value;
                          }
                        }
                      );
                  });
                }
              ),
            ]
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15.0),
            child: RichText(
              text: TextSpan(
                text: "Great! you can give discounts in ascending order,"
                  " starting with any number of items. "
                  "The better your deal, the more you'll sell! For help, see the ",
                style: TextStyle(
                  fontSize: 19.0,
                  color: Colors.grey.shade700
                ),
                children: [
                  TextSpan(
                    text: "FAQ.",
                    style: TextStyle(
                      fontSize: 19.0,
                      color: getBlueColor(),
                      decoration: TextDecoration.underline
                    ),
                  )
                ]
              ),
            ),
          )
        ],
      ),
    );
  }

  _showDiscountDialog({
    required BuildContext context,
    required ValueNotifier<String> discountValueNotifier,
    required Function(String) onChangeCheckFunc
  }){
    showDialog(
      context: context,
      builder: (dialogContext){
        return Dialog(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 15.0
                  ),
                  child: Text(
                    "Discount",
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.grey.shade700,
                      fontFamily: "MaisonMedium"
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: discountValueList.length,
                    itemBuilder: (context, index){
                      return ValueListenableBuilder(
                        valueListenable: discountValueNotifier,
                        builder: (context, String discountValue,child){
                          return  RadioListTile(
                            visualDensity: const VisualDensity(
                              horizontal: -4, vertical: -4
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 15.0
                            ),
                            value: index == 0 ? "0" : discountValueList[index],
                            groupValue: discountValue,
                            onChanged: (val){
                              onChangeCheckFunc(val as String);
                              discountValueNotifier.value = val as String;
                              Navigator.pop(dialogContext);
                            },
                            activeColor: getBlueColor(),
                            title: Text(
                              index == 0
                                  ? "-"
                                  : "${discountValueList[index]} %",
                              style: const TextStyle(
                                fontFamily: "MaisonMedium",
                                color: Colors.black87,
                                fontSize: 16.0
                              ),
                            ),
                          );
                        }
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 15.0
                    ),
                    child: buildTextButton(
                      fontSize: 16.0,
                      content: "CANCEL",
                      vertPadding: 5.0,
                      onPressed: (){
                        Navigator.pop(dialogContext);
                      }
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
  
  String _getVisibleValue(String val) => val == "0" ? "-": "$val%";

  Widget _buildDiscountTile(
    String discountValue,
    String discountPercent,
    VoidCallback onTap,
  ) => ListTile(
    title: Text(
      discountValue,
      style: const TextStyle(
        fontFamily: "MaisonMudim",
        color: Colors.black87,
        fontSize: 17.0
      ),
    ),
    trailing: Text(
      discountPercent,
      style: TextStyle(
        fontFamily: "MaisonMudim",
        color: Colors.grey.shade600,
        fontSize: 17.0
      )
    ),
    onTap: onTap,
  );
}
