
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vintedclone/bloc/user_info_bloc/user_info_state.dart';
import 'package:vintedclone/data/model/item_model.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/router/route_names.dart';
import '../../bloc/item_bloc/item_bloc.dart';
import '../../bloc/item_bloc/item_state.dart';
import '../../bloc/user_info_bloc/user_info_bloc.dart';


enum ItemDetailEnum{
  membersItems,
  similarItems,
  addItems
}

class OtherItems extends StatelessWidget {

  ItemDetailEnum itemDetailEnum;

  String? ownerName;

  ItemBloc? itemBloc;

  OtherItems({
    required this.itemDetailEnum,
    this.ownerName,
    this.itemBloc
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemBloc, ItemState>(
      builder: (context, state){
        return _mainWidget(state);
      },
    );
  }

  Widget _mainWidget(ItemState state){
    return (state is FetchedItemState)
    ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        itemDetailEnum == ItemDetailEnum.addItems ? Column(
          children: [
            _headerWidget(ownerName),
            _subHeaderWidget()
          ],
        ): const SizedBox(height: 0.0, width: 0.0),
        itemDetailEnum == ItemDetailEnum.membersItems
            ? _memberItemTile() : const SizedBox(height: 0.0, width: 0.0),
        Expanded(
          child: _itemWidget(
              state: state,
              itemDetailEnum: itemDetailEnum
          ) ,
        )
      ],
    )
        : _loadingWidget();
  }

  Widget _headerWidget(String? ownerName) => Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0,),
      child: Text(
        "Create a bundle from items in \n $ownerName's wardrobe",
        style: TextStyle(
          fontFamily: "MaisonMedium",
          fontSize: 16.0,
          color: Colors.grey.shade600
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );

  Widget _subHeaderWidget() => Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: RichText(
      text: TextSpan(
        text: "If you want to learn more, please read our ",
        style: TextStyle(
          fontFamily: "MaisonBook",
          color: Colors.grey.shade600
        ),
        children:[
          TextSpan(
            text: "bundle policy",
            style: TextStyle(
              fontFamily: "MaisonBook",
              color: getBlueColor(),
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()..onTap = (){

            }
          )
        ]
      )
    ),
  );

  Widget _itemWidget({
    required FetchedItemState state,
    required ItemDetailEnum itemDetailEnum
  }) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    child: GridView.builder(
        physics: itemDetailEnum == ItemDetailEnum.addItems
          ? null
          : const NeverScrollableScrollPhysics(),
        itemCount: state.itemList.length,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: (itemDetailEnum == ItemDetailEnum.addItems)
            ? 350.0 : 320.0,
        ),
        itemBuilder: (context, index){

          final item = state.itemList[index];

          return GestureDetector(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              color: Colors.transparent,
              width: 160.0,
              height: (itemDetailEnum == ItemDetailEnum.addItems)
                ? 250 : 230,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _imageWidget(item.photo[0]),
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
                              _itemCostWidget(item),
                              _favAndSavedWidget(item)
                            ],
                          ),
                          //Altered for chat bundle widget
                          Container(
                            height: 45.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _sizeWidget(itemDetailEnum, item.size),
                                _brandWidget(item.brand)
                              ],
                            ),
                          ),
                          Expanded(
                            child: BlocProvider(
                              create: (_) => UserInfoBloc.currentUser(),
                              child: BlocBuilder<UserInfoBloc, UserInfoState>(
                                builder: (context, userState){
                                  return Builder(
                                    builder: (blocContext){
                                      return (userState is FetchedUserInfoState)
                                        ? _addItemWidget(
                                          blocContext,
                                          userState,
                                          item.product_id!
                                        )
                                        : const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                    },
                                  );
                                },
                              )
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            onTap: (){
              Navigator.of(context)
                  .pushNamed(RouteNames.itemDetailScreen, arguments: {
                "user_id": item.user_id,
                "item": item,
                "childCurrent": this
              });
            },
          );
        }
    ),
  );

  Widget _favAndSavedWidget(ItemModel item) => Row(
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
  );

  Widget _itemCostWidget(ItemModel item) => Row(
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
  );

  Widget _imageWidget(String url){
    return  Container(
      color: Colors.blue.shade200,
      height: 215.0,
      width: double.infinity,
      child: Image.network(
        url,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _sizeWidget(ItemDetailEnum itemDetailEnum, String? size) {
    return size != null ? Text(
      size,
      textAlign: TextAlign.start,
      style: TextStyle(
        fontFamily: "MaisonBook",
        fontSize: 14.0,
        color: Colors.grey.shade500,
      ),
    ): const SizedBox();
  }

  Widget _brandWidget(String brand) => Text(
    brand,
    textAlign: TextAlign.start,
    style: TextStyle(
      fontFamily: "MaisonBook",
      fontSize: 14.0,
      color: Colors.grey.shade500
    ),
  );

  Widget _addItemWidget(
    BuildContext context,
    FetchedUserInfoState userInfoState,
    String productId
  ) {

    bool containsItem = userInfoState.userModel.item_to_buy.contains(productId);

    return buildButton(
      content: containsItem ? "Remove" : "Add",
      buttonColor: Colors.transparent,
      contentColor: containsItem ? Colors.red.shade300 : getBlueColor(),
      onPressed: () async{
        if(containsItem){
          await BlocProvider.of<UserInfoBloc>(context).removeItemToBuy(
            userInfoState.userModel.user_id,
            productId,
            userInfoState.userModel.item_to_buy
          );
        }else{
          await BlocProvider.of<UserInfoBloc>(context).addItemsToBuy(
            userInfoState.userModel.user_id,
            productId,
            userInfoState.userModel.item_to_buy
          );
        }
      },
      splashColor: containsItem
        ? Colors.red.withOpacity(0.2)
        : getBlueColor().withOpacity(0.2),
      side: true,
      sideColor: containsItem ? Colors.red.shade300 : getBlueColor(),
      fontSize: 12.0,
      verticalPadding: 4.0
    );
  }

  Widget _loadingWidget() => const Center(
    child: CircularProgressIndicator(),
  );

  Widget _memberItemTile() {
    return ListTile(
      title: const Text(
        "Shop bundels",
        style: TextStyle(
          fontFamily: "MaisonMedium",
          color: Colors.black87
        ),
      ),
      subtitle: Text(
        "Get up to 10% off",
        style: TextStyle(
          fontFamily: "MaisonMedium",
          color: Colors.grey.shade600
        ),
      ),
      trailing: SizedBox(
        width: 85.0,
        child: buildButton(
          content: "Shop",
          buttonColor: getBlueColor(),
          contentColor: Colors.white,
          onPressed: (){

          },
          splashColor: getBlueColor().withOpacity(0.15)
        ),
      ),
    );
  }
}
