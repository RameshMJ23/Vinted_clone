import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vintedclone/bloc/lang_bloc/lang_bloc.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/router/route_names.dart';
import 'package:vintedclone/screens/widgets/custom_radio_tile.dart';

class LanguageScreen extends StatelessWidget {

  final ValueNotifier<LangEnum> _langNotifier = ValueNotifier<LangEnum>(LangEnum.english);

  @override
  Widget build(BuildContext context) {


    _langNotifier.value = BlocProvider.of<LangBloc>(context).state.languageCode == "en"
        ? LangEnum.english
        : LangEnum.lithuanian;


    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: "Language settings",
        trailingWidget: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: buildTextButton(
              fontSize: 15.0,
              content: "SAVE",
              onPressed: (){
                BlocProvider.of<LangBloc>(context).changeLang(
                  _langNotifier.value
                );

                Navigator.of(context, rootNavigator: true).pushReplacementNamed(
                  RouteNames.splashScreen
                );
              },
              buttonColor: Colors.black87
            ),
          )
        ]
      ),
      body: Column(
        children: [
          const ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 16.0
            ),
            title: Text(
              "Select language",
              style: TextStyle(
                fontFamily: "MaisonMedium",
                fontSize: 24.0,
              ),
            ),
            subtitle: Text(
              "Choose the language you want to use",
              style: TextStyle(
                fontFamily: "MaisonMedium",
                fontSize: 16.0
              ),
            ),
          ),
          Divider(height: 5, color: Colors.grey.shade400, thickness: 1.1,),
          ValueListenableBuilder(
            valueListenable: _langNotifier,
            builder: (context, LangEnum selectedLang, child){
              return CustomRadioTile(
                langName: "Lietuvų",
                langNameEnglish: "Lithuanian",
                selected: selectedLang == LangEnum.lithuanian,
                onPressed: (){
                  _langNotifier.value = LangEnum.lithuanian;
                },
              );
            }
          ),
          ValueListenableBuilder(
            valueListenable: _langNotifier,
            builder: (context, LangEnum selectedLang, child){
              return CustomRadioTile(
                langName: "English",
                langNameEnglish: "English",
                selected: selectedLang == LangEnum.english,
                onPressed: (){
                  _langNotifier.value = LangEnum.english;
                }
              );
            }
          ),
        ],
      ),
    );
  }
}

/*

ValueListenableBuilder(
            valueListenable: _langNotifier,
            builder: (context, LangEnum selectedLang, child){

              log("Is Lithuanian selected....." + (selectedLang == LangEnum.lithuanian).toString());
              return CustomRadioTile(
                langName: "Lietuvų",
                langNameEnglish: "Lithuanian",
                selected: selectedLang == LangEnum.lithuanian,
                onPressed: (){
                  _langNotifier.value = LangEnum.lithuanian;
                },
              );
            }
          ),
          ValueListenableBuilder(
            valueListenable: _langNotifier,
            builder: (context, LangEnum selectedLang, child){
              return CustomRadioTile(
                langName: "English",
                langNameEnglish: "English",
                selected: selectedLang == LangEnum.english,
                onPressed: (){
                  _langNotifier.value = LangEnum.english;
                }
              );
            }
          )
 */
