import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:vintedclone/bloc/auth_bloc/auth_bloc.dart';
import 'package:vintedclone/bloc/auth_bloc/auth_state.dart';
import 'package:vintedclone/bloc/photo_selector_bloc/photo_selector_bloc.dart';
import 'package:vintedclone/bloc/photo_selector_bloc/photo_selector_state.dart';
import 'package:vintedclone/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:vintedclone/bloc/user_info_bloc/user_info_state.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/router/route_names.dart';
import '../../../navigation_screens/sell_screen/upload_photo_screen.dart';

class EditProfileScreen extends StatelessWidget {

  final TextEditingController _aboutMeController = TextEditingController();

  PhotoSelectorBloc photoSelectorBloc;

  EditProfileScreen(this.photoSelectorBloc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: "Edit profile",
        trailingWidget: [
          BlocProvider.value(
            value: photoSelectorBloc,
            child: Builder(
              builder: (blocContext){
                return BlocBuilder<PhotoSelectorBloc, PhotoSelectorState>(
                  bloc: BlocProvider.of<PhotoSelectorBloc>(blocContext),
                  builder: (context, photoState){
                    return GestureDetector(
                      child: const Icon(
                        Icons.check,
                        color: Colors.black87,
                      ),
                      onTap: () async{

                        if(photoState.photoList.isNotEmpty){
                          await BlocProvider.of<PhotoSelectorBloc>(
                            blocContext
                          ).uploadProfilePic(
                            photoState.photoList.first
                          ).then((photoUrl) async{
                            await BlocProvider.of<PhotoSelectorBloc>(
                              blocContext
                            ).changeProfilePic(
                              (BlocProvider.of<AuthBloc>(
                                context
                              ).state as UserState).userId,
                              photoUrl
                            ).then((value){
                              Navigator.pop(context);
                            });
                          });
                        }else{
                          Navigator.pop(context);
                        }

                      },
                    );
                  },
                );
              },
            ),
          )
        ]
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0, vertical: 10.0
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MultiBlocProvider(
                    providers: [
                      BlocProvider.value(
                        value: photoSelectorBloc
                      ),
                      BlocProvider<UserInfoBloc>(
                        create: (context) => UserInfoBloc.currentUser()
                      )
                    ],
                    child: Builder(
                      builder: (blocContext){
                        return Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: BlocBuilder<UserInfoBloc, UserInfoState>(
                            bloc: BlocProvider.of<UserInfoBloc>(blocContext),
                            builder: (context, userInfoState){
                              return BlocBuilder<PhotoSelectorBloc, PhotoSelectorState>(
                                bloc: BlocProvider.of<PhotoSelectorBloc>(blocContext),
                                builder: (context, photoState){

                                  if(userInfoState is FetchedUserInfoState
                                    && photoState.photoList.isEmpty){
                                    return getUserImage(
                                      userInfoState.userModel.photo,
                                      size: 55.0,
                                      borderRadius: 50.0
                                    );
                                  }else if(userInfoState is FetchedUserInfoState
                                      && photoState.photoList.isNotEmpty){

                                    return getUserImage(
                                      null,
                                      size: 55.0,
                                      borderRadius: 50.0,
                                      assetWidget: FileImage(
                                        File(photoState.photoList.first),
                                      )
                                    );
                                  }else{
                                    return getUserImage(
                                      null,
                                      size: 55.0,
                                      borderRadius: 50.0
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        );
                      }
                    )
                  ),
                  const Text(
                    "Change photo",
                    style: TextStyle(
                      fontFamily: "MaisonMedium",
                      color: Colors.black87,
                      fontSize: 16.0
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15.0,
                    color: Colors.grey.shade500,
                  )
                ],
              ),
            ),
            onTap: () async{
              await Permission.storage.request().then((value) async{
                if(value == PermissionStatus.granted){
                  await PhotoGallery.listAlbums(
                    mediumType: MediumType.image,
                  ).then((albumValue) {
                    albumValue[0].listMedia().then((mediaValue){
                      Navigator.pushNamed(
                        context,
                        RouteNames.photoSelectionScreen, arguments: {
                        "albumName": albumValue[0].name!,
                        "mediaList": mediaValue,
                        "uploadPhotoScreenEnum": UploadPhotoScreenEnum.editProfileScreen
                      });
                    });
                  });
                }
              });
            },
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTextFieldLabel(textFieldName: "About me"),
                SizedBox(
                  height: 120.0,
                  child: buildTextField(
                    hintText: "Tell us more about yourself and your style",
                    controller: _aboutMeController,
                    validatorFunc: (val) => null,
                    multiLine: true
                  ),
                )
              ],
            ),
          ),
          getSpacingWidget(context),
          Column(
            children: [
              BlocProvider<UserInfoBloc>(
                create: (context) => UserInfoBloc.currentUser(),
                child: Builder(
                  builder: (blocContext){
                    return BlocBuilder<UserInfoBloc, UserInfoState>(
                      builder: (context, userState){
                        return userState is FetchedUserInfoState
                        ? buildGuideWithMultiTrail(
                          title: "My location",
                          trailingText: userState.userModel.location ?? "No location",
                          onTap: (){
                            Navigator.of(context, rootNavigator: true).pushNamed(
                              RouteNames.countriesScreen,
                              arguments: {
                                "childCurrent": this,
                              }
                            );
                          }
                        )
                        : const SizedBox();
                      },
                    );
                  },
                ),
              ),
              Divider(color: Colors.grey.shade300, height: 0.5,)
            ],
          ),
          getSwitchListTile(tileName: "Show city in profile", isSelected: true),

        ],
      ),
    );
  }


}
