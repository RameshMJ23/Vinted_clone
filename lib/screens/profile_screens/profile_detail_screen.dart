

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:vintedclone/bloc/chat_bloc/chat_bloc.dart';
import 'package:vintedclone/bloc/item_bloc/item_bloc.dart';
import 'package:vintedclone/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:vintedclone/bloc/user_info_bloc/user_info_state.dart';
import 'package:vintedclone/screens/constants.dart';

enum ProfileScreenEnum{
  currentUserScreen,
  otherUserScreen
}

class ProfileDetailScreen extends StatefulWidget {

  UserInfoBloc userInfoBloc;

  Channel? channel;

  StreamChatClient client;

  ProfileScreenEnum profileScreenEnum;

  ProfileDetailScreen({
    required this.userInfoBloc,
    this.channel,
    required this.client,
    required this.profileScreenEnum
  });

  @override
  _ProfileDetailScreenState createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen>
                  with SingleTickerProviderStateMixin{

  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {


    return BlocProvider.value(
      value: widget.userInfoBloc,
      child: Builder(
        builder: (blocContext){
          return BlocBuilder<UserInfoBloc, UserInfoState>(
            bloc: BlocProvider.of<UserInfoBloc>(blocContext),
            builder: (context, userState){
              return Scaffold(
                appBar: getAppBar(
                    context: context,
                    title: _getUserName(userState),
                    trailingWidget: [
                      PopupMenuButton(
                        elevation: 2,
                        icon: const Icon(
                          Icons.more_vert,
                          color: Colors.black87,
                        ),
                        itemBuilder: (context){
                          return ["Share", "Edit profile"].map((e) {
                            return PopupMenuItem(
                              child: Row(
                                children: [
                                  Icon(
                                    e == "Share" ? Icons.share : Icons.edit,
                                    color: Colors.black87
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    child: Text(
                                      e,
                                      style: TextStyle(
                                        fontFamily: "MaisonMedium",
                                        color: Colors.grey.shade500
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }).toList();
                        },
                      )
                    ]
                ),
                body: Column(
                  children: [
                    TabBar(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      controller: _tabController,
                      indicatorColor: getBlueColor(),
                      labelStyle: const TextStyle(
                        fontFamily: "MaisonBook",
                        fontSize: 14.0,
                      ),
                      labelColor: Colors.black87,
                      unselectedLabelColor: Colors.grey.shade600,
                      tabs: const [
                        Tab(
                          child: Text("Wardrobe"),
                        ),
                        Tab(
                          child: Text("Reviews"),
                        ),
                        Tab(
                          child: Text("About"),
                        )
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          wardrobeWidget(context),
                          reviewWidget(),
                          widget.profileScreenEnum == ProfileScreenEnum.otherUserScreen
                          ? otherUserAboutWidget(
                            context: context,
                            channel: widget.channel!,
                            client: widget.client
                          ): currentUserAboutWidget(
                            context: context,
                            client: widget.client
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget wardrobeWidget(
    BuildContext context
  ) => BlocBuilder<UserInfoBloc, UserInfoState>(
    builder: (context, userState){
      return (userState is FetchedUserInfoState)
      ? Column(
        children: [
          getProfileInfoWidget(
            title: _getUserName(userState),
            subTitle: _getReviewWidget(userState),
            imageLink: userState.userModel.photo,
            onTap: (){

            }
          ),
          const Divider(),
          ListTile(
            title: Column(
              children: [
                _buildInfoWidget(Icons.check_circle_outline,  _getAuthMethod(userState)),
                _buildInfoWidget(Icons.location_on_outlined,  "Lietuva"),
              ],
            ),
            subtitle:  _buildInfoWidget(Icons.wifi,  "0 followers, 0 following"),
            trailing: getTrailingIcon(),
            isThreeLine: true,
            onTap: (){

            },
          ),
          Expanded(
            child: _noWardrobeWidget(),
          )
        ],
      ): vintedCircularBar();
    },
  );

  Widget currentUserAboutWidget({
    required BuildContext context,
    required  StreamChatClient client
  }) => BlocBuilder<UserInfoBloc,UserInfoState>(
    builder: (context, userState){
      return StreamChatCore(
        client: client,
        child: Builder(
          builder: (chatContext){
            return ListView(
              children: [
                _aboutTopWidgets(userState),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoWidget(Icons.location_on_outlined, "Lietuva", fontSize: 16.0),
                      getLastSeenWithUser(
                        user: chatContext.currentUser,
                        textStyle: TextStyle(
                          color: Colors.grey.shade600,
                          fontFamily: "MaisonBook",
                          fontSize: 16.0
                        )
                      ),
                      _buildInfoWidget(Icons.wifi, "0 followers, 0 following", fontSize: 16.0)
                    ],
                  ),
                )
              ],
            );
          },
        )
      );
    },
  );


  Widget otherUserAboutWidget({
    required BuildContext context,
    required Channel channel,
    required  StreamChatClient client
  }) => BlocBuilder<UserInfoBloc,UserInfoState>(
    builder: (context, userState){
      return StreamChatCore(
        client: client,
        child: StreamChannel(
          channel: channel,
          child: ListView(
            children: [
              _aboutTopWidgets(userState),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                child: Column(
                  children: [
                    _buildInfoWidget(
                      Icons.location_on_outlined, "Lietuva", fontSize: 16.0
                    ),
                    lastSeenWidget(channel, TextStyle(
                      color: Colors.grey.shade600,
                      fontFamily: "MaisonBook",
                      fontSize: 16.0
                    )),
                    _buildInfoWidget(
                      Icons.wifi, "0 followers, 0 following", fontSize: 16.0
                    )
                  ],
                ),
              )
            ],
          ),
        )
      );
    },
  );

  Widget _aboutTopWidgets(UserInfoState userState) => Column(
    children: [
      SizedBox(
        height: 350.0,
        width: MediaQuery.of(context).size.width,
        child: _getUserImage(userState),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
        child: Text(
          _getUserName(userState),
          style: const TextStyle(
              fontFamily: "MaisonMedium",
              fontSize: 20.0,
              color: Colors.black
          ),
        ),
      ),
      const Divider(height: 0.5,),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Verified info",
              style: TextStyle(
                  fontFamily: "MaisonMedium",
                  fontSize: 16.0,
                  color: Colors.grey.shade500
              ),
            ),
            _buildInfoWidget(
              Icons.check_circle_outline,
              _getAuthMethod(userState, preference: 2),
              fontSize: 16.0
            ),
            _buildInfoWidget(
              Icons.check_circle_outline,
              _getAuthMethod(userState, preference: 1),
              fontSize: 16.0
            )
          ],
        ),
      ),
      const Divider(height: 0.5),
    ],
  );

  Widget reviewWidget() => Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SvgPicture.asset(
        "assets/no_review_star.svg"
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Text(
          "No reivews yet",
          style: TextStyle(
            fontFamily: "MaisonMedium",
            fontSize: 18.0,
            color: Colors.grey.shade600
          ),
        ),
      )
    ],
  );


  _buildInfoWidget(
      IconData icon,
      String value,
      {double fontSize = 14.0}
   ) => Row(
    children: [
      Icon(
        icon,
        color: Colors.grey.shade500,
        size: 18.0,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Text(
          value,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontFamily: "MaisonBook",
            fontSize: fontSize
          ),
        ),
      ),
    ],
  );

  String _getUserName(UserInfoState userState) {
    if(userState is FetchedUserInfoState){
      return userState.userModel.name;
    }else{
      return "";
    }
  }
  
  Widget _noWardrobeWidget() => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(
        height: 120.0,
        width: 120.0,
        child: RiveAnimation.asset(
          "assets/vinted_hanger.riv",
          stateMachines: [
            "State Machine 1"
          ],
        ),
      ),
      const Text(
        "Fill your Vinted wardrobe",
        style: TextStyle(
            fontFamily: "MaisonMedium",
            fontSize: 20.0,
            color: Colors.black87
        ),
        textAlign: TextAlign.center,
      ),
      Padding(
        child: Text(
          "Declutter your life. Sell what you don't wear anymore!",
          style: TextStyle(
              fontFamily: "MaisonMedium",
              fontSize: 16.0,
              color: Colors.grey.shade600
          ),
          textAlign: TextAlign.center,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15.0 ,vertical: 10.0),
      ),
      SizedBox(
        width: 100.0,
        child: buildButton(
            content: "List now",
            buttonColor: getBlueColor(),
            contentColor: Colors.white,
            onPressed: (){

            },
            splashColor: Colors.white.withOpacity(0.2)
        ),
      )
    ],
  );
  
  String _getAuthMethod(UserInfoState userInfoState, {int? preference}){
    if(userInfoState is FetchedUserInfoState){

      if(preference == 1){
        return userInfoState.userModel.authMethod.split(",").first.trim();
      }else if(preference == 2){
        return userInfoState.userModel.authMethod.split(",").last.trim();
      }

      return userInfoState.userModel.authMethod;

    }else{
      return "";
    }
  }

  Widget _getReviewWidget(UserInfoState userInfoState){
    if(userInfoState is FetchedUserInfoState){
      return userInfoState.userModel.review_average != null
      ? Row(
        children: [
          RatingBarIndicator(
            itemPadding: EdgeInsets.zero,
            itemSize: 18.0,
            itemCount: 5,
            rating: double.parse(userInfoState.userModel.review_number!),
            itemBuilder: (context, index){
              return const Icon(
                Icons.star,
                color: Colors.amber,
              );
            },
          ),
          Text(
            " (${userInfoState.userModel.review_number!})",
            style: TextStyle(
              fontFamily: "MaisonBook",
              fontSize: 15.0,
              color: Colors.grey.shade500
            ),
          )
        ],
      )
      : Text(
        "No reviews",
        style: TextStyle(
          fontFamily: "MaisonMedium",
          color: Colors.grey.shade700,
          fontSize: 16
        )
      );
    }else{
      return const SizedBox();
    }
  }


  Widget _getUserImage(UserInfoState userInfoState){
    if(userInfoState is FetchedUserInfoState){
      return userInfoState.userModel.photo != null
        ? Image.network(
          userInfoState.userModel.photo!,
          fit: BoxFit.cover,
        )
        : _noImage();
    }else{
      return _noImage();
    }
  }

  Widget _noImage() => Image.asset(
    "assets/empty_user_photo.jpg",
    fit: BoxFit.cover,
  );
}
