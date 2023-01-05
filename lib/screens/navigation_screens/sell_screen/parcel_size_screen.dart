
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vintedclone/bloc/sell_bloc/sell_bloc.dart';
import 'package:vintedclone/bloc/sell_bloc/sell_state.dart';
import 'package:vintedclone/data/model/parcel_model.dart';
import 'package:vintedclone/screens/constants.dart';


class ParcelSizeScreen extends StatelessWidget {

  int recommendedSizeIndex;

  ParcelSizeScreen(this.recommendedSizeIndex);

  final List<ParcelModel> _parcelOptionList = [
    ParcelModel(
      parcelSize: "Small",
      definition: "Choose this for light T-shirts and small beauty items."
    ),
    ParcelModel(
      parcelSize: "Medium",
      definition: "Dresses, handbags, and ballet flats will fit into this parcel."
    ),
    ParcelModel(
      parcelSize: "Large",
      definition: "Light coats, sneakers, or heavy knitwear? Use a large box."
    ),
    ParcelModel(
      parcelSize: "Custom",
      definition: "Set your own shipping price. With this option, "
          "you're responsible for successful delivery.",
      showTextField: true
    )
  ];

  final TextEditingController _customPackingPriceController = TextEditingController();

  final GlobalKey<FormFieldState> _textFieldkey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: "Parcel size"),
      persistentFooterButtons: [
        buildButton(
          content: "Done",
          buttonColor: getBlueColor(),
          contentColor: Colors.white,
          onPressed: (){
            BlocProvider.of<SellBloc>(context).selectParcelSize();
            Navigator.pop(context);
          },
          splashColor: Colors.white.withOpacity(0.2)
        )
      ],
      body: ListView.builder(
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: GestureDetector(
              child: SizedBox(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                recommendedSizeIndex == index ? Container(
                                  padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 8.0),
                                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                                  child: const Text(
                                    "Recommended",
                                    style: TextStyle(
                                      fontFamily: "MaisonMedium",
                                      color: Colors.white
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: const Color(0xff27814B)
                                  ),
                                ): const SizedBox(height: 0.0, width: 0.0),
                                Text(
                                  _parcelOptionList[index].parcelSize,
                                  style: const TextStyle(
                                    fontFamily: "MaisonMedium",
                                    color: Colors.black87,
                                    fontSize: 16.0
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                      _parcelOptionList[index].definition,
                                      style: TextStyle(
                                        fontFamily: "MaisonMedium",
                                        color: Colors.grey.shade600,
                                        fontSize: 16.0
                                      )
                                  ),
                                ),
                                BlocBuilder<SellBloc, SellState>(
                                  builder: (context, state){
                                    return (
                                        state.parcelSize == _parcelOptionList[index].parcelSize &&
                                            !_parcelOptionList[index].showTextField)
                                        ? Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: RichText(
                                            text: TextSpan(
                                              text: "See sizing and compenstaion details",
                                              style: TextStyle(
                                                fontFamily: "MaisonMedium",
                                                color: getBlueColor(),
                                                fontSize: 14.0
                                              )
                                            )
                                        ),
                                    ): const SizedBox(height: 0.0,width: 0.0,);
                                  },
                                ),
                                BlocBuilder<SellBloc, SellState>(
                                  builder: (context, state){
                                    return (_parcelOptionList[index].showTextField && state.parcelSize == _parcelOptionList[index].parcelSize)? Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child:  Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Enter shipping price",
                                            style: TextStyle(
                                                fontFamily: "MaisonMedium",
                                                fontSize: 14.0,
                                                color: Colors.grey.shade500
                                            ),
                                          ),
                                          buildTextField(
                                              hintText: "€0.00",
                                              controller: _customPackingPriceController,
                                              validatorFunc: (val) => val!.isEmpty ? "Custom postage price is required": null,
                                              key: _textFieldkey
                                          )
                                        ],
                                      ),
                                    ): const SizedBox(height: 0.0, width: 0.0,);
                                  },
                                )
                              ],
                            ),
                          ),
                          BlocBuilder<SellBloc, SellState>(
                            builder: (context, state){
                              return customRadioButton(state.parcelSize == _parcelOptionList[index].parcelSize);
                            },
                          )
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey.shade600, height: 0.5,)
                  ],
                ),
              ),
              onTap: (){
                BlocProvider.of<SellBloc>(context).changeParcelSize(_parcelOptionList[index].parcelSize);
              },
            ),
          );
        },
        itemCount: _parcelOptionList.length,
      ),
    );
  }
}
