
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vintedclone/bloc/sell_bloc/sell_bloc.dart';
import 'package:vintedclone/bloc/sell_bloc/sell_state.dart';
import 'package:vintedclone/data/model/condition_model.dart';
import 'package:vintedclone/screens/constants.dart';

import '../../../bloc/filter_bloc/filter_common_selector_bloc/filter_common_selector_bloc.dart';

enum ConditionScreenEnum {
  sellScreen,
  filterScreen
}

class ConditionScreen extends StatelessWidget {

  ConditionScreenEnum _conditionScreenEnum;

  ConditionScreen(this._conditionScreenEnum);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: "Condition"),
      persistentFooterButtons: _conditionScreenEnum == ConditionScreenEnum.filterScreen
      ? [
        buildButton(
          content: "Show result",
          buttonColor: getBlueColor(),
          contentColor: Colors.white,
          onPressed: (){

          },
          splashColor: Colors.white24
        )
      ]: null,
      body: ListView.separated(
        itemCount: getConditionList().length,
        itemBuilder: (context, index){
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getConditionList()[index].conditionTitle,
                          style: const TextStyle(
                            fontFamily: "MaisonMedium",
                            fontSize: 16.0,
                            color: Colors.black87
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            getConditionList()[index].conditionDefinition,
                            style: TextStyle(
                              fontFamily: "MaisonBook",
                              fontSize: 16.0,
                              color: Colors.grey.shade700
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  _conditionScreenEnum == ConditionScreenEnum.sellScreen
                   ? BlocBuilder<SellBloc, SellState>(
                      builder: (context, state){
                        return Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: customRadioButton(
                            isSelected(state.conditionIndex, index),
                            size: 20.0,
                            centerCircleRadius: 4.0
                          ),
                        );
                      },
                   )
                   : BlocBuilder<FilterCommonSelectorBloc, List<int>>(
                      builder: (context, state){
                        return Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: buildCustomCheckBox(state.contains(index)),
                        );
                    },
                  )
                ],
              ),
            ),
            onTap: (){
              if(_conditionScreenEnum == ConditionScreenEnum.sellScreen){
                BlocProvider.of<SellBloc>(context).changeCondition(
                  getConditionList()[index].conditionTitle, index
                );
                Navigator.pop(context);
              }else{
                if(BlocProvider.of<FilterCommonSelectorBloc>
                  (context).state.contains(index)){
                  BlocProvider.of<FilterCommonSelectorBloc>
                    (context).addOption(index);
                }else{
                  BlocProvider.of<FilterCommonSelectorBloc>
                    (context).addOption(index);
                }
              }
            },
          );
        },
        separatorBuilder: (context, index){
          return const Divider(height: 0.5, thickness: 1.5,);
        },
      ),
    );
  }

  bool isSelected(int? conditionIndex, int listIndex){
    if(conditionIndex != null){
      if(conditionIndex == listIndex){
        return true;
      }else{
        return false;
      }
    }else{
      return false;
    }
  }
}
