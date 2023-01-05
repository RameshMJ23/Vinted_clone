
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vintedclone/bloc/auth_bloc/auth_bloc.dart';
import 'package:vintedclone/bloc/brand_bloc/brand_bloc.dart';
import 'package:vintedclone/bloc/brand_bloc/brand_state.dart';
import 'package:vintedclone/bloc/filter_bloc/selected_filter_bloc.dart';
import 'package:vintedclone/bloc/internet_bloc/internet_bloc.dart';
import 'package:vintedclone/bloc/internet_bloc/internet_state.dart';
import 'package:vintedclone/bloc/item_bloc/item_bloc.dart';
import 'package:vintedclone/bloc/lang_bloc/lang_bloc.dart';
import 'package:vintedclone/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:vintedclone/l10n/generated/app_localizations.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/main_search_screen.dart';
import 'package:vintedclone/screens/router/home_route/home_route_name.dart';
import 'package:vintedclone/screens/router/route_names.dart';
import 'package:vintedclone/screens/widgets/internet_builder_widget.dart';
import '../item_screens/item_carousel.dart';
import '../item_screens/news_feed_widget.dart';
import '../item_screens/wardrobe_widget.dart';

import '../../bloc/category_selection_bloc/category_selection_bloc.dart';


final suggestedSearchBucket = PageStorageBucket();

final homePageBucket = PageStorageBucket();

class HomeScreen extends StatefulWidget {

  Widget mainScreenInstance;

  HomeScreen(this.mainScreenInstance);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
                                    with AutomaticKeepAliveClientMixin{

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BrandBloc.shopByBrand(),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: getSearchAppBar(
          context: context,
          onTap: (){
            Navigator.of(context).pushNamed(
              HomeRouteNames.homeCommonSearchScreen,
              arguments: {
                "childCurrent": widget
              }
            );
          },
          hintText: AppLocalizations.of(context)!.searchBarHint
        ),
        body: PageStorage(
          bucket: homePageBucket,
          child: ListView(
            key: const PageStorageKey<String>("homePageKey"),
            children: [
              _buildHeading("Reima", onSeeAllPressed: (){

                BlocProvider.of<SelectedFilterBloc>(context).addFilter(
                    MainSearchScreenSelectedOptionEnum.brand
                );

                Navigator.pushNamed(
                    context,
                    HomeRouteNames.brandSearchResultScreen,
                    arguments: {
                      "childCurrent": widget,
                      "state": BlocProvider.of
                      <CategorySelectionBloc>(context).state,
                      "brandName": "Reima",
                      "categorySelectionBloc":  BlocProvider.of
                      <CategorySelectionBloc>(context),
                      "fans": "1.1M",
                      "items": "25.6K"
                    }
                );

              }),
              ItemCarousel("Reima", widget.mainScreenInstance, context),
              const SizedBox(height: 50.0,),
              _buildHeading("Nike", onSeeAllPressed: (){

                BlocProvider.of<SelectedFilterBloc>(context).addFilter(
                    MainSearchScreenSelectedOptionEnum.brand
                );

                Navigator.pushNamed(
                    context,
                    HomeRouteNames.brandSearchResultScreen,
                    arguments: {
                      "childCurrent": widget,
                      "state": BlocProvider.of
                      <CategorySelectionBloc>(context).state,
                      "brandName": "Nike",
                      "categorySelectionBloc":  BlocProvider.of
                      <CategorySelectionBloc>(context),
                      "fans": "2.1M",
                      "items": "19.4M"
                    }
                );
              }),
              ItemCarousel("Nike", widget.mainScreenInstance, context),
              const SizedBox(height: 50.0,),
              _shopByCategoryWidget(),
              const SizedBox(height: 50.0,),
              _buildHeading(
                  AppLocalizations.of(context)!.popularItems, subTitle: false
              ),
              ItemCarousel(null, widget.mainScreenInstance, context),
              const SizedBox(height: 50.0,),
              _shopByBrandWidget(context),
              const SizedBox(height: 50.0,),
              _suggestedSearchesWidget(context),
              const SizedBox(height: 50.0,),
              _buildHeading(
                  AppLocalizations.of(context)!.newsFeed,
                  subTitle: false,
                  trailing: false
              ),
              MultiBlocProvider(
                  providers: [
                    BlocProvider(
                        create: (context) => ItemBloc()
                    )
                  ],
                  child: NewsFeedWidget(
                    length: 6,
                    itemBloc: ItemBloc(),
                    mainScreenInstance: widget.mainScreenInstance,
                  )
              ),
              BlocProvider(
                create: (context) => UserInfoBloc("qShs9wMvAaMb4KwMDHb9rJQc5dx1"),
                child: WardrobeWidget(userId: "qShs9wMvAaMb4KwMDHb9rJQc5dx1",),
              ),
              getSpacingWidget(context),
              MultiBlocProvider(
                  providers: [
                    BlocProvider(
                        create: (context) => ItemBloc()
                    )
                  ],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: NewsFeedWidget(
                      itemBloc: ItemBloc(),
                      mainScreenInstance: widget.mainScreenInstance,
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _shopByBrandWidget(
    BuildContext mainContext
  ) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _buildHeading(
        AppLocalizations.of(context)!.shopByBrand,
        subTitle: false,
        trailing: false
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child:  BlocBuilder<BrandBloc, BrandState>(
          builder: (context, state){
            return (state is FetchedBrandState)
              ? Wrap(
              direction: Axis.horizontal,
              spacing: 15.0,
              runSpacing: 10.0,
              crossAxisAlignment: WrapCrossAlignment.end,
              children: state.brandList.map((e){
                return InkWell(
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      e.brandName,
                      style: const TextStyle(
                        fontFamily: "MaisonBook",
                        color: Colors.black87,
                        fontSize: 15.0
                     ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Colors.grey.shade300)
                    ),
                  ),
                  onTap: (){

                    BlocProvider.of<SelectedFilterBloc>(mainContext).addFilter(
                      MainSearchScreenSelectedOptionEnum.brand
                    );

                    Navigator.pushNamed(
                      mainContext,
                      HomeRouteNames.brandSearchResultScreen,
                      arguments: {
                        "childCurrent": widget,
                        "state": BlocProvider.of
                            <CategorySelectionBloc>(mainContext).state,
                        "brandName": e.brandName,
                        "categorySelectionBloc":  BlocProvider.of
                            <CategorySelectionBloc>(mainContext),
                        "fans": e.views,
                        "items": e.items
                      }
                    );
                  },
                );
              }).toList(),
            )
            : const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      )
    ],
  );

  Widget _suggestedSearchesWidget(BuildContext mainContext){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeading(
          AppLocalizations.of(context)!.suggestedSearches,
          trailing: false,
          subTitle: false
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SizedBox(
            height: 80.0,
            child: BlocBuilder<BrandBloc, BrandState>(
              builder: (context, state){
                return state is FetchedBrandState ? ListView.builder(
                  key: const PageStorageKey<String>("suggestedSearchesKey"),
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  shrinkWrap: true,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(color: Colors.grey.shade200)
                        ),
                        padding:const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                        onPressed: (){

                          BlocProvider.of<SelectedFilterBloc>(mainContext).addFilter(
                            MainSearchScreenSelectedOptionEnum.brand
                          );

                          Navigator.pushNamed(
                            mainContext,
                            HomeRouteNames.brandSearchResultScreen,
                            arguments: {
                              "childCurrent": widget.mainScreenInstance,
                              "state": BlocProvider.of
                              <CategorySelectionBloc>(mainContext).state,
                              "brandName": state.brandList[index].brandName,
                              "categorySelectionBloc":  BlocProvider.of
                              <CategorySelectionBloc>(mainContext),
                              "fans": state.brandList[index].views,
                              "items": state.brandList[index].items
                            }
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.brandList[index].brandName,
                              style: const  TextStyle(
                                fontFamily: "MaisonMedium",
                                fontSize: 16.0,
                                color: Colors.black87
                              )
                            ),
                            Text(
                              "${state.brandList[index].views}K views",
                              style:  TextStyle(
                                fontFamily: "MaisonBook",
                                fontSize: 16.0,
                                color: Colors.grey.shade700
                              )
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
                : const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _shopByCategoryWidget(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeading(
            AppLocalizations.of(context)!.shopByCategory,
            subTitle: false,
            trailing: false
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    _buildCircularCategoryWidget(imageUrl: "assets/women_root.png", categoryName: "Women"),
                    _buildCircularCategoryWidget(imageUrl: "assets/home.png", categoryName: "Home")
                  ],
                ),
                Column(
                  children: [
                    _buildCircularCategoryWidget(imageUrl: "assets/mens.png", categoryName: "Men"),
                    _buildCircularCategoryWidget(imageUrl: "assets/entertainment.png", categoryName: "Entertainment")
                  ],
                ),
                Column(
                  children: [
                    _buildCircularCategoryWidget(imageUrl: "assets/children_new.png", categoryName: "Kids"),
                    _buildCircularCategoryWidget(imageUrl: "assets/pet_care.png", categoryName: "Pet care")
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildCircularCategoryWidget({required String imageUrl, required String categoryName}){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 35.0,
            child: Image.asset(
              imageUrl,
            ),
            backgroundColor: Colors.grey.shade200,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              categoryName,
              style: const TextStyle(
                  fontFamily: "MaisonMedium",
                  fontSize: 16.0
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeading(
    String title, {
    bool subTitle = true,
    bool trailing = true,
    VoidCallback? onSeeAllPressed}
  ){
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0),
        child: Text(
          title,
          style: const TextStyle(
            fontFamily: "MaisonMedium",
            fontSize: 22.0,
            color: Colors.black87
          ),
        ),
      ),
      subtitle: subTitle ? Text(
        AppLocalizations.of(context)!.brandsYouMightLike,
        style: TextStyle(
          fontFamily: "MaisonMedium",
          fontSize: 16.0,
          color: Colors.grey.shade600
        ),
      ): null,
      trailing: trailing == true ? TextButton(
        child: Text(
          AppLocalizations.of(context)!.seeAll,
          style: TextStyle(
            fontFamily: "MaisonMedium",
            fontSize: 16.0,
            color: getBlueColor()
          )
        ),
        onPressed: onSeeAllPressed,
      ): null,
    );
  }

}
