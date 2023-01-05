
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:vintedclone/bloc/auth_bloc/auth_bloc.dart';
import 'package:vintedclone/bloc/lang_bloc/lang_bloc.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/router/route_names.dart';
import 'package:vintedclone/screens/widgets/custom_checkbox_validator.dart';

import '../../router/profile_route/profile_route_names.dart';


PageStorageBucket settingsBucket = PageStorageBucket();


class SettingsScreen extends StatefulWidget {

  AuthBloc authBloc;

  StreamChatClient client;

  SettingsScreen(this.authBloc,this.client);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with AutomaticKeepAliveClientMixin{

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.authBloc,
      child: Builder(
        builder: (blocContext){
          return Scaffold(
            appBar: getAppBar(context: context, title: "Settings"),
            body: Scrollbar(
                child: PageStorage(
                  bucket: settingsBucket,
                  child: ListView(
                    key: const PageStorageKey("settingsListKey"),
                    children: [
                      buildGuidOptionWithDiv(
                        guideName: "Profile details",onTap: (){
                        Navigator.of(context, rootNavigator: true).pushNamed(
                          ProfileRouteNames.editProfileScreen,
                          arguments: {
                            "childCurrent": this
                          }
                        );
                      }),
                      buildGuidOptionWithDiv(
                        guideName: "Account settings",onTap: (){
                        Navigator.pushNamed(
                          context,
                          ProfileRouteNames.accountSettingsScreen,
                          arguments: {
                            "childCurrent": widget
                          }
                        );
                      }),
                      buildGuidOptionWithDiv( guideName:"Payments",onTap: (){
                        Navigator.of(context).pushNamed(
                          ProfileRouteNames.paymentsScreen,
                          arguments: {
                            "childCurrent": widget
                          }
                        );
                      }),
                      buildGuidOptionWithDiv( guideName: "Postage",onTap: (){
                        Navigator.pushNamed(
                          context,
                          ProfileRouteNames.postageScreen,
                          arguments: {
                            "childCurrent": widget
                          }
                        );
                      }),
                      buildGuidOptionWithDiv( guideName: "Security", onTap:(){
                        Navigator.pushNamed(
                            context,
                            ProfileRouteNames.securityScreen,
                            arguments: {
                              "childCurrent": widget
                            }
                        );
                      }),
                      getSpacingWidget(context),
                      buildBaseContainer(containerName: "Notification", children :[
                        buildGuidOptionWithDiv( guideName: "Push notifications",onTap: (){
                          Navigator.pushNamed(
                              context,
                              ProfileRouteNames.pushNotificationScreen,
                              arguments: {
                                "childCurrent": widget
                              }
                          );
                        }),
                        buildGuidOptionWithDiv(guideName:"Email notifications",onTap: (){
                          Navigator.pushNamed(
                              context,
                              ProfileRouteNames.emailNotificationScreen,
                              arguments: {
                                "childCurrent": widget
                              }
                          );
                        })
                      ]),
                      getSpacingWidget(context),
                      buildBaseContainer(containerName: "Your app's language", children :[
                        BlocBuilder<LangBloc, Locale>(
                          builder: (context, langState){
                            return buildGuideWithMultiTrail(
                                title: "Language", onTap:(){
                              Navigator.pushNamed(
                                  context,
                                  ProfileRouteNames.langScreen,
                                  arguments: {
                                    "childCurrent": widget
                                  }
                              );
                            },
                                trailingText: langState.languageCode.toUpperCase(),
                                leading: const Icon(
                                  CupertinoIcons.globe,
                                  color: Colors.black54,
                                  size: 18.0,
                                )
                            );
                          },
                        ),
                      ]),
                      getSpacingWidget(context),
                      buildBaseContainer(containerName: "Privacy settings", children : [
                        Column(
                          children: [
                            buildCheckBoxTileWidget(
                                horizontalPadding: 18.0,
                                trailingWidget: buildCustomCheckBox(true),
                                tileName: "Notify sellers",
                                subTitle: "when I favourite their items",
                                onTap: (){

                                }
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Divider(
                                height: 0.5,
                                color: Colors.grey.shade300,
                                thickness: 1.2,
                              ),
                            )
                          ],
                        ),
                        buildGuidOptionWithDiv(guideName: "Data settings",onTap:  (){
                          Navigator.pushNamed(
                            context,
                            ProfileRouteNames.dataSettingsScreen,
                            arguments: {
                              "childCurrent": widget
                            }
                          );
                        })
                      ]),
                      getSpacingWidget(context),
                      buildGuidOptionWithDiv(guideName: "Log out",onTap: (){
                        _showLogoutDialog(context, blocContext, widget.client);
                      }),
                      Container(
                        color:  Colors.grey.shade300,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Text(
                              "App version: v22.44.1",
                              style: TextStyle(
                                  fontFamily: "MaisonBook",
                                  fontSize: 17.0,
                                  color: Colors.grey.shade600
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
            ),
          );
        },
      ),
    );
  }

  _showLogoutDialog(BuildContext context, BuildContext blocContext, StreamChatClient client){
    showDialog(
        context: context,
        builder: (dialogContext){
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 25.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "Log out of your \n account?",
                      style: TextStyle(
                        fontFamily: "MaisonMedium",
                        fontSize: 25.0,
                        color: Colors.black87
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  buildButton(
                    content: "Yes, log out",
                    buttonColor: getBlueColor(),
                    contentColor: Colors.white,
                    onPressed: () async{
                      Navigator.pop(dialogContext);
                      await BlocProvider.of<AuthBloc>(blocContext).logOut(client).then((_){
                        Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
                            RouteNames.authWrapper,
                                (route) => false
                        );
                      });
                    },
                    splashColor: Colors.white24
                  ),
                  buildButton(
                    content: "No, stay logged in",
                    buttonColor: Colors.transparent,
                    contentColor: getBlueColor(),
                    onPressed: (){
                      Navigator.pop(dialogContext);
                    },
                    splashColor: getBlueColor().withOpacity(0.2)
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}


