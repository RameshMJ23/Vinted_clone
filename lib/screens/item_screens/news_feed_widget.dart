import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vintedclone/bloc/item_bloc/item_bloc.dart';
import 'package:vintedclone/bloc/item_bloc/item_state.dart';
import 'package:vintedclone/screens/router/route_names.dart';

import '../../bloc/carousel_indicator_bloc/carousel_indicator_bloc.dart';
import '../../bloc/user_info_bloc/user_info_bloc.dart';
import '../../bloc/user_info_bloc/user_info_state.dart';
import '../constants.dart';
import 'item_detail_screen.dart';

class NewsFeedWidget extends StatefulWidget {

  int? length;

  ItemBloc itemBloc;

  Widget mainScreenInstance;

  NewsFeedWidget({this.length, required this.itemBloc, required this.mainScreenInstance});

  @override
  _NewsFeedWidgetState createState() => _NewsFeedWidgetState();
}

class _NewsFeedWidgetState extends State<NewsFeedWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => widget.itemBloc,
      child: BlocBuilder<ItemBloc, ItemState>(
          builder: (context, state){
            return (state is FetchedItemState)
            ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.length ?? state.itemList.length,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 350.0
                  ),
                  itemBuilder: (context, index){

                    final item = state.itemList[index];

                    return GestureDetector(
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          color: Colors.transparent,
                          width: 160.0,
                          height: 250,
                          child: BlocProvider(
                            create: (context) => UserInfoBloc(item.user_id),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                BlocBuilder<UserInfoBloc, UserInfoState>(
                                  builder: (context, userState){
                                    return userState is FetchedUserInfoState ? Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          getUserImage(userState.userModel.photo , size: 20.0),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            child: Text(userState.userModel.name),
                                          ),
                                        ],
                                      ),
                                    )
                                    : const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                ),
                                Container(
                                  color: Colors.blue.shade200,
                                  height: 215.0,
                                  width: double.infinity,
                                  child: Image.network(
                                    item.photo[0],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "€" + item.cost.toString(),
                                                  style: const TextStyle(
                                                      fontFamily: "MaisonBook",
                                                      fontSize: 15.0
                                                  ),
                                                ),
                                                GestureDetector(
                                                  child: Icon(
                                                    Icons.info_outline,
                                                    size: 20.0,
                                                    color: Colors.grey.shade600,
                                                  ),
                                                  onTap: (){

                                                  },
                                                ),
                                                item.swapping ? Icon(
                                                  Icons.loop,
                                                  color: Colors.grey.shade500,
                                                  size: 18.0,
                                                ): const SizedBox(height: 0.0,width: 0.0)
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.favorite_border,
                                                  color: Colors.grey.shade500,
                                                  size: 20.0,
                                                ),
                                                Text(
                                                  item.saved,
                                                  style: TextStyle(
                                                      fontFamily: "MaisonBook",
                                                      fontSize: 15.0,
                                                      color: Colors.grey.shade500
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        item.size != null
                                            ? Text(
                                          item.size!,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontFamily: "MaisonBook",
                                            fontSize: 14.0,
                                            color: Colors.grey.shade500,
                                          ),
                                        ): const SizedBox(height: 0.0,width: 0.0,),
                                        Text(
                                          item.brand,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontFamily: "MaisonBook",
                                              fontSize: 14.0,
                                              color: Colors.grey.shade500
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                      ),
                      onTap: (){
                        /*Navigator.push(context, MaterialPageRoute(
                        builder: (_) => MultiBlocProvider(
                            providers: [
                              BlocProvider.value(
                                  value: UserInfoBloc(item.user_id)
                              ),
                              BlocProvider(
                                  create: (context) => CarouselIndicatorBloc()
                              )
                            ],
                            child: ItemDetailScreen(itemModel: item)
                        )
                    ));*/
                        Navigator.of(context, rootNavigator: true)
                            .pushNamed(RouteNames.itemDetailScreen, arguments: {
                          "user_id": item.user_id,
                          "item": item,
                          "childCurrent": widget.mainScreenInstance
                        });
                      },
                    );
                  }
              ),
            )
            : const Center(
              child: CircularProgressIndicator(),
            );
          }
      ),
    );
  }
}
