import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vintedclone/bloc/filter_bloc/filter_sort_by_bloc/filter_sort_by_bloc.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/widgets/custom_radio_tile.dart';

class FilterSortByScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: "Sort by",
        leadingWidget: getCloseLeadingWidget(
          context: context
        ),
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
      body: ListView.builder(
        itemCount: getSortByList().length,
        itemBuilder: (context, index){
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 15.0
                ),
                child: GestureDetector(
                  child: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          getSortByList()[index],
                          style: const TextStyle(
                            fontFamily: "MaisonMedium",
                            fontSize: 16.0,
                            color: Colors.black87
                          ),
                        ),
                        BlocBuilder<FilterSortByBloc, int>(
                          builder: (context, state){
                            return customRadioButton(state == index);
                          },
                        )
                      ],
                    ),
                  ),
                  onTap: (){
                    BlocProvider.of<FilterSortByBloc>(context).changeSortCondition(index);
                  },
                ),
              ),
              const Divider(height: 0.1,)
            ],
          );
        }
      ),
    );
  }
}
