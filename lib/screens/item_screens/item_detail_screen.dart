import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:vintedclone/bloc/carousel_indicator_bloc/carousel_indicator_bloc.dart';
import 'package:vintedclone/bloc/item_bloc/item_bloc.dart';
import 'package:vintedclone/bloc/scroll_bloc/scroll_bloc.dart';
import 'package:vintedclone/bloc/see_more_bloc/see_more_bloc.dart';
import 'package:vintedclone/bloc/translation_bloc/translation_bloc.dart';
import 'package:vintedclone/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:vintedclone/data/model/item_model.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/router/route_names.dart';
import 'member_items_widget.dart';

import '../../bloc/chat_bloc/chat_bloc.dart';
import '../../bloc/user_info_bloc/user_info_state.dart';

class ItemDetailScreen extends StatefulWidget {

  ItemModel itemModel;
  UserInfoBloc userInfoBloc;
  CarouselIndicatorBloc carouselIndicatorBloc;
  ScrollBloc scrollBloc;
  SeeMoreBloc seeMoreBloc;

  ItemDetailScreen({
    required this.itemModel,
    required this.userInfoBloc,
    required this.carouselIndicatorBloc,
    required this.scrollBloc,
    required this.seeMoreBloc
  });

  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen>
                                  with SingleTickerProviderStateMixin{

  late TabController _tabController;

  late ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState

    _scrollController = ScrollController();


    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: widget.userInfoBloc),
        BlocProvider.value(value: widget.carouselIndicatorBloc),
        BlocProvider.value(value: widget.scrollBloc),
        BlocProvider.value(value: widget.seeMoreBloc)
      ],
      child: Builder(
        builder: (blocContext){

          _scrollController.addListener(() {
            BlocProvider.of<ScrollBloc>(blocContext).changeScrollOffset(_scrollController.offset);
          });

          return SafeArea(
            child: Scaffold(
              appBar: PreferredSize(
                child: BlocBuilder<ScrollBloc, double>(
                  bloc: BlocProvider.of<ScrollBloc>(blocContext),
                  builder: (context, state){
                    return Container(
                      height: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: (state / 350.0).clamp(0, 1) > 0.5
                                    ? Colors.black87
                                    : Colors.white,
                                )
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Text(
                                  widget.itemModel.item_title,
                                  style: TextStyle(
                                    fontFamily: "MaisonMedium",
                                    fontSize: 18.0,
                                    color: Colors.black87.withOpacity((state / 350.0).clamp(0, 1))
                                  ),
                                ),
                              )
                            ],
                          ),
                          Icon(
                            Icons.more_vert,
                            color: (state / 350.0).clamp(0, 1) > 0.5
                              ? Colors.black87
                              : Colors.white
                          )
                        ],
                      ),
                      color: Colors.white70.withOpacity((state / 350.0).clamp(0, 1)),
                    );
                  },
                ),
                preferredSize: Size(
                  MediaQuery.of(context).size.width,
                  55.0
                ),
              ),
              extendBodyBehindAppBar: true,
              body: ListView(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                children: [
                  Stack(
                    children: [
                      CarouselSlider.builder(
                        itemCount: widget.itemModel.photo.length,
                        itemBuilder: (context, index, pageIndex){
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            child: Image.network(
                              widget.itemModel.photo[index],
                              fit: BoxFit.fill,
                              loadingBuilder: (context, child, event){
                                return event != null ? Center(
                                  child: SizedBox(
                                    child: CircularProgressIndicator(
                                      color: getBlueColor(),
                                      strokeWidth: 2,
                                    ),
                                    height: 20.0,
                                    width: 20.0,
                                  ),
                                )
                                : child;
                              },
                            ),
                            color: Colors.grey.shade100,
                          );
                        },
                        options: CarouselOptions(
                          padEnds: false,
                          height: 480,
                          aspectRatio: 16/9,
                          viewportFraction: 1,
                          initialPage: 0,
                          enableInfiniteScroll: false,
                          reverse: false,
                          autoPlay: false,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: false,
                          onPageChanged: (index, _){
                            BlocProvider.of<CarouselIndicatorBloc>(blocContext).changeIndex(index);
                          },
                          scrollDirection: Axis.horizontal,
                        )
                      ),
                      Positioned.fill(
                        bottom: 25.0,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: BlocBuilder<CarouselIndicatorBloc, int>(
                            bloc: BlocProvider.of<CarouselIndicatorBloc>(blocContext),
                            builder: (context, index){
                              return AnimatedSmoothIndicator(
                                activeIndex: index,
                                count: widget.itemModel.photo.length,
                                axisDirection: Axis.horizontal,
                                effect: const SlideEffect(
                                  dotColor: Colors.grey,
                                  activeDotColor: Colors.white,
                                  radius: 10.0,
                                  dotWidth: 10.0,
                                  dotHeight: 10.0
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            BlocBuilder<UserInfoBloc, UserInfoState>(
                              bloc: BlocProvider.of<UserInfoBloc>(blocContext),
                              builder: (context, state){
                                return state is FetchedUserInfoState ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    getUserImage(null, size: 50.0),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(state.userModel.name),
                                          state.userModel.review_average != null
                                          ? Row(
                                            children: [
                                              RatingBarIndicator(
                                                itemPadding: EdgeInsets.zero,
                                                itemSize: 18.0,
                                                itemCount: 5,
                                                rating: double.parse(state.userModel.review_number!),
                                                itemBuilder: (context, index){
                                                  return const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  );
                                                },
                                              ),
                                              Text(
                                                " (${state.userModel.review_number!})",
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
                                            style:  TextStyle(
                                              fontFamily: "MaisonMedium",
                                              fontSize: 15.0,
                                              color: Colors.grey.shade500
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                                : const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                            SizedBox(
                              height: 50.0,
                              width: 100.0,
                              child: buildButton(
                                content: "Ask seller",
                                buttonColor: Colors.transparent,
                                contentColor: getBlueColor(),
                                onPressed: (){

                                },
                                splashColor: getBlueColor().withOpacity(0.2),
                                side: true
                              ),
                            ),

                          ],
                        )
                      ],
                    ),
                  ),
                  const Divider(thickness: 1.5, height: 0.5,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.itemModel.item_title.trim(),
                                style: const TextStyle(
                                  fontFamily: "MaisonMedium",
                                  fontSize: 18.0
                                ),
                                textAlign: TextAlign.left,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: "${widget.itemModel.item_condition} • ",
                                  style: TextStyle(
                                    fontFamily: "MaisonMedium",
                                    fontSize: 18.0,
                                    color: Colors.grey.shade400
                                  ),
                                  children: [
                                    TextSpan(
                                      text: widget.itemModel.brand,
                                      style: TextStyle(
                                        fontFamily: "MaisonMedium",
                                        fontSize: 18.0,
                                        color: getBlueColor()
                                      )
                                    )
                                  ]
                                ),
                              )
                            ],
                          ),
                        ),
                        Text(
                          "€" + widget.itemModel.cost!,
                          style: const TextStyle(
                            fontFamily: "MaisonMedium",
                            fontSize: 18.0
                          ),
                        ),
                        buildButton(
                          content: "Buy now",
                          buttonColor: getBlueColor(),
                          contentColor: Colors.white,
                          onPressed: (){
                            Navigator.pushNamed(
                              context,
                              RouteNames.buyNowScreen,
                              arguments: {
                                "childCurrent": widget,
                                "itemCost": widget.itemModel.cost!,
                                "imageUrl": widget.itemModel.photo.first
                              }
                            );
                          },
                          splashColor: Colors.white12
                        ),
                        buildButton(
                          content: "Make an offer",
                          buttonColor: Colors.transparent,
                          contentColor: getBlueColor(),
                          onPressed: (){
                            Navigator.pushNamed(
                              context,
                              RouteNames.offerScreen,
                              arguments: {
                                "childCurrent": widget,
                                "owner": widget.itemModel.user_id,
                                "productId": widget.itemModel.product_id
                              }
                            );
                          },
                          splashColor: getBlueColor().withOpacity(0.15),
                          side: true
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        _buyerProtectionWidget()
                      ],
                    ),
                  ),
                  const Divider(thickness: 1.2,),
                  IntrinsicHeight(
                    child:  Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: BlocBuilder<UserInfoBloc, UserInfoState>(
                            bloc: BlocProvider.of<UserInfoBloc>(blocContext),
                            builder: (context, userInfoState){
                              return userInfoState is FetchedUserInfoState ? MaterialButton(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                      child: Icon(
                                          userInfoState.userModel.favourites.contains(widget.itemModel.product_id)
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                          color: userInfoState.userModel.favourites.contains(widget.itemModel.product_id)
                                            ? Colors.redAccent.shade400
                                            : Colors.grey.shade600,
                                          size: 20.0
                                      ),
                                    ),
                                    Text(
                                        "Favourite",
                                        style:  TextStyle(
                                          fontFamily: "MaisonBook",
                                          fontSize: 16.0,
                                          color: Colors.grey.shade600
                                        )
                                    )
                                  ],
                                ),
                                onPressed: (){
                                  if(userInfoState.userModel.favourites.contains(widget.itemModel.product_id)){
                                    BlocProvider.of<UserInfoBloc>(blocContext).unFavouriteItem(
                                      uid: userInfoState.userModel.user_id,
                                      favProductList: userInfoState.userModel.favourites,
                                      savedCount: widget.itemModel.saved,
                                      productId: widget.itemModel.product_id!
                                    );
                                  }else{
                                    BlocProvider.of<UserInfoBloc>(blocContext).favouriteItem(
                                      uid: userInfoState.userModel.user_id,
                                      favProductList: userInfoState.userModel.favourites,
                                      savedCount: widget.itemModel.saved,
                                      productId: widget.itemModel.product_id!
                                    );
                                  }
                                },
                              ): const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        ),
                        const VerticalDivider(thickness: 1.5,),
                        Expanded(
                          child: MaterialButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Icon(Icons.share, color: Colors.grey.shade600, size: 20.0,),
                                ),
                                Text(
                                  "Share",
                                  style:  TextStyle(
                                    fontFamily: "MaisonBook",
                                    fontSize: 16.0,
                                    color: Colors.grey.shade600
                                  )
                                )
                              ],
                            ),
                            onPressed: (){

                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  getSpacingWidget(context),
                  BlocProvider(
                    create: (context) => TranslationBloc(),
                    child: Builder(
                      builder: (blocContext){
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 25.0),
                                child: Text(
                                  "ITEM DESCRIPTION",
                                  style:  TextStyle(
                                    fontFamily: "MaisonBook",
                                    fontSize: 16.0,
                                    color: Colors.grey.shade600
                                  )
                                ),
                              ),
                              BlocBuilder<TranslationBloc, String?>(
                                bloc: BlocProvider.of<TranslationBloc>(blocContext),
                                builder: (context, translatedText){
                                  return Text(
                                    translatedText ?? widget.itemModel.item_description,
                                    style:  TextStyle(
                                      fontFamily: "MaisonBook",
                                      fontSize: 16.0,
                                      color: Colors.grey.shade600
                                    )
                                  );
                                },
                              ),
                              BlocBuilder<SeeMoreBloc, bool>(
                                bloc: BlocProvider.of<SeeMoreBloc>(blocContext),
                                builder: (context, seeMore){
                                  return RichText(
                                    text: TextSpan(
                                      text: seeMore ? "less" : "more",
                                      style: TextStyle(
                                          fontFamily: "MaisonMedium",
                                          color: getBlueColor(),
                                          fontSize: 18.0
                                      ),
                                      recognizer: TapGestureRecognizer()..onTap = (){
                                        if(seeMore){
                                          BlocProvider.of<SeeMoreBloc>(blocContext).seeLess();
                                        }else{
                                          BlocProvider.of<SeeMoreBloc>(blocContext).seeMore();
                                        }
                                      }
                                    ),
                                  );
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20.0),
                                child: BlocBuilder<TranslationBloc, String?>(
                                  bloc: BlocProvider.of<TranslationBloc>(blocContext),
                                  builder: (context, translatedText){
                                    return GestureDetector(
                                      child: Row(
                                        children: [
                                          Icon(
                                            CupertinoIcons.globe,
                                            color: getBlueColor()
                                          ),
                                          translatedText != null
                                            ?  Text(
                                            "Translated by Google •",
                                            style:  TextStyle(
                                              fontFamily: "MaisonBook",
                                              fontSize: 16.0,
                                              color: Colors.grey.shade600
                                            )
                                          )
                                          : const SizedBox(height: 0.0,width: 0.0,),
                                          Text(
                                            translatedText != null ?
                                            "Show original" :
                                            "Tap to translate",
                                            style:  TextStyle(
                                              fontFamily: "MaisonBook",
                                              fontSize: 16.0,
                                              color: getBlueColor(),
                                              decoration: TextDecoration.underline,
                                            ),
                                          )
                                        ],
                                      ),
                                      onTap: (){
                                        translatedText == null
                                          ? BlocProvider.of<TranslationBloc>(blocContext).translate(
                                          widget.itemModel.item_description
                                          )
                                          : BlocProvider.of<TranslationBloc>
                                          (blocContext).showOriginal();
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  BlocBuilder<SeeMoreBloc, bool>(
                    bloc: BlocProvider.of<SeeMoreBloc>(blocContext),
                    builder: (context, seeMore){
                      return seeMore ? Column(
                        children: [
                          const Divider(),
                          _getDetailsWidget("Category", widget.itemModel.category, onPressed: () { }),
                          const Divider(),
                          _getDetailsWidget("Size", "XS / 34 / 6", onPressed: () { }),
                          const Divider(),
                          _getDetailsWidget("Condition", widget.itemModel.item_condition, onPressed: () { }),
                          const Divider(),
                          _getDetailsWidget("Colour", _getItemColors(widget.itemModel.color)),
                          const Divider(),
                          _getDetailsWidget("Views", widget.itemModel.views),
                          const Divider(),
                          _getDetailsWidget("Uploaded", _getPostedTime(widget.itemModel.time)),
                          const Divider(),
                          _getDetailsWidget("Interested", widget.itemModel.interested),
                          const Divider(),
                          _getDetailsWidget("Payment options", "35", customWidget: _paymentWidget())
                        ],
                      ): const SizedBox(height: 0.0, width: 0.0);
                    },
                  ),
                  getSpacingWidget(context),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Postage",
                            style:  TextStyle(
                              fontFamily: "MaisonBook",
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            "From €0.99",
                            style:  TextStyle(
                              fontFamily: "MaisonBook",
                              fontSize: 16.0,
                            ),
                          )
                        ],
                      )
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    color: Colors.grey.shade300,
                    width: MediaQuery.of(context).size.width,
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                          text: "Your purchase is not subject to the right of "
                              "consumers to refuse a distance contract provided"
                              " for in Article 6.22810 of the Civil Code and the "
                              "seller's guarantee regarding the quality of the item "
                              "(conformity to the contract) established in Article 6.363."
                              " However, the purchase is "
                              "subject to the seller's warranty for hidden defects of t"
                              "he item provided for in Article 6.333 of the Civil Code. "
                              "Also see the applicable provisions on ",
                          style: TextStyle(
                              fontFamily: "MaisonBook",
                              fontSize: 14.0,
                              color: Colors.grey.shade600
                          ),
                          children: [
                            TextSpan(
                                text: "purchase and sale agreements",
                                style: TextStyle(
                                    fontFamily: "MaisonBook",
                                    fontSize: 14.0,
                                    color: getBlueColor(),
                                    decoration: TextDecoration.underline
                                )
                            ),
                            TextSpan(
                                text: " and ",
                                style: TextStyle(
                                    fontFamily: "MaisonBook",
                                    fontSize: 14.0,
                                    color: Colors.grey.shade600
                                )
                            ),
                            TextSpan(
                              text: "civil liability",
                              style: TextStyle(
                                fontFamily: "MaisonBook",
                                fontSize: 14.0,
                                color: getBlueColor(),
                                decoration: TextDecoration.underline
                              )
                            ),
                            TextSpan(
                                text: ". In any case, if you pay through"
                                    " the Vinted platform, your purchase is covered by ",
                                style: TextStyle(
                                    fontFamily: "MaisonBook",
                                    fontSize: 14.0,
                                    color: Colors.grey.shade600
                                )
                            ),
                            TextSpan(
                                text: "Buyer Protection",
                                style: TextStyle(
                                    fontFamily: "MaisonBook",
                                    fontSize: 14.0,
                                    color: getBlueColor(),
                                    decoration: TextDecoration.underline
                                )
                            ),
                            TextSpan(
                                text: ".",
                                style: TextStyle(
                                  fontFamily: "MaisonBook",
                                  fontSize: 14.0,
                                  color: getBlueColor(),
                                )
                            )
                          ]
                      ),
                    ),
                  ),
                  TabBar(
                    controller: _tabController,
                    unselectedLabelColor: Colors.grey.shade500,
                    labelColor: Colors.black87,
                    indicatorColor: getBlueColor(),
                    labelStyle: const TextStyle(
                      fontFamily: "MaisonBook",
                      fontSize: 14.0,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontFamily: "MaisonBook",
                      fontSize: 14.0,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    tabs: const [
                      Tab(
                        child: Text(
                            "Member's items"
                        ) ,
                      ),
                      Tab(
                          child: Text(
                              "Similar items"
                          )
                      )
                    ],
                  ),
                  Container(
                    height: 730.0,
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: [
                        BlocProvider(
                          create: (context) => ItemBloc.userBloc(userId: widget.itemModel.user_id),
                          child: OtherItems(itemDetailEnum: ItemDetailEnum.membersItems) ,
                        ),
                        BlocProvider(
                          create: (context) => ItemBloc(),
                          child: OtherItems(itemDetailEnum: ItemDetailEnum.similarItems) ,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      )
    );
  }

  String _getPostedTime(DateTime time){

    final dateTimeNow = DateTime.now();

    if(dateTimeNow.day == time.day
        && dateTimeNow.month == time.month
          && dateTimeNow.year == time.year){
      return "${dateTimeNow.difference(time).inHours.toString()} hours ago";
    }else{
      String daysDiff = (dateTimeNow.difference(time).inHours / 24).round().toString();
      return "$daysDiff days ago";
    }
  }

  String _getItemColors(List colorList){
    return colorList.toString().replaceAll("[", "").replaceAll("]", "").trim();
  }

  Widget _paymentWidget() => Row(
    children: [
      buildPaymentIcons(
        imageUrl: "assets/card logo.png",
        borderColor: Colors.grey.shade300,
        borderRadius: 3.0
      ),
      buildPaymentIcons(
        imageUrl: "assets/google pay logo.png",
        borderColor: Colors.black54,
        borderRadius: 20.0
      )
    ],
  );

  Widget _getDetailsWidget(String detailName, String value,{VoidCallback? onPressed, Widget? customWidget}) => GestureDetector(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              detailName,
              style: const TextStyle(
                fontFamily: "MaisonBook",
                fontSize: 15.0,
                color: Colors.black87
              )
            ),
            customWidget ?? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    value,
                    style: TextStyle(
                      fontFamily: "MaisonBook",
                      fontSize: 15.0,
                      color: Colors.grey.shade700
                    )
                  ),
                ),
                onPressed != null
                  ? Icon(Icons.arrow_forward_ios, size: 15.0,color: Colors.grey.shade500,)
                  : const SizedBox(height: 0.0,width: 0.0,)
              ],
            )
          ],
        ),
      )
    ),
    onTap: onPressed,
  );

  Widget _buyerProtectionWidget(){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/buyer-protection-shield.svg",
                height: 50.0,
                width: 50.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Buyer Protection fee",
                      style: TextStyle(
                        fontFamily: "MaisonBook",
                        fontSize: 15.0
                      )
                    ),
                    Text(
                      "€0.70 + 5% of the item's price",
                      style: TextStyle(
                        fontFamily: "MaisonBook",
                        fontSize: 15.0
                      )
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        RichText(
          text: TextSpan(
              text: "Our ",
              style: const TextStyle(
                  fontFamily: "MaisonBook",
                  fontSize: 18.0,
                  color: Colors.black87
              ),
              children: [
                TextSpan(
                    text: "Buyer Protection ",
                    style: TextStyle(
                      fontFamily: "MaisonBook",
                      fontSize: 18.0,
                      color: getBlueColor()
                    )
                ),
                const TextSpan(
                    text: "is added for a fee to every purchase made with the “Buy now” button. Buyer Protection includes our ",
                    style: TextStyle(
                      fontFamily: "MaisonBook",
                      fontSize: 18.0,
                      color: Colors.black87
                    )
                ),
                TextSpan(
                    text: "Refund Policy.",
                    style:  TextStyle(
                      fontFamily: "MaisonBook",
                      fontSize: 18.0,
                      color: getBlueColor()
                    )
                )
              ]
          ),
        )
      ],
    );
  }
}


