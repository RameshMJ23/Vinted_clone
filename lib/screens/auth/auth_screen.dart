import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:vintedclone/bloc/auth_bloc/auth_bloc.dart';
import 'package:vintedclone/bloc/lang_bloc/lang_bloc.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/router/route_names.dart';
import 'package:vintedclone/screens/widgets/custom_radio_tile.dart';

class AuthScreen extends StatelessWidget {

  StreamChatClient client;

  ValueNotifier<LangEnum> langNotifier
                          = ValueNotifier<LangEnum>(LangEnum.english);

  AuthScreen(this.client);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0, right: 15.0, left: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MaterialButton(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(CupertinoIcons.globe),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      "English",
                      style: TextStyle(
                        fontFamily: "MaisonMedium",
                        fontSize: 16.0
                      ),
                    ),
                  ),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
              onPressed: (){
                showLangDialog(context);
              },
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Image.asset(
                      "assets/intro screen pic.jpg"
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "Sell pre-loved clothes \n completely free",
                    style: TextStyle(
                        fontFamily: "MaisonBold",
                        fontSize: 22.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Column(
                      children: [
                        buildButton(
                            content: "Sign up for Vinted",
                            buttonColor: getBlueColor(),
                            contentColor: Colors.white,
                            onPressed: (){
                              showAuthBottomSheet(
                                context: context,
                                sheetName: "Sign up",
                                screenInstance: this
                              );
                            },
                            splashColor: Colors.white.withOpacity(0.1)
                        ),
                        buildButton(
                          content: "I already have an account",
                          buttonColor: Colors.white,
                          contentColor: getBlueColor(),
                          onPressed: (){
                            showAuthBottomSheet(
                              context: context,
                              sheetName: "Log in",
                              screenInstance: this
                            );
                          },
                          side: true,
                          splashColor: getBlueColor().withOpacity(0.1)
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "About Vinted:",
                        style: TextStyle(
                            fontFamily: "MaisonLight",
                            color: Colors.grey.shade700,
                            fontSize: 12.0
                        ),
                      ),
                      TextButton(
                        child: const Text(
                          "Our platform",
                          style: TextStyle(
                            fontFamily: "MaisonLight",
                            color: Colors.black,
                            fontSize: 12.0,
                            decoration: TextDecoration.underline
                          ),
                        ),
                        onPressed: (){
                          Navigator.of(context, rootNavigator: true).pushNamed(
                            RouteNames.webScreen,
                            arguments: {
                              "screenName": "Our platform",
                              "url": "https://www.vinted.lt/our-platform",
                              "childCurrent": this
                            }
                          );
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildAuthButton({
    required String content,
    required String iconUrl,
    required VoidCallback onPressed,
  }) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: SizedBox(
      width: double.infinity,
      child: MaterialButton(
        highlightColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: const BorderSide(color: Colors.black87, width: 1.5)
        ),
        highlightElevation: 0.0,
        elevation: 0.0,
        splashColor: Colors.grey.shade100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: SizedBox(
                child: Image.asset(
                  iconUrl
                ),
                height: 20.0,
                width: 20.0,
              ),
            ),
            Text(
              content,
              style: const TextStyle(
                fontFamily: "MaisonMedium",
                color: Colors.black87,
                fontSize: 16.0
              ),
            )
          ],
        ),
        color: Colors.transparent,
        onPressed: onPressed,
      ),
    ),
  );


  showLangDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (dialogContext){
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    child: Text(
                      "Select language",
                      style: TextStyle(
                        fontSize: 22.0,
                        fontFamily: "MaisonMedium"
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                  ),
                  ValueListenableBuilder(
                    valueListenable: langNotifier,
                    builder: (context,LangEnum val, child){
                      return CustomRadioTile(
                        langName: "Lietuvų",
                        langNameEnglish: "Lithuanian",
                        selected: val == LangEnum.lithuanian,
                        onPressed: (){
                          langNotifier.value = LangEnum.lithuanian;
                        },
                      );
                    }
                  ),
                  ValueListenableBuilder(
                    valueListenable: langNotifier,
                    builder: (context,LangEnum val, child){
                      return CustomRadioTile(
                        langName: "English",
                        langNameEnglish: "English",
                        selected: val == LangEnum.english,
                        onPressed: (){
                          langNotifier.value = LangEnum.english;
                        },
                      );
                    }
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                    child: Column(
                      children: [
                        buildButton(
                          content: "Save",
                          buttonColor: getBlueColor(),
                          contentColor: Colors.white,
                          onPressed: (){
                            Navigator.pop(dialogContext);
                          },
                          splashColor: Colors.white.withOpacity(0.1)
                        ),
                        buildButton(
                          content: "Cancel",
                          buttonColor: Colors.white,
                          contentColor: getBlueColor(),
                          onPressed: (){
                            Navigator.pop(dialogContext);
                          },
                          splashColor: getBlueColor().withOpacity(0.1)
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }

  showAuthBottomSheet({
    required BuildContext context,
    required String sheetName,
    required Widget screenInstance
  }){
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (sheetContext){
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              getBottomSheetScrollHeader(),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8.0),
                      topLeft: Radius.circular(8.0),
                    ),
                    color: Colors.white
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: getBottomSheetContentHeader(sheetName, sheetContext),
                    ),
                    const Divider(thickness: 1.5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      child: Column(
                        children: [
                          _buildAuthButton(
                            content: "Continue with Facebook",
                            iconUrl: "assets/facebook_logo.png",
                            onPressed: (){
                              if(sheetName == "Log in"){
                                BlocProvider.of<AuthBloc>(context).signUpWithFacebook();
                              }else if(sheetName == "Sign up"){
                                BlocProvider.of<AuthBloc>(context).signUpWithFacebook();
                              }
                            },
                          ),
                          _buildAuthButton(
                            content: "Continue with Google",
                            iconUrl: "assets/google_logo.png",
                            onPressed: (){
                              if(sheetName == "Log in"){
                                BlocProvider.of<AuthBloc>(context).signInWithGoogle(client).then((value){
                                  Navigator.pushReplacementNamed(context, RouteNames.authWrapper);
                                });
                              }else if(sheetName == "Sign up"){
                                BlocProvider.of<AuthBloc>(context).signUpWithGoogle(client).then((value){
                                  Navigator.pushReplacementNamed(context, RouteNames.authWrapper);
                                });
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      child: RichText(
                        text: TextSpan(
                            text: "Or continue with ",
                            style: TextStyle(
                              fontFamily: "MaisonMedium",
                              color: Colors.grey.shade700,
                              fontSize: 18.0,
                            ),
                            children: [
                              TextSpan(
                                text: "email",
                                style: TextStyle(
                                  fontFamily: "MaisonMedium",
                                  color: getBlueColor(),
                                  fontSize: 18.0
                                ),
                                recognizer: TapGestureRecognizer()..onTap = (){
                                  if(sheetName == "Log in"){
                                    Navigator.pop(sheetContext);
                                    Navigator.pushNamed(
                                      context,
                                      RouteNames.loginScreen,
                                      arguments: {
                                        "childCurrent": screenInstance
                                      }
                                    );
                                  }else if(sheetName == "Sign up"){
                                    Navigator.pop(sheetContext);
                                    Navigator.pushNamed(
                                      context,
                                      RouteNames.signUpScreen
                                    );
                                  }
                                }
                              )
                            ]
                        ),
                      ),
                      padding: const EdgeInsets.only(bottom: 20.0),
                    )
                  ],
                ),
              )
            ],
          );
        }
    );
  }
}
