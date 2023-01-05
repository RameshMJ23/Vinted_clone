
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vintedclone/data/model/help_center_model/help_center_item.dart';

import '../../../bloc/help_center_bloc/help_center_bloc.dart';
import '../../constants.dart';
import '../../router/profile_route/profile_route_names.dart';

class HelpSearchScreen extends StatelessWidget {

  HelpCenterBloc helpCenterBloc;

  HelpSearchScreen(this.helpCenterBloc);

  final TextEditingController _helpSearchController = TextEditingController();

  ValueNotifier<bool> suffixIconNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: helpCenterBloc,
      child: Builder(
        builder: (blocContext){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leadingWidth: 40.0,
              elevation: 0.0,
              title: SizedBox(
                height: 40.0,
                child:  ValueListenableBuilder(
                  valueListenable: suffixIconNotifier,
                  builder: (context, bool showSuffix, child){
                    return buildFilledSearchTextField(
                        controller: _helpSearchController,
                        onChanged: (val){
                          if(val.isEmpty){
                            suffixIconNotifier.value = false;
                            BlocProvider.of<HelpCenterBloc>(blocContext).resetSearch();
                          }else{
                            suffixIconNotifier.value = true;
                            BlocProvider.of<HelpCenterBloc>(blocContext).filterSearch(val);
                          }
                        },
                        hintText: "Search for help",
                        suffixOnPressed: (){
                          suffixIconNotifier.value = false;
                          _helpSearchController.text = "";
                          BlocProvider.of<HelpCenterBloc>(blocContext).resetSearch();
                        },
                        showSuffix: showSuffix
                    );
                  },
                ),
              ),
              leading: getAppBarLeading(context),
            ),
            body: BlocBuilder<HelpCenterBloc, List<HelpCenterItem>?>(
                bloc: BlocProvider.of<HelpCenterBloc>(blocContext),
                builder: (context, helpList){
                  return (helpList != null && helpList.isNotEmpty)
                  ? ListView.builder(
                    itemCount: helpList.length,
                    itemBuilder: (context, index){
                      return buildGuideOptions(
                        guideName: helpList[index].topicName,
                        onTap: (){
                          Navigator.pushNamed(
                            context,
                            ProfileRouteNames.profileWebScreen,
                            arguments: {
                              "screenName": "Get Help",
                              "url": helpList[index].url,
                              "childCurrent": this
                            }
                          );
                        }
                      );
                    },
                  )
                  : ValueListenableBuilder(
                    valueListenable: suffixIconNotifier,
                    builder: (context, bool showSuffix, child){
                      return showSuffix
                        ? _noResultWidget()
                        : _initialItemWidget();
                    }
                  );
                }
            ),
          );
        },
      ),
    );
  }

  Widget _initialItemWidget() => Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: buildIntroText(
        "Enter a phrase to search",
        "We'll help answer all your questions"
            "\nabout orders, payments, and anything"
            "\n Vinted"
      ),
    ),
  );

  Widget _noResultWidget() => Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: buildIntroText(
        "No results found",
        "Sorry, no info about that here. Try"
          "\n another keyword!"
      ),
    ),
  );
}
