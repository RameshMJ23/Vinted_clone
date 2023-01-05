import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vintedclone/bloc/filter_bloc/filter_material_bloc/filter_material_bloc.dart';
import '../../bloc/filter_bloc/filter_material_bloc/filter_material_state.dart';
import '../../bloc/options_bloc/options_bloc.dart';
import '../../data/model/options_model.dart';
import '../constants.dart';

class FilterMaterialScreen extends StatelessWidget {

  String optionJson;

  FilterMaterialScreen({
    required this.optionJson,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
          context: context,
          title: "Material",
          leadingWidget: getCloseLeadingWidget(context: context),
          trailingWidget: getFilterTrailingWidget((){})
      ),
      persistentFooterButtons: [
        buildButton(
          content: "Show results",
          buttonColor: getBlueColor(),
          contentColor: Colors.white,
          onPressed: (){

          },
          splashColor: Colors.white24
        )
      ],
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: OptionsBloc.loadOptionsJson(optionJson),
          builder: (context, AsyncSnapshot<List<OptionsModel>> snapShot){
            return snapShot.hasData
            ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 15.0
                  ),
                  child: Text(
                    "Men's Items ",
                    style: TextStyle(
                      fontFamily: "MaisonMedium",
                      fontSize: 16.0,
                      color: Colors.grey.shade700
                    )
                  ),
                ),
                Column(
                  children: snapShot.data!.map((e){
                    return BlocBuilder<FilterMaterialBloc, FilterMaterialState>(
                      builder: (context, state){

                        bool isSelected = state.materialList.where((element) {
                          return element.optionName == e.optionName;
                        }).isNotEmpty;

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            buildCheckBoxTileWidget(
                              onTap: (){
                                if(isSelected){
                                  BlocProvider.of<FilterMaterialBloc>
                                    (context).addMaterial(e.optionName,e.index);
                                }else{
                                  BlocProvider.of<FilterMaterialBloc>
                                    (context).removeMaterial(e.optionName,e.index);
                                }
                              },
                              trailingWidget: buildCustomCheckBox(isSelected),
                              tileName: e.optionName,
                              verticalPadding: 10.0,
                              horizontalPadding: 15.0
                            ),
                            const Divider(height: 0.5,)
                          ],
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            )
            : const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
