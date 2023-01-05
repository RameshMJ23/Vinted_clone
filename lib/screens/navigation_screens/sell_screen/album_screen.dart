import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:vintedclone/screens/constants.dart';

import '../../router/route_names.dart';

class AlbumScreen extends StatelessWidget {

  List<Album> albumList;

  AlbumScreen(this.albumList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: "Photo albums"),
      body: ListView.separated(
        itemCount: albumList.length,
        itemBuilder: (context, index){
          return ListTile(
            leading: FutureBuilder(
              future: albumList[index].listMedia(),
              builder: (context, AsyncSnapshot<MediaPage> snapShot){
                return snapShot.hasData
                  ? FutureBuilder(
                    future: snapShot.data!.items[0].getFile(),
                    builder: (context, AsyncSnapshot<File> fileSnapShot){
                      return fileSnapShot.hasData
                        ? Container(
                          height: 50.0,
                          width: 50.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            image: DecorationImage(
                              image: FileImage(
                                fileSnapShot.data!,
                              ),
                              fit: BoxFit.fill
                            )
                          ),
                        )
                        : CircleAvatar(
                           radius: 25.0,
                           backgroundColor: Colors.grey.shade400,
                        );
                    }
                  )
                  : CircleAvatar(
                    radius: 25.0,
                    backgroundColor: Colors.grey.shade400
                  );
              },
            ),
            title: Text(albumList[index].name!),
            subtitle: Text(albumList[index].count.toString()),
            onTap: (){
              PhotoGallery.listAlbums(mediumType: MediumType.image).then((albumValue){
                //log();
                albumValue[index].listMedia().then((mediaValue){
                Navigator.pushReplacementNamed(
                  context,
                  RouteNames.photoSelectionScreen, arguments: {
                    "albumName": albumValue[0].name!,
                    "mediaList": mediaValue,
                    "childCurrent": this
                  });
                });
              });
            },
          );
        },
        separatorBuilder: (context, index){
          return Divider();
        },
      ),
    );
  }
}
