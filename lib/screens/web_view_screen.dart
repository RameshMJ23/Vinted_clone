import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vintedclone/bloc/webview_bloc/web_view_bloc.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {

  String screenName;
  String url;

  WebViewScreen({required this.screenName,required this.url});

  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: screenName),
      body: BlocBuilder<WebViewBloc, bool>(
        builder: (context, state){
          return Stack(
            children: [
              WebView(
                initialUrl: url,
                onWebViewCreated: (controller){
                  this.controller = controller;
                  BlocProvider.of<WebViewBloc>(context).isLoaded();
                },
                onPageStarted: (url){

                },
              ),
              Visibility(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: getBlueColor(),
                    ),
                  ),
                ),
                visible: state == false,
              )
            ],
          );
        },
      ),
    );
  }
}
