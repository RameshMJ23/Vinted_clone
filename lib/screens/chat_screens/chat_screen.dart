import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:vintedclone/bloc/auth_bloc/auth_bloc.dart';
import 'package:vintedclone/bloc/auth_bloc/auth_state.dart';
import 'package:vintedclone/bloc/chat_bloc/input_validator_bloc/input_validator_bloc.dart';
import 'package:vintedclone/bloc/item_bloc/item_detail/item_detail_bloc.dart';
import 'package:vintedclone/bloc/item_bloc/item_detail/item_detail_state.dart';
import 'package:vintedclone/bloc/product_info_bloc/product_info_state.dart';
import 'package:vintedclone/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:vintedclone/bloc/user_info_bloc/user_info_state.dart';
import 'package:vintedclone/data/model/message_model.dart';
import 'package:vintedclone/data/model/user_model.dart';
import 'package:vintedclone/data/service/shared_pref_service.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/router/route_names.dart';
import 'package:vintedclone/bloc/chat_bloc/chat_bloc.dart';
import '../../bloc/item_bloc/item_detail/item_detail_bloc.dart';
import '../../bloc/product_info_bloc/product_info_bloc.dart';

class ChatScreen extends StatelessWidget {

  AuthBloc authBloc;

  StreamChatClient client;

  Channel channel;

  ValueNotifier<Message?> lastMessageNotifier = ValueNotifier<Message?>(null);

  ChatScreen(
    this.authBloc,
    this.client,
    this.channel
  );

  @override
  Widget build(BuildContext context) {
    
    return StreamChannel(
      channel: channel,
      child: StreamChatCore(
        client: client,
        child:  MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: authBloc
              ),
            ],
            child: Builder(
              builder: (blocContext){
                return Scaffold(
                  resizeToAvoidBottomInset: true,
                  appBar: getAppBar(
                      context: context,
                      title: ChatBloc.getChannelName(
                        channel,
                        blocContext.currentUser!
                      ),
                      trailingWidget: [
                        ValueListenableBuilder(
                          valueListenable: lastMessageNotifier,
                          builder: (BuildContext context, Message? message, Widget? child){
                            return IconButton(
                              onPressed: (){
                                Navigator.pushNamed(
                                  context,
                                  RouteNames.chatInfoScreen,
                                  arguments: {
                                    "childCurrent": this,
                                    "channel": channel,
                                    "userId": (
                                      BlocProvider.of<AuthBloc>(
                                          blocContext
                                      ).state as UserState
                                    ).userId,
                                    "ownerId": ChatBloc.getOtherUser(
                                      channel, blocContext.currentUser!
                                    ),
                                    "ownerName": ChatBloc.getChannelName(
                                      channel, blocContext.currentUser!
                                    ),
                                    "lastMessage": message
                                  }
                                );
                              },
                              icon: const Icon(
                                Icons.info_outline, color: Colors.black87,
                              )
                            );
                          }
                        )
                      ]
                  ),
                  body: Column(
                    children: [
                      ValueListenableBuilder(
                        valueListenable: lastMessageNotifier,
                        builder: (BuildContext context, Message? message, Widget? child){
                          return _ProductInfoWidget(
                            childCurrent: this,
                            itemDetailBloc: ItemDetailBloc(),
                            lastMessage: message,
                            channel: channel,
                            mainScreenInstance: this,
                          );
                        },
                      ),
                      const Divider(
                        height: 0.4,
                        thickness: 1.2,
                      ),
                      Expanded(
                        child: MessageListCore(
                          errorBuilder: (context, error){
                            return Center(
                              child: Text(
                                "Some error occured $error"
                              ),
                            );
                          },
                          loadingBuilder: (context){
                            return Center(
                              child: CircularProgressIndicator(
                                color: getBlueColor(),
                              ),
                            );
                          },
                          emptyBuilder: (context){
                            return const Center(
                              child: Text(
                                "No messages yet!"
                              ),
                            );
                          },
                          messageListBuilder: (context, messages){

                            WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                              lastMessageNotifier.value = _getLastMessage(messages);
                            });

                            return _MessageList(
                              client: client,
                              messages: messages,
                              userAuthId: (
                                BlocProvider.of<AuthBloc>(blocContext).state as UserState
                              ).userId,
                              //userAuthId: "abc",
                            );
                          },
                        ),
                      ),
                      buildTextButton(
                        content: "Translate this conversation",
                        onPressed: (){

                        }
                      ),
                      ValueListenableBuilder(
                        valueListenable: lastMessageNotifier,
                        builder: (
                          BuildContext context,
                          Message? message,
                          Widget? child
                        ){
                          return _TextBox(
                            userId: (
                              BlocProvider.of<AuthBloc>(blocContext).state as UserState
                            ).userId,
                            inputValidatorBloc: InputValidatorBloc(),
                            ownerId: ChatBloc.getOtherUser(channel, blocContext.currentUser!),
                            ownerName: ChatBloc.getChannelName(channel, blocContext.currentUser!),
                            channel: channel,
                            lastMessage: message,
                          );
                        }
                      )
                    ],
                  ),
                );
              },
            )
        ),
      ),
    );
  }

  Message? _getLastMessage(List<Message> message){
    List<Message> lastMessageList = message.where((message){
      return (message.extraData[MessageModel.offerMessageString] != null
        && message.extraData[MessageModel.offerMessageString] as bool
      );
    }).toList();

    if(lastMessageList.isEmpty){
      return null;
    }else{
      return lastMessageList.first;
    }
  }
}

class _ProductInfoWidget extends StatelessWidget {

  ItemDetailBloc itemDetailBloc;

  Widget childCurrent;

  Message? lastMessage;

  Channel channel;

  Widget mainScreenInstance;

  _ProductInfoWidget({
    required this.childCurrent,
    required this.itemDetailBloc,
    required this.lastMessage,
    required this.channel,
    required this.mainScreenInstance
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: itemDetailBloc,
        )
      ],
      child:  Builder(
        builder: (blocContext){
          return BlocBuilder<ItemDetailBloc, ItemDetailState>(
            builder: (context, totalCostState){

              if(totalCostState.productIdList != null){
                return totalCostState.photoUrl!.length > 1
                ? _multiProductWidget(
                    ProductInfoBloc(
                      totalCostState.productIdList!.first
                    ),
                    context,
                    totalCostState.productIdList!.length.toString(),
                    totalCostState.itemCost!.toString(),
                    lastMessage,
                    channel,
                    mainScreenInstance
                  )
                : _singleProductWidget(
                  ProductInfoBloc(
                    totalCostState.productIdList!.first
                  ),
                  context
                );
              }else{
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        },
      )
    );
  }

  Widget _singleProductWidget(
    ProductInfoBloc productBloc,
    BuildContext context
  ) => BlocProvider.value(
    value: productBloc,
    child: Builder(
      builder: (blocContext){
        return BlocBuilder<ProductInfoBloc, ProductInfoState>(
          builder: (context, productState){
            return GestureDetector(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 12.0
                ),
                height: 80.0,
                width: double.infinity,
                child: productState is FetchedProductInfoState
                ? Row(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8.0
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        image: DecorationImage(
                          image: NetworkImage(
                            productState.itemModel.photo.first,
                          ),
                          fit: BoxFit.fill
                        ),
                        //color: Colors.grey
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productState.itemModel.item_title,
                          style: TextStyle(
                            fontFamily: "MaisonMedium",
                            color: Colors.grey.shade800,
                            fontSize: 16.0,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "€${productState.itemModel.cost}",
                              style: TextStyle(
                                fontFamily: "MaisonBook",
                                color: Colors.grey.shade800,
                                fontSize: 16.0,
                              ),
                            ),
                            IconButton(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 3.0
                              ),
                              visualDensity: const VisualDensity(
                                  horizontal: -4,
                                  vertical: -4
                              ),
                              icon: Icon(
                                  Icons.info_outline,
                                  color: Colors.grey.shade700
                              ),
                              onPressed: (){

                              },
                            )
                          ],
                        )
                      ],
                    )
                  ],
                )
                : const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              onTap: (){
                if(productState is FetchedProductInfoState){
                  Navigator.of(context)
                      .pushNamed(RouteNames.itemDetailScreen, arguments: {
                    "user_id": productState.itemModel.user_id,
                    "item": productState.itemModel,
                    "childCurrent": childCurrent
                  });
                }
              },
            );
          },
        );
      },
    ),
  );

  Widget _multiProductWidget(
    ProductInfoBloc productBloc,
    BuildContext context,
    String numberOfItems,
    String totalCost,
    Message? message,
    Channel channel,
    Widget mainScreenInstance
  ) => BlocProvider.value(
    value: productBloc,
    child: Builder(
      builder: (blocContext){
        return GestureDetector(
          child: Container(
            padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 12.0
            ),
            height: 80.0,
            width: double.infinity,
            child: Row(
              children: [
                BlocBuilder<ProductInfoBloc, ProductInfoState>(
                  builder: (context, productState){
                    return Container(
                      height: 60,
                      width: 60,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8.0
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        image: (productState is FetchedProductInfoState)
                            ? DecorationImage(
                            image: NetworkImage(
                              productState.itemModel.photo.first,
                            ),
                            fit: BoxFit.fill
                        ) : null, //color: Colors.grey
                      ),
                      child: Container(
                        color: Colors.black26,
                        child: Center(
                          child: Text(
                            numberOfItems,
                            style: const TextStyle(
                                fontFamily: "MaisonMedium",
                                color: Colors.white,
                                fontSize: 16.0
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$numberOfItems items" ,
                      style: TextStyle(
                        fontFamily: "MaisonMedium",
                        color: Colors.grey.shade800,
                        fontSize: 16.0,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "€$totalCost",
                          style: TextStyle(
                            fontFamily: "MaisonBook",
                            color: Colors.grey.shade800,
                            fontSize: 16.0,
                          ),
                        ),
                        IconButton(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 3.0
                          ),
                          visualDensity: const VisualDensity(
                              horizontal: -4,
                              vertical: -4
                          ),
                          icon: Icon(
                              Icons.info_outline,
                              color: Colors.grey.shade700
                          ),
                          onPressed: (){

                          },
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          onTap: (){

            Navigator.pushNamed(
                context,
                RouteNames.chatInfoScreen,
                arguments: {
                  "childCurrent": mainScreenInstance,
                  "channel": channel,
                  "userId": (
                    BlocProvider.of<AuthBloc>(
                        blocContext
                    ).state as UserState
                  ).userId,
                  "ownerId": ChatBloc.getOtherUser(
                    channel, blocContext.currentUser!
                  ),
                  "ownerName": ChatBloc.getChannelName(
                    channel, blocContext.currentUser!
                  ),
                  "lastMessage": message
                }
            );
          },
        );
      },
    ),
  );
}


class _MessageList extends StatelessWidget {

  List<Message> messages;
  String userAuthId;
  StreamChatClient client;

  _MessageList({
    required this.messages,
    required this.userAuthId,
    required this.client
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      reverse: true,
      itemBuilder: (context, index){

        Message message = messages[index];

        if(message.extraData[MessageModel.bundleInfoMessage] != null
         && message.extraData[MessageModel.bundleInfoMessage] as bool){
          return _BundleNotificationTile(message);
        }

        if(message.extraData[MessageModel.senderIdString] == userAuthId){
          if(message.extraData[MessageModel.offerMessageString] != null
              && message.extraData[MessageModel.offerMessageString] == true){
            return BlocProvider(
              create: (context) => UserInfoBloc(
                StreamChannel.of(context).channel.extraData["owner_id"] as String
              ),
              child: _OfferTile(message: message),
            );
          }

          return _MessageOwnTile(message: message);
        }else{
          if(message.extraData[MessageModel.introMessageString] != null
              && message.extraData[MessageModel.introMessageString] == true){
            return BlocProvider<UserInfoBloc>(
              create: (context) => UserInfoBloc(
                message.extraData[MessageModel.senderIdString] as String
              ),
              child: StreamChatCore(
                client: client,
                child: _IntroTile(message: message),
              ),
            );
          }
          
          return _MessageTile(message: message);
        }

      },
    );
  }
}

class _BundleNotificationTile extends StatelessWidget {

  Message message;

  _BundleNotificationTile(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15.0),
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: Colors.grey.shade300)
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.text ?? "",
            style: const TextStyle(
              fontFamily: "MaisonMedium",
              fontSize: 16.0,
              color: Colors.black87
            ),
          ),
          const SizedBox(height: 5.0,),
          Text(
            "We have notified abv that you want to buy this bundle. Wait for "
                "them to confirm the parcel size.",
            style: TextStyle(
              fontFamily: "MaisonBook",
              fontSize: 16.0,
              color: Colors.grey.shade600
            ),
          ),
          const SizedBox(height: 15.0,),
        ],
      ),
    );
  }
}


class _MessageTile extends StatelessWidget {

  _MessageTile({
    Key? key,
    required this.message,
  }) : super(key: key);

  Message message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 5.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.0),
              child: CircleAvatar(
                radius: 15.0,
                child: Text(
                  "R"
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(3.0),
                border: Border.all(color: Colors.grey.shade300)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 10.0
                ),
                child: Text(
                  message.text ?? "",
                  style: TextStyle(
                    fontFamily: "MaisonMedium",
                    color: Colors.grey.shade700
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _IntroTile extends StatelessWidget {

  _IntroTile({
    Key? key,
    required this.message,
  }) : super(key: key);

  Message message;

  @override
  Widget build(BuildContext context) {

    final channel = StreamChannel.of(context).channel;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 5.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: BlocBuilder<UserInfoBloc, UserInfoState>(
          builder: (context, userState){
            return (userState is FetchedUserInfoState)
            ? Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.0),
                  child: CircleAvatar(
                    radius: 15.0,
                    child: Text(
                      "R"
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3.0),
                    border: Border.all(color: Colors.grey.shade300)
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 10.0
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Text(
                          "Hey! I'm ${userState.userModel.name}",
                          style: TextStyle(
                            fontFamily: "MaisonMedium",
                            color: Colors.grey.shade800,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      reviewWidget(userState.userModel),
                      _locationWidget(),
                      lastSeenWidget(
                        channel,
                        TextStyle(
                          fontFamily: "MaisonMedium",
                          color: Colors.grey.shade600,
                          fontSize: 16.0
                        )
                      )
                    ],
                  ),
                )
              ],
            )
            : _MessageTile(message: message);
          },
        ),
      ),
    );
  }

  Widget _locationWidget() => Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      children: [
        Icon(
          Icons.location_on_outlined,
          size: 18.0,
          color: Colors.grey.shade600
        ),
        const SizedBox(width: 3.0,),
        Text(
          "Distance: Lietuva, Vilnius",
          style: TextStyle(
            fontFamily: "MaisonMedium",
            color: Colors.grey.shade600,
            fontSize: 16.0
          )
        )
      ],
    ),
  );



  Widget reviewWidget(UserModel userModel) => userModel.review_average != null
  ? Row(
    children: [
      RatingBarIndicator(
        itemPadding: EdgeInsets.zero,
        itemSize: 18.0,
        itemCount: 5,
        rating: double.parse(userModel.review_number!),
        itemBuilder: (context, index){
          return const Icon(
            Icons.star,
            color: Colors.amber,
          );
        },
      ),
      Text(
        "${userModel.review_number!} reviews",
        style: TextStyle(
          fontFamily: "MaisonBook",
          fontSize: 15.0,
          color: Colors.grey.shade600
        ),
      )
    ],
  )
  : Text(
    "No reviews",
    style:  TextStyle(
      fontFamily: "MaisonMedium",
      fontSize: 16.0,
      color: Colors.grey.shade600
    ),
  );
}


class _MessageOwnTile extends StatelessWidget {

  _MessageOwnTile({
    Key? key,
    required this.message
  }) : super(key: key);

  Message message;

  @override
  Widget build(BuildContext context) {

    //final channel = StreamChannel.of(context).channel;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(3.0),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0, vertical: 10.0
          ),
          child: Text(
            message.text!,
            style: TextStyle(
              fontFamily: "MaisonMedium",
              color:Colors.grey.shade700,
              fontSize: 15.0
            )
          ),
        ),
      ),
    );
  }
}


class _OfferTile extends StatelessWidget {

  _OfferTile({
    Key? key,
    required this.message
  }) : super(key: key);

  Message message;

  @override
  Widget build(BuildContext context) {

    //final channel = StreamChannel.of(context).channel;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(3.0),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0, vertical: 10.0
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<UserInfoBloc, UserInfoState>(
                    builder: (context, userState){
                      return (userState is FetchedUserInfoState)
                      ? Text(
                        "You've offered ${userState.userModel.name}:",
                        style: TextStyle(
                          fontFamily: "MaisonMedium",
                          color:Colors.grey.shade700,
                          fontSize: 15.0
                        )
                      )
                      : const SizedBox();
                    },
                  ),
                  _offerText(message)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _offerText(Message message){

    TextStyle textStyle = TextStyle(
        fontFamily: "MaisonMedium",
        color:Colors.grey.shade900,
        fontSize: 15.0
    );

    String content = "€" + message.text!;

    if(message.extraData[MessageModel.offerAvailString] != null
      && message.extraData[MessageModel.offerAvailString] as bool){
      return Text(
        content,
        style: textStyle,
      );
    }else{
      return RichText(
        text: TextSpan(
          text: content,
          style: textStyle.copyWith(
            decoration: TextDecoration.lineThrough,
            fontSize: 17.0
          ),
          children: [
            TextSpan(
              text: " Declined",
              style: textStyle.copyWith(
                color: Colors.grey.shade600,
                fontSize: 17.0,
                decoration: TextDecoration.none
              )
            )
          ]
        ),
      );
    }
  }
}


class _TextBox extends StatelessWidget {

  String userId;

  InputValidatorBloc inputValidatorBloc;

  String ownerId;

  String ownerName;

  Channel channel;

  Message? lastMessage;

  _TextBox({
    required this.userId,
    required this.inputValidatorBloc,
    required this.ownerId,
    required this.ownerName,
    required this.channel,
    required this.lastMessage
  });

  final TextEditingController _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: inputValidatorBloc,
      child: Builder(
        builder: (blocContext){
          return Card(
            elevation: 0.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    controller: _inputController,
                    decoration: InputDecoration(
                      border: _inputTextFieldBorder(),
                      enabledBorder: _inputTextFieldBorder(),
                      focusedBorder: _inputTextFieldBorder(),
                      fillColor: Colors.grey.withOpacity(0.3),
                      filled: true,
                      hintText: "Write a message here",
                      hintStyle: const TextStyle(
                        fontFamily: "MaisonBook"
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 8.0
                      ),
                    ),
                    style: const TextStyle(
                      fontFamily: "MaisonBook"
                    ),
                    onChanged: (input){
                      BlocProvider.of<InputValidatorBloc>(blocContext).typingText(input);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.grey.shade500,
                            ),
                            onPressed: (){

                            },
                            visualDensity: const VisualDensity(
                              horizontal: -4, vertical: -4
                            ),
                          ),
                          BlocProvider(
                            create: (_) => UserInfoBloc.currentUser(),
                            child: Builder(
                              builder: (blocContext){
                                return BlocBuilder<UserInfoBloc, UserInfoState>(
                                  bloc: BlocProvider.of<UserInfoBloc>(blocContext),
                                  builder: (context, userState){
                                    return (userState is FetchedUserInfoState)
                                    ? IconButton(
                                      icon: Icon(
                                        Icons.add_box_outlined,
                                        color: Colors.grey.shade500,
                                      ),
                                      onPressed: () async {

                                        List<String> itemsToBuy = List.from(
                                          userState.userModel.item_to_buy
                                        ).cast<String>();

                                        await SharedPref().setInitialValue(
                                          itemsToBuy
                                        ).then((value){
                                          Navigator.pushNamed(
                                            context,
                                            RouteNames.addItemScreen,
                                            arguments:{
                                              "childCurrent": this,
                                              "ownerId": ownerId,
                                              "ownerName": ownerName,
                                              "channel": channel,
                                              "lastMessage": lastMessage
                                            }
                                          );
                                        });

                                      },
                                      visualDensity: const VisualDensity(
                                        horizontal: -4, vertical: -4
                                      ),
                                    )
                                    : const SizedBox.shrink();
                                  },
                                );
                              },
                            ),
                          )
                        ],
                      ),
                      BlocBuilder<InputValidatorBloc, String?>(
                        bloc: BlocProvider.of<InputValidatorBloc>(blocContext),
                        builder: (context, inputState){
                          return buildTextButton(
                            enabled: (inputState != null && inputState.isNotEmpty)
                              ? true
                              : false,
                            content: "Send",
                            onPressed: (inputState != null && inputState.isNotEmpty)
                            ? (){
                              _sendMessage(context, userId);
                            }
                            : null
                          );
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _sendMessage(BuildContext context, String userId) async{
    await StreamChannel.of(context).channel.sendMessage(
      Message(
        text: _inputController.text,
        extraData:  MessageModel.modelToJson(
          MessageModel(
            senderId: userId,
            offerMessage: false,
          )
        )
      )
    ).then((value){
      _inputController.clear();
    });
  }

  OutlineInputBorder _inputTextFieldBorder() => OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.transparent),
    borderRadius: BorderRadius.circular(5.0)
  );
}



