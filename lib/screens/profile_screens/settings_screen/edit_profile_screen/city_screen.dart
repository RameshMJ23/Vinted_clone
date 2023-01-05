import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vintedclone/bloc/auth_bloc/auth_bloc.dart';
import 'package:vintedclone/bloc/auth_bloc/auth_state.dart';
import 'package:vintedclone/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:vintedclone/bloc/user_info_bloc/user_info_state.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/router/profile_route/profile_route_names.dart';
import 'package:vintedclone/screens/router/route_names.dart';

class CityScreen extends StatefulWidget {

  List citiesList;

  String country;

  CityScreen({
    required this.citiesList,
    required this.country
  });

  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {

  late TextEditingController _searchController;

  late ValueNotifier<bool> suffixIconNotifier;

  late ValueNotifier<List> _listNotifier;
  @override
  void initState() {
    // TODO: implement initState

    _searchController = TextEditingController();
    suffixIconNotifier = ValueNotifier<bool>(false);
    _listNotifier = ValueNotifier<List>(
      widget.citiesList
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: getAppBar(context: context, title: "My location"),
      body: Column(
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
                          _listNotifier.value = widget.citiesList;
                        }else{
                          suffixIconNotifier.value = true;
                          _listNotifier.value = _getFilteredList(val);
                        }
                      },
                      hintText: "Search for a town or city",
                      suffixOnPressed: (){
                        suffixIconNotifier.value = false;
                        _searchController.text = "";
                        _listNotifier.value = widget.citiesList;
                      },
                      showSuffix: showSuffix
                    );
                  },
                )
            ),
          ),
          const Divider(thickness: 1.2, height: 0.1,),
          const SizedBox(height: 20.0,),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: _listNotifier,
              builder: (valueBuilderContext, List cityList,child){

                final initialList =
                      cityList.length == widget.citiesList.length;

                return ListView.builder(
                  itemCount: initialList
                      ? cityList.length + 1 : cityList.length,
                  itemBuilder: (listContext, index){
                    if(index == 0 && initialList){
                      return buildBrandHeading("Popular ciites");
                    }else{

                      String cityName = cityList[
                        initialList ? index - 1 : index] as String;

                      return ListTile(
                        title: Text(
                          cityName,
                          style: const TextStyle(
                            fontFamily: "MaisonMedium",
                            fontSize: 16.0,
                            color: Colors.black87
                          ),
                        ),
                        trailing: BlocProvider<UserInfoBloc>(
                          create: (_) => UserInfoBloc.currentUser(),
                          child: Builder(
                            builder: (blocContext){
                              return BlocBuilder<UserInfoBloc, UserInfoState>(
                                bloc: BlocProvider.of<UserInfoBloc>(blocContext),
                                builder: (context, userState){
                                  return (userState is FetchedUserInfoState)
                                    ? customRadioButton(
                                    userState.userModel.location != null
                                      && cityName == _getCityName(userState.userModel.location!)
                                  ): const SizedBox();
                                },
                              );
                            },
                          ),
                        ),
                        onTap: (){
                          BlocProvider.of<AuthBloc>(context).changeLocation(
                            (BlocProvider.of<AuthBloc>(context).state as UserState).userId,
                            "$cityName, ${widget.country}"
                          ).then((value){
                            Navigator.popUntil(
                              context,
                                  (route) =>
                              route.settings.name == ProfileRouteNames.editProfileScreen
                            );
                          });
                        },
                      );
                    }
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }

  List _getFilteredList(String searchText){
    return widget.citiesList.where(
      (city) => city.toString().toLowerCase().contains(
        searchText.toLowerCase()
      )
    ).toList();
  }
  
  String _getCityName(String location){
    return location.split(",").first.trim();
  }
}

