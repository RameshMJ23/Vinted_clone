import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:vintedclone/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:vintedclone/bloc/user_info_bloc/user_info_state.dart';

import '../../bloc/item_bloc/item_bloc.dart';
import '../constants.dart';
import 'item_carousel.dart';

class WardrobeWidget extends StatelessWidget {

  String userId;

  WardrobeWidget({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 25.0),
              child: Text(
                "Wardrobe Spotlight",
                style: TextStyle(
                  fontFamily: "MaisonBook",
                  fontSize: 18.0
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: BlocBuilder<UserInfoBloc, UserInfoState>(
                builder: (context, state){
                  if(state is FetchedUserInfoState){

                    final userInfo = state.userModel;

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: getUserImage(userInfo.photo),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userInfo.name,
                              style: const TextStyle(
                                fontFamily: "MainsonBook"
                              ),
                            ),
                            userInfo.review_average != null
                              ? RatingBarIndicator(
                                itemSize: 15.0,
                                itemCount: 5,
                                rating: double.parse(userInfo.review_average!),
                                itemBuilder: (context, index){
                                  return const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  );
                                },
                              )
                              : Text(
                                "No Reviews"
                              )
                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 32.0,
                          width: 80.0,
                          child: MaterialButton(
                            onPressed: (){

                            },
                            child: Text(
                              "Follow",
                              style: TextStyle(
                                  fontFamily: "MainsonBook",
                                  color: getBlueColor(),
                                  fontSize: 12.0
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(color: getBlueColor())
                            ),
                          ),
                        )
                      ],
                    );
                  }else{
                    return const Center(
                      child: CircularProgressIndicator()
                    );
                  }
                },
              ),
            ),
            BlocProvider(
              create: (context)
                => ItemBloc.userBloc(userId: userId),
              child: ItemCarousel(null, this, context),
            )
          ],
        )
    );
  }


}
