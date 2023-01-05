import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vintedclone/bloc/user_info_bloc/user_info_state.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/profile_screens/profile_detail_screen.dart';
import 'package:vintedclone/screens/router/profile_route/profile_route_names.dart';
import 'package:vintedclone/screens/router/route_names.dart';
import 'package:vintedclone/screens/router/search_route/search_route_names.dart';
import '../../bloc/user_info_bloc/user_info_bloc.dart';
import '../../l10n/generated/app_localizations.dart';

final pageBucket = PageStorageBucket();

/*class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: AppLocalizations.of(context)!.profile,
        showLeading: true,
        leadingWidget: const SizedBox(width: 0.0,height: 0.0,),
        leadingWidth: 0.1
      ),
      body: PageStorage(
        bucket: pageBucket,
        child: ListView(
          key: const PageStorageKey<String>("profileScreen"),
          children: [
            ///  Use the common widget in constants (Edit profile screen)
            BlocProvider(
              create: (_) => UserInfoBloc.currentUser(),
              child: Builder(
                builder: (blocContext){
                  return BlocBuilder<UserInfoBloc, UserInfoState>(
                    bloc: BlocProvider.of<UserInfoBloc>(blocContext),
                    builder: (context, userState){
                      return userState is FetchedUserInfoState ? getProfileInfoWidget(
                        title: userState.userModel.name,
                        subTitle: Text(
                          AppLocalizations.of(context)!.viewMyProfile,
                          style: TextStyle(
                            fontFamily: "MaisonMedium",
                            color: Colors.grey.shade700,
                            fontSize: 16
                          )
                        ),
                        imageLink: userState.userModel.photo,
                        onTap: (){
                          Navigator.pushNamed(
                            context,
                            ProfileRouteNames.profileDetailScreen,
                            arguments: {
                              "childCurrent": this,
                              "userBloc": UserInfoBloc.currentUser(),
                              "profileScreenEnum": ProfileScreenEnum.currentUserScreen
                            }
                          );
                        }
                      )
                      : const Center(child: CircularProgressIndicator());
                    },
                  );
                },
              ),
            ),
            Divider(height: 0.5, color: Colors.grey.shade500,),
            _buildOptions(
              Icons.help_outline,
              AppLocalizations.of(context)!.yourGuideToVinted,
              (){
                Navigator.pushNamed(
                  context,
                  ProfileRouteNames.yourGuideScreen,
                  arguments: {
                    "childCurrent": this
                  }
                );
              }
            ),
            getSpacingWidget(context),
            Divider(height: 0.5, color: Colors.grey.shade500,),
            _buildOptions(
              Icons.favorite_border,
              AppLocalizations.of(context)!.favouriteItems,
              (){
                Navigator.pushNamed(
                  context,
                  ProfileRouteNames.favouritesScreen,
                  arguments: {
                    "childCurrent": this
                  }
                );
              }
            ),
            Divider(height: 0.5, color: Colors.grey.shade500,),
            _buildOptions(
              Icons.swap_horiz,
              AppLocalizations.of(context)!.personalisation,
              (){
                Navigator.of(context, rootNavigator: true).pushNamed(
                  ProfileRouteNames.personalisationScreen,
                  arguments: {
                    "childCurrent": this
                  }
                );
              }
            ),
            Divider(height: 0.5, color: Colors.grey.shade500,),
            buildGuideWithMultiTrail(
              color: Colors.white70,
              leading: Icon(
                Icons.wallet_membership_outlined,
                size: 22.0,
                color: Colors.grey.shade400,
              ),
              title: AppLocalizations.of(context)!.balanceOption,
              onTap: (){
                Navigator.pushNamed(
                  context,
                  ProfileRouteNames.balanceScreen,
                  arguments: {
                    "childCurrent": this
                  }
                );
              },
              trailingText: "€ 0.00"
            ),
            Divider(height: 0.5, color: Colors.grey.shade500,),
            _buildOptions(
                Icons.bookmark_border,
                AppLocalizations.of(context)!.myOrders,
                (){
                  Navigator.pushNamed(
                    context,
                    ProfileRouteNames.myOrdersScreen,
                    arguments: {
                      "childCurrent": this
                    }
                  );
                }
            ),
            Divider(height: 0.5, color: Colors.grey.shade500,),
            buildGuideWithMultiTrail(
              leading: Icon(
                Icons.local_offer_outlined,
                size: 22.0,
                color: Colors.grey.shade400,
              ),
              title: AppLocalizations.of(context)!.bundleDiscounts,
              onTap: (){
                Navigator.pushNamed(
                  context,
                  ProfileRouteNames.bundleDiscountScreen,
                  arguments: {
                    "childCurrent": this
                  }
                );
              },
              trailingText: AppLocalizations.of(context)!.on
            ),
            Divider(height: 0.5, color: Colors.grey.shade500,),
            buildGuideWithMultiTrail(
              leading: Icon(
                Icons.favorite,
                size: 22.0,
                color: Colors.grey.shade400,
              ),
              title: AppLocalizations.of(context)!.donations,
              onTap: (){
                Navigator.pushNamed(
                  context,
                  ProfileRouteNames.donationScreen,
                  arguments: {
                    "childCurrent": this
                  }
                );
              },
              trailingText: AppLocalizations.of(context)!.off
            ),
            getSpacingWidget(context),
            _buildOptions(
              Icons.message,
              AppLocalizations.of(context)!.forum,
              (){

              }
            ),
            getSpacingWidget(context),
            _buildOptions(
              Icons.holiday_village,
              AppLocalizations.of(context)!.holidayMode,
              (){
                Navigator.pushNamed(
                  context,
                  ProfileRouteNames.holidayModeScreen,
                  arguments: {
                    "childCurrent": this
                  }
                );
              }
            ),
            getSpacingWidget(context),
            _buildOptions(
              Icons.settings,
              AppLocalizations.of(context)!.settings,
              (){
                Navigator.pushNamed(
                  context,
                  ProfileRouteNames.settingsScreen,
                  arguments: {
                    "childCurrent": this
                  }
                );
              }
            ),
            Divider(height: 0.5, color: Colors.grey.shade500,),
            _buildOptions(
              Icons.lock_outline,
              AppLocalizations.of(context)!.cookieSettings,
              (){
                Navigator.of(context, rootNavigator: true).pushNamed(
                  RouteNames.preferenceScreen,
                  arguments: {
                    "childCurrent": this
                  }
                );
              }
            ),
            Divider(height: 0.5, color: Colors.grey.shade500,),
            _buildOptions(
              Icons.info_outline,
              AppLocalizations.of(context)!.aboutVinted,
              (){
                Navigator.pushNamed(
                  context,
                  ProfileRouteNames.aboutVintedScreen,
                  arguments: {
                    "childCurrent": this
                  }
                );
              }
            ),
            Divider(height: 0.5, color: Colors.grey.shade500,),
            _buildOptions(
              Icons.document_scanner,
              AppLocalizations.of(context)!.legalInformation,
              (){
                Navigator.pushNamed(
                  context,
                  ProfileRouteNames.legalInfoScreen,
                  arguments: {
                    "childCurrent": this
                  }
                );
              }
            ),
            Divider(height: 0.5, color: Colors.grey.shade500,),
            _buildOptions(
              Icons.info,
              AppLocalizations.of(context)!.ourPlatform,
              (){
                Navigator.of(context, rootNavigator: true).pushNamed(
                  RouteNames.webScreen,
                  arguments: {
                    "screenName": "Our platform",
                    "url": "https://www.vinted.lt/our-platform",
                    "childCurrent": this
                  }
                );
              }
            ),
            Divider(height: 0.5, color: Colors.grey.shade500,),
            _buildOptions(
              Icons.help,
              AppLocalizations.of(context)!.helpCenter,
              (){
                Navigator.pushNamed(
                  context,
                  ProfileRouteNames.helpMainScreen,
                  arguments: {
                    "childCurrent": this
                  }
                );
              }
            ),
            Divider(height: 0.5, color: Colors.grey.shade500,),
            _buildOptions(
              Icons.emoji_emotions_outlined,
              AppLocalizations.of(context)!.sendYourFeedback,
              (){
                Navigator.of(context, rootNavigator: true).pushNamed(
                  ProfileRouteNames.sendFeedbackIntroScreen,
                  arguments: {
                    "childCurrent": this
                  }
                );
              }
            ),
            Container(
              color: Colors.grey.shade300,
              width: MediaQuery.of(context).size.width,
              height: 60.0,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: RichText(
                      text: TextSpan(
                        text: AppLocalizations.of(context)!.privacyPolicy,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: "MaisonBook",
                          color: Colors.grey.shade600
                        ),
                        children: [
                          TextSpan(
                            text: "  •  ",
                            style: TextStyle(
                              fontSize: 14.0,
                              fontFamily: "MaisonBook",
                              color: Colors.grey.shade600
                            ),
                          ),
                          TextSpan(
                            text: AppLocalizations.of(context)!.termsAndCondition,
                            style: TextStyle(
                              fontSize: 14.0,
                              fontFamily: "MaisonBook",
                              color: Colors.grey.shade600
                            ),
                          )
                        ]
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        )
        ,
      ),
    );
  }

  Widget _buildOptions(
    IconData icon,
    String optionName,
    VoidCallback onTap
  ) => ListTile(
    tileColor: Colors.white,
    title: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.grey.shade500),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            optionName,
            style: const TextStyle(
              fontSize: 16.0,
              fontFamily: "MaisonMedium",
            ),
          ),
        )
      ],
    ),
    trailing: Icon(
      Icons.arrow_forward_ios,
      size: 16.0,
      color: Colors.grey.shade400,
    ),
    focusColor: Colors.grey.shade100,
    hoverColor: Colors.grey.shade100,
    selectedColor: Colors.grey.shade100 ,
    onTap: onTap,
  );
}*/

class ProfileScreen extends StatefulWidget{
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with AutomaticKeepAliveClientMixin{

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: AppLocalizations.of(context)!.profile,
        showLeading: true,
        leadingWidget: const SizedBox(width: 0.0,height: 0.0,),
        leadingWidth: 0.1
      ),
      body: PageStorage(
        bucket: pageBucket,
        child: ListView(
          key: const PageStorageKey<String>("profileScreen"),
          children: [
            ///  Use the common widget in constants (Edit profile screen)
            BlocProvider(
              create: (_) => UserInfoBloc.currentUser(),
              child: Builder(
                builder: (blocContext){
                  return BlocBuilder<UserInfoBloc, UserInfoState>(
                    bloc: BlocProvider.of<UserInfoBloc>(blocContext),
                    builder: (context, userState){
                      return userState is FetchedUserInfoState ? getProfileInfoWidget(
                        title: userState.userModel.name,
                        subTitle: Text(
                          AppLocalizations.of(context)!.viewMyProfile,
                          style: TextStyle(
                            fontFamily: "MaisonMedium",
                            color: Colors.grey.shade700,
                            fontSize: 16
                          )
                        ),
                        imageLink: userState.userModel.photo,
                        onTap: (){
                          Navigator.pushNamed(
                            context,
                            ProfileRouteNames.profileDetailScreen,
                            arguments: {
                              "childCurrent": widget,
                              "userBloc": UserInfoBloc.currentUser(),
                              "profileScreenEnum": ProfileScreenEnum.currentUserScreen
                            }
                          );
                        }
                      )
                      : getProfileInfoWidget(
                          title: "",
                          subTitle: Text(
                            AppLocalizations.of(context)!.viewMyProfile,
                            style: TextStyle(
                              fontFamily: "MaisonMedium",
                              color: Colors.grey.shade700,
                              fontSize: 16
                            )
                          ),
                          imageLink: null,
                          onTap: (){}
                      );
                    },
                  );
                },
              ),
            ),
            Divider(height: 0.5, color: Colors.grey.shade500,),
            _buildOptions(
                Icons.help_outline,
                AppLocalizations.of(context)!.yourGuideToVinted,
                    (){
                  Navigator.pushNamed(
                      context,
                      ProfileRouteNames.yourGuideScreen,
                      arguments: {
                        "childCurrent": widget
                      }
                  );
                }
            ),
            getSpacingWidget(context),
            Divider(height: 0.5, color: Colors.grey.shade500,),
            _buildOptions(
                Icons.favorite_border,
                AppLocalizations.of(context)!.favouriteItems,
                    (){
                  Navigator.pushNamed(
                      context,
                      ProfileRouteNames.favouritesScreen,
                      arguments: {
                        "childCurrent": widget
                      }
                  );
                }
            ),
            Divider(height: 0.5, color: Colors.grey.shade500,),
            _buildOptions(
                Icons.swap_horiz,
                AppLocalizations.of(context)!.personalisation,
                    (){
                  Navigator.of(context, rootNavigator: true).pushNamed(
                      ProfileRouteNames.personalisationScreen,
                      arguments: {
                        "childCurrent": widget
                      }
                  );
                }
            ),
            Divider(height: 0.5, color: Colors.grey.shade500,),
            buildGuideWithMultiTrail(
                color: Colors.white70,
                leading: Icon(
                  Icons.wallet_membership_outlined,
                  size: 22.0,
                  color: Colors.grey.shade400,
                ),
                title: AppLocalizations.of(context)!.balanceOption,
                onTap: (){
                  Navigator.pushNamed(
                      context,
                      ProfileRouteNames.balanceScreen,
                      arguments: {
                        "childCurrent": widget
                      }
                  );
                },
                trailingText: "€ 0.00"
            ),
            Divider(height: 0.5, color: Colors.grey.shade500,),
            _buildOptions(
                Icons.bookmark_border,
                AppLocalizations.of(context)!.myOrders,
                    (){
                  Navigator.pushNamed(
                      context,
                      ProfileRouteNames.myOrdersScreen,
                      arguments: {
                        "childCurrent": widget
                      }
                  );
                }
            ),
            Divider(height: 0.5, color: Colors.grey.shade500,),
            buildGuideWithMultiTrail(
                leading: Icon(
                  Icons.local_offer_outlined,
                  size: 22.0,
                  color: Colors.grey.shade400,
                ),
                title: AppLocalizations.of(context)!.bundleDiscounts,
                onTap: (){
                  Navigator.pushNamed(
                      context,
                      ProfileRouteNames.bundleDiscountScreen,
                      arguments: {
                        "childCurrent": widget
                      }
                  );
                },
                trailingText: AppLocalizations.of(context)!.on
            ),
            Divider(height: 0.5, color: Colors.grey.shade500,),
            buildGuideWithMultiTrail(
                leading: Icon(
                  Icons.favorite,
                  size: 22.0,
                  color: Colors.grey.shade400,
                ),
                title: AppLocalizations.of(context)!.donations,
                onTap: (){
                  Navigator.pushNamed(
                      context,
                      ProfileRouteNames.donationScreen,
                      arguments: {
                        "childCurrent": widget
                      }
                  );
                },
                trailingText: AppLocalizations.of(context)!.off
            ),
            getSpacingWidget(context),
            _buildOptions(
                Icons.message,
                AppLocalizations.of(context)!.forum,
                    (){

                }
            ),
            getSpacingWidget(context),
            _buildOptions(
                Icons.holiday_village,
                AppLocalizations.of(context)!.holidayMode,
                    (){
                  Navigator.pushNamed(
                      context,
                      ProfileRouteNames.holidayModeScreen,
                      arguments: {
                        "childCurrent": widget
                      }
                  );
                }
            ),
            getSpacingWidget(context),
            _buildOptions(
                Icons.settings,
                AppLocalizations.of(context)!.settings,
                    (){
                  Navigator.pushNamed(
                      context,
                      ProfileRouteNames.settingsScreen,
                      arguments: {
                        "childCurrent": widget
                      }
                  );
                }
            ),
            Divider(height: 0.5, color: Colors.grey.shade500,),
            _buildOptions(
                Icons.lock_outline,
                AppLocalizations.of(context)!.cookieSettings,
                    (){
                  Navigator.of(context, rootNavigator: true).pushNamed(
                      RouteNames.preferenceScreen,
                      arguments: {
                        "childCurrent": widget
                      }
                  );
                }
            ),
            Divider(height: 0.5, color: Colors.grey.shade500,),
            _buildOptions(
                Icons.info_outline,
                AppLocalizations.of(context)!.aboutVinted,
                    (){
                  Navigator.pushNamed(
                      context,
                      ProfileRouteNames.aboutVintedScreen,
                      arguments: {
                        "childCurrent": widget
                      }
                  );
                }
            ),
            Divider(height: 0.5, color: Colors.grey.shade500,),
            _buildOptions(
                Icons.document_scanner,
                AppLocalizations.of(context)!.legalInformation,
                    (){
                  Navigator.pushNamed(
                      context,
                      ProfileRouteNames.legalInfoScreen,
                      arguments: {
                        "childCurrent": widget
                      }
                  );
                }
            ),
            Divider(height: 0.5, color: Colors.grey.shade500,),
            _buildOptions(
                Icons.info,
                AppLocalizations.of(context)!.ourPlatform,
                    (){
                  Navigator.of(context, rootNavigator: true).pushNamed(
                      RouteNames.webScreen,
                      arguments: {
                        "screenName": "Our platform",
                        "url": "https://www.vinted.lt/our-platform",
                        "childCurrent": widget
                      }
                  );
                }
            ),
            Divider(height: 0.5, color: Colors.grey.shade500,),
            _buildOptions(
                Icons.help,
                AppLocalizations.of(context)!.helpCenter,
                    (){
                  Navigator.pushNamed(
                      context,
                      ProfileRouteNames.helpMainScreen,
                      arguments: {
                        "childCurrent": widget
                      }
                  );
                }
            ),
            Divider(height: 0.5, color: Colors.grey.shade500,),
            _buildOptions(
                Icons.emoji_emotions_outlined,
                AppLocalizations.of(context)!.sendYourFeedback,
                (){
                  Navigator.of(context, rootNavigator: true).pushNamed(
                    ProfileRouteNames.sendFeedbackIntroScreen,
                    arguments: {
                      "childCurrent": widget
                    }
                  );
                }
            ),
            Container(
              color: Colors.grey.shade300,
              width: MediaQuery.of(context).size.width,
              height: 60.0,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: RichText(
                      text: TextSpan(
                          text: AppLocalizations.of(context)!.privacyPolicy,
                          style: TextStyle(
                              fontSize: 14.0,
                              fontFamily: "MaisonBook",
                              color: Colors.grey.shade600
                          ),
                          children: [
                            TextSpan(
                              text: "  •  ",
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: "MaisonBook",
                                  color: Colors.grey.shade600
                              ),
                            ),
                            TextSpan(
                              text: AppLocalizations.of(context)!.termsAndCondition,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: "MaisonBook",
                                  color: Colors.grey.shade600
                              ),
                            )
                          ]
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        )
        ,
      ),
    );
  }

  Widget _buildOptions(
      IconData icon,
      String optionName,
      VoidCallback onTap
  ) => ListTile(
    tileColor: Colors.white,
    title: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.grey.shade500),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            optionName,
            style: const TextStyle(
              fontSize: 16.0,
              fontFamily: "MaisonMedium",
            ),
          ),
        )
      ],
    ),
    trailing: Icon(
      Icons.arrow_forward_ios,
      size: 16.0,
      color: Colors.grey.shade400,
    ),
    focusColor: Colors.grey.shade100,
    hoverColor: Colors.grey.shade100,
    selectedColor: Colors.grey.shade100 ,
    onTap: onTap,
  );
}


