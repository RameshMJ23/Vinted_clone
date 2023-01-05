
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vintedclone/bloc/brand_bloc/brand_bloc.dart';
import 'package:vintedclone/bloc/brand_bloc/brand_state.dart';
import 'package:vintedclone/bloc/sell_bloc/sell_bloc.dart';
import 'package:vintedclone/bloc/sell_bloc/sell_state.dart';
import 'package:vintedclone/screens/constants.dart';


class BrandScreen extends StatelessWidget {

  final TextEditingController _searchController = TextEditingController();

  ValueNotifier<bool> suffixIconNotifier = ValueNotifier<bool>(false);


  @override
  Widget build(BuildContext context) {

    //BlocProvider.of<BrandBloc>(context).getBrands();

    return Scaffold(
      appBar: getAppBar(context: context, title: "Brand"),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: SizedBox(
              height: 40.0,
              child: ValueListenableBuilder(
                valueListenable: suffixIconNotifier,
                builder: (context, bool showSuffix, child){
                  return buildFilledSearchTextField(
                    controller: _searchController,
                    onChanged: (val){
                      if(val.isEmpty){
                        suffixIconNotifier.value = false;
                        BlocProvider.of<BrandBloc>(context).getBrands();
                      }else{
                        suffixIconNotifier.value = true;
                        BlocProvider.of<BrandBloc>(context).filterBrands(val);
                      }
                    },
                    hintText: "Find a brand",
                    suffixOnPressed: (){
                      suffixIconNotifier.value = false;
                      _searchController.text = "";
                      BlocProvider.of<BrandBloc>(context).getBrands();
                    },
                    showSuffix: showSuffix
                  );
                },
              )
            ),
          ),
          const Divider(thickness: 1.2, height: 0.1,),
          BlocBuilder<BrandBloc, BrandState>(
            builder: (context, state){
              return (state is FetchedBrandState && state.brandList.isEmpty)
                ? const SizedBox(height: 0.0, width: 0.0,)
                : buildBrandHeading("Popular brands");
            },
          ),
          BlocBuilder<BrandBloc, BrandState>(
            builder: (context, state){
              return state is FetchedBrandState ? Column(
                children: state.brandList.map((e){
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          e.brandName,
                          style: const TextStyle(
                            fontFamily: "MaisonMedium",
                            fontSize: 16.0,
                            color: Colors.black87
                          ),
                        ),
                        trailing: BlocBuilder<SellBloc, SellState>(
                          builder: (context, state){
                            return customRadioButton(
                              isSelected(state.brandIndex, e.brandIndex)
                            );
                          },
                        ),
                        onTap: (){
                          BlocProvider.of<SellBloc>(context).changeBrand(
                            e.brandName, e.brandIndex
                          );
                          Navigator.pop(context);
                        },
                      ),
                      Divider(thickness: 1.2, height: 0.1, color: Colors.grey.shade200,)
                    ],
                  );
                }).toList(),
              )
              : Center(
                child: CircularProgressIndicator(
                  color: getBlueColor(),
                ),
              );
            },
          ),
          BlocBuilder<BrandBloc, BrandState>(
            builder: (context, state){
              return (state is FetchedBrandState && state.brandList.isEmpty)
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildBrandHeading("Brand not found"),
                    ListTile(
                      title: Text(
                        'Create a brand "${_searchController.text}"',
                        style: TextStyle(
                          fontFamily: "MaisonMedium",
                          fontSize: 16.0,
                          color: Colors.grey.shade700
                        ),
                      ),
                      trailing: customRadioButton(false),
                    )
                  ]
                )
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildBrandHeading("No brand indicated"),
                    ListTile(
                      title: const Text(
                        "No brand",
                        style: TextStyle(
                          fontFamily: "MaisonMedium",
                          fontSize: 16.0,
                          color: Colors.black87
                        ),
                      ),
                      trailing: customRadioButton(false),
                    )
                  ],
              );
            },
          )
        ],
      ),
    );
  }

  bool isSelected(int? stateIndex, int brandIndex){

    if(stateIndex != null){
      if(stateIndex == brandIndex){
        return true;
      }else{
        return false;
      }
    }else{
      return false;
    }

  }


}

