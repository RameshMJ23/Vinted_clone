import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vintedclone/bloc/filter_bloc/filter_size_bloc/filter_size_bloc.dart';
import 'package:vintedclone/bloc/filter_bloc/filter_size_bloc/filter_size_state.dart';

import '../../bloc/options_bloc/options_bloc.dart';
import '../../data/model/options_model.dart';
import '../constants.dart';

class FilterSizeScreen extends StatelessWidget {

  String optionJson;

  FilterSizeScreen({
    required this.optionJson,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: "Size",
        leadingWidget: getCloseLeadingWidget(context: context),
        trailingWidget: getFilterTrailingWidget((){
          BlocProvider.of<FilterSizeBloc>(context).resetList();
        })
      ),
      persistentFooterButtons: [
        buildButton(
          content: "Show results",
          buttonColor: getBlueColor(),
          contentColor: Colors.white,
          onPressed: (){
            Navigator.pop(context);
          },
          splashColor: Colors.white24
        )
      ],
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: OptionsBloc.loadOptionsJson(optionJson),
          builder: (context, AsyncSnapshot<List<OptionsModel>> snapShot){
            if(snapShot.hasData){

             /* List<OptionsModel> selectedSizesList;

              List<OptionsModel> unselectedSizesList =
                BlocProvider.of<FilterSizeBloc>(context).getUnselectedSizedList(snapShot.data!);
*/

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 15.0
                    ),
                    child: Text(
                      "Men's size ",
                      style: TextStyle(
                        fontFamily: "MaisonMedium",
                        fontSize: 16.0,
                        color: Colors.grey.shade700
                      )
                    ),
                  ),
                  Column(
                    children: snapShot.data!.map((e){
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BlocBuilder<FilterSizeBloc, FilterSizeState>(
                            builder: (context, state){

                              bool isSelected = state.selectedItems.where((element){
                                return element.optionName == e.optionName;
                              }).isNotEmpty;

                              return buildCheckBoxTileWidget(
                                  onTap: (){
                                    if(isSelected){
                                      BlocProvider.of<FilterSizeBloc>(context)
                                        .removeOption(e.optionName, e.index);
                                    }else{
                                      BlocProvider.of<FilterSizeBloc>(context)
                                        .selectOption(e.optionName, e.index);
                                    }
                                  },
                                  trailingWidget: buildCustomCheckBox(isSelected),
                                  tileName: e.optionName,
                                  verticalPadding: 10.0,
                                  horizontalPadding: 15.0
                              );
                            },
                          ),
                          const Divider(height: 0.5,)
                        ],
                      );
                    }).toList(),
                  ),
                ],
              );
            }else{
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
