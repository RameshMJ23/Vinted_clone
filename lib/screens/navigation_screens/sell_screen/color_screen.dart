
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vintedclone/bloc/color_selection_bloc/color_selection_bloc.dart';
import 'package:vintedclone/bloc/color_selection_bloc/color_selection_state.dart';
import 'package:vintedclone/bloc/filter_bloc/filter_color_bloc/filter_color_bloc.dart';
import 'package:vintedclone/bloc/filter_bloc/filter_color_bloc/filter_color_state.dart';
import 'package:vintedclone/bloc/options_bloc/options_bloc.dart';
import 'package:vintedclone/data/model/colour_option_model.dart';
import 'package:vintedclone/data/model/options_model.dart';
import 'package:vintedclone/screens/constants.dart';

import '../../../bloc/filter_bloc/filter_common_selector_bloc/filter_common_selector_bloc.dart';

enum ColorScreenEnum{
  sellScreen,
  filterScreen
}

class ColorsScreen extends StatelessWidget {

  ColorScreenEnum colorScreenEnum;

  ColorsScreen(this.colorScreenEnum);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: "Colours",
        trailingWidget: colorScreenEnum == ColorScreenEnum.filterScreen
          ? getFilterTrailingWidget((){

          }): null,
        leadingWidget: colorScreenEnum == ColorScreenEnum.filterScreen
          ? getCloseLeadingWidget(context: context)
          : null
      ),
      persistentFooterButtons: [
        buildButton(
          content: colorScreenEnum == ColorScreenEnum.sellScreen
            ? "Done"
            : "Show result",
          buttonColor: getBlueColor(),
          contentColor: Colors.white,
          onPressed: (){
            Navigator.pop(context);
          },
          splashColor: Colors.white.withOpacity(0.2)
        )
      ],
      body: FutureBuilder(
        future: OptionsBloc.loadColoursJson(),
        builder: (context, AsyncSnapshot<List<ColourOptionModel>> snapShot){
          return snapShot.hasData
            ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                colorScreenEnum == ColorScreenEnum.sellScreen ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  child: Text(
                    "Choose up to 2 colours",
                    style: TextStyle(
                      fontFamily: "MaisonMedium",
                      fontSize: 17.0,
                      color: Colors.grey.shade600
                    ),
                  ),
                ): const SizedBox(height: 0.0,width: 0.0,),
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index){

                        final color = int.parse(snapShot.data![index].color);

                        return ListTile(
                          horizontalTitleGap: 0.0,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                          leading: CircleAvatar(
                            radius: 10.0,
                            backgroundColor: Color(color),
                          ),
                          title: Text(
                            snapShot.data![index].colourName,
                            style: const TextStyle(
                              fontFamily: "MaisonMedium",
                              fontSize: 16.0,
                              color: Colors.black87
                            ),
                          ),
                          trailing: Transform.scale(
                            child: colorScreenEnum == ColorScreenEnum.sellScreen
                            ? BlocBuilder<ColorSelectionBloc, ColorSelectionState>(
                              builder: (context, state){
                                return _buildColorsCheckbox(
                                  state.colorList.contains(
                                    snapShot.data![index].colourName
                                  )
                                );
                              },
                            )
                            : BlocBuilder<FilterColorBloc, FilterColorState>(
                              builder: (context, state){
                                return _buildColorsCheckbox(
                                  state.colorList.where((element){
                                    return element.optionName == snapShot.data![index].colourName;
                                  }).isNotEmpty
                                );
                              },
                            ),
                            scale: 1.4,
                          ),
                          onTap: (){
                            if(colorScreenEnum == ColorScreenEnum.sellScreen){
                              if(BlocProvider.of<ColorSelectionBloc>(context)
                                  .state.colorList.contains(snapShot.data![index].colourName)){
                                BlocProvider.of<ColorSelectionBloc>(context).unSelectColor(
                                    snapShot.data![index].colourName
                                );
                              }else{
                                BlocProvider.of<ColorSelectionBloc>(context).selectColor(
                                    snapShot.data![index].colourName
                                );
                              }
                            }else{

                              bool contains = BlocProvider.of<FilterColorBloc>(context)
                                .state.colorList.where((element){
                                return element.optionName == snapShot.data![index].colourName;
                              }).isNotEmpty;

                              if(contains){
                                BlocProvider.of<FilterColorBloc>
                                  (context).removeColor(
                                    snapShot.data![index].colourName,
                                    index
                                );
                              }else{
                                BlocProvider.of<FilterColorBloc>
                                  (context).addColor(
                                    snapShot.data![index].colourName,
                                    index
                                );
                              }
                            }
                          },
                        );
                      },
                      separatorBuilder: (context, index){
                        return const Divider(height: 0.5,);
                      },
                      itemCount: snapShot.data!.length
                  ),
                )
              ],
            )
            : const Center(child:  CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildColorsCheckbox(bool value) => Checkbox(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(3.0),
    ),
    onChanged: (val){

    },
    side: const BorderSide(
        width: 0.5
    ),
    activeColor: getBlueColor(),
    checkColor: Colors.white,
    value: value,
  );
}
