
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:vintedclone/bloc/photo_selector_bloc/photo_selector_bloc.dart';
import 'package:vintedclone/bloc/photo_selector_bloc/photo_selector_state.dart';
import 'package:vintedclone/screens/constants.dart';
import 'album_screen.dart';
import 'package:vintedclone/screens/router/route_names.dart';


enum UploadPhotoScreenEnum{
  sellScreen,
  editProfileScreen
}

class UploadPhotoScreen extends StatelessWidget {

  String albumName;
  MediaPage mediaList;
  PhotoSelectorBloc photoSelectorBloc;

  UploadPhotoScreen(
    this.albumName,
    this.mediaList,
    this.photoSelectorBloc
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: "",
        titleWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: GestureDetector(
            child: Row(
              children: [
                Text(
                  albumName,
                  style: const TextStyle(
                    fontFamily: "MaisonMedium",
                    color: Colors.black87,
                    fontSize: 16.0
                  )
                ),
                const Padding(
                  child: Icon(Icons.keyboard_arrow_down, color: Colors.black87,),
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                )
              ],
            ),
            onTap: () async{
              await PhotoGallery.listAlbums(mediumType: MediumType.image).then((value){
                Navigator.pushReplacementNamed(
                  context,
                  RouteNames.albumScreen,
                  arguments: {
                    "value": value,
                    "childCurrent": this
                  }
                );
              });
            },
          ),
        ),
        trailingWidget: [
          TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text(
              "DONE",
              style: TextStyle(
                color: Colors.grey.shade600
              ),
            )
          )
        ]
      ),
      body: BlocProvider.value(
        value: photoSelectorBloc,
        child:  Column(
          children: [
            Container(
              child: Center(
                child: BlocBuilder<PhotoSelectorBloc, PhotoSelectorState>(
                  builder: (context, state){
                    return Text(
                      "${state.photoList.length.toString()} of 20 selected",
                      style: const TextStyle(
                        fontFamily: "MaisonMedium",
                        color: Colors.black87,
                        fontSize: 16.0
                      )
                    );
                  },
                ),
              ),
              color: Colors.grey.shade50,
              height: 60.0,
              width: MediaQuery.of(context).size.width,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0
                ),
                itemCount: mediaList.items.length,
                itemBuilder: (context, index){
                  return FutureBuilder(
                    future: mediaList.items[index].getFile(),
                    builder: (context, AsyncSnapshot<File> snapshot){
                      return snapshot.hasData
                      ? Builder(
                        builder: (blocContext){
                          return GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: FileImage(
                                    snapshot.data!,
                                  ),
                                  fit: BoxFit.cover
                                )
                              ),
                              child: Stack(
                                children: [
                                  BlocBuilder<PhotoSelectorBloc, PhotoSelectorState>(
                                    builder: (context, state){
                                      return state.photoList.contains(snapshot.data!.path.toString())
                                      ? Positioned(
                                        top: 5.0,
                                        right: 5.0,
                                        child: CircleAvatar(
                                          radius: 10.0,
                                          child: Text((state.photoList.indexOf(snapshot.data!.path.toString()) + 1).toString()),
                                          backgroundColor: getBlueColor(),
                                        ),
                                      )
                                          : SizedBox(height: 0.0,width: 0.0,);
                                    },
                                  )
                                ],
                              ),
                              height: MediaQuery.of(context).size.width / 3,
                              width: MediaQuery.of(context).size.width / 3,
                            ),
                            onTap: (){

                              if(BlocProvider.of<PhotoSelectorBloc>(blocContext).checkPhoto(snapshot.data!.path.toString())){
                                BlocProvider.of<PhotoSelectorBloc>(blocContext).addPhotos(snapshot.data!.path.toString());
                              }else{
                                log(BlocProvider.of<PhotoSelectorBloc>(blocContext).state.photoList.toString());
                                BlocProvider.of<PhotoSelectorBloc>(blocContext).removePhotos(snapshot.data!.path.toString());
                              }
                            },
                          );
                        },
                      )
                      : Container(
                        height: MediaQuery.of(context).size.width / 3,
                        width: MediaQuery.of(context).size.width / 3,
                        color: Colors.grey,
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
