
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vintedclone/bloc/options_bloc/options_bloc.dart';
import 'package:vintedclone/bloc/sell_bloc/sell_bloc.dart';
import 'package:vintedclone/bloc/sell_bloc/sell_state.dart';
import 'package:vintedclone/data/model/options_model.dart';
import 'package:vintedclone/screens/constants.dart';

enum OptionScreenEnum{
  sizeScreen,
  materialScreen
}

class OptionScreen extends StatelessWidget {

  String screenTitle;

  String optionJson;

  OptionScreenEnum screenEnum;

  OptionScreen({
    required this.screenTitle,
    required this.optionJson,
    required this.screenEnum
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: getAppBar(context: context, title: screenTitle),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: OptionsBloc.loadOptionsJson(optionJson),
          builder: (context, AsyncSnapshot<List<OptionsModel>> snapShot){
            return snapShot.hasData
            ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                screenEnum == OptionScreenEnum.sizeScreen ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                          "Select a size",
                          style: TextStyle(
                              fontFamily: "MaisonMedium",
                              fontSize: 16.0,
                              color: Colors.black87
                          )
                      ),
                      Text(
                          "Match the size to the item's label.",
                          style: TextStyle(
                              fontFamily: "MaisonMedium",
                              fontSize: 16.0,
                              color: Colors.grey.shade700
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: RichText(
                          text: TextSpan(
                              text: "View size guide",
                              style: TextStyle(
                                fontFamily: "MaisonMedium",
                                fontSize: 18.0,
                                color: getBlueColor()
                              ),
                              recognizer: TapGestureRecognizer()..onTap = (){}
                          ),
                        ),
                      )
                    ],
                  ),
                ) : const SizedBox(height: 0.0,width: 0.0,),
                Column(
                  children: snapShot.data!.map((e){
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                          title: Text(
                            e.optionName,
                            style: const TextStyle(
                                fontFamily: "MaisonMedium",
                                fontSize: 16.0,
                                color: Colors.black87
                            ),
                          ),
                          trailing: BlocBuilder<SellBloc, SellState>(
                            builder: (context, state){

                              bool isSelected;
                              if(screenEnum == OptionScreenEnum.sizeScreen){
                                isSelected = state.size != null && state.size == e.optionName;
                              }else{
                                isSelected = state.material != null && state.material == e.optionName;
                              }

                              return customRadioButton(isSelected);
                            },
                          ),
                          onTap: (){
                            if(screenEnum == OptionScreenEnum.sizeScreen){
                              BlocProvider.of<SellBloc>(context).changeSize(e.optionName);
                            }else{
                              BlocProvider.of<SellBloc>(context).changeMaterial(e.optionName);
                            }

                            Navigator.pop(context);
                          },
                        ),
                        const Divider(height: 0.5,)
                      ],
                    );
                  }).toList(),
                ),
                screenEnum == OptionScreenEnum.sizeScreen ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
                  child:  RichText(
                    text: TextSpan(
                        text: "Size isn't here? Contact our ",
                        style: TextStyle(
                            fontFamily: "MaisonBook",
                            fontSize: 14.0,
                            color: Colors.grey.shade600
                        ),
                        children: [
                          TextSpan(
                              text: "Help Centre.",
                              style: TextStyle(
                                  fontFamily: "MaisonBook",
                                  fontSize: 14.0,
                                  color: getBlueColor()
                              ),
                              recognizer: TapGestureRecognizer()..onTap = (){}
                          )
                        ]
                    ),
                  ),
                ): const SizedBox(height: 0.0,width: 0.0,)
              ],
            )
            : const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

}
