
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:vintedclone/bloc/auth_bloc/auth_bloc.dart';
import 'package:vintedclone/bloc/book_info_bloc/book_info_bloc.dart';
import 'package:vintedclone/bloc/bottom_nav_bloc/bottom_nav_bloc.dart';
import 'package:vintedclone/bloc/brand_bloc/brand_bloc.dart';
import 'package:vintedclone/bloc/category_selection_bloc/category_selection_bloc.dart';
import 'package:vintedclone/bloc/chat_bloc/input_validator_bloc/input_validator_bloc.dart';
import 'package:vintedclone/bloc/color_selection_bloc/color_selection_bloc.dart';
import 'package:vintedclone/bloc/common_search_screen_bloc/item_screen_bloc.dart';
import 'package:vintedclone/bloc/filter_bloc/filter_brand_bloc/filter_brand_bloc.dart';
import 'package:vintedclone/bloc/filter_bloc/filter_category_bloc/filter_category_bloc.dart';
import 'package:vintedclone/bloc/filter_bloc/filter_color_bloc/filter_color_bloc.dart';
import 'package:vintedclone/bloc/filter_bloc/filter_price_bloc/filter_price_bloc.dart';
import 'package:vintedclone/bloc/filter_bloc/filter_size_bloc/filter_size_bloc.dart';
import 'package:vintedclone/bloc/filter_bloc/filter_sort_by_bloc/filter_sort_by_bloc.dart';
import 'package:vintedclone/bloc/item_bloc/item_detail/item_detail_bloc.dart';
import 'package:vintedclone/bloc/photo_selector_bloc/photo_selector_bloc.dart';
import 'package:vintedclone/bloc/sell_bloc/sell_bloc.dart';
import 'package:vintedclone/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:vintedclone/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:vintedclone/bloc/webview_bloc/web_view_bloc.dart';
import 'package:vintedclone/screens/auth/auth_screen.dart';
import 'package:vintedclone/screens/auth/auth_wrapper.dart';
import 'package:vintedclone/screens/auth/forgot_password_screen.dart';
import 'package:vintedclone/screens/item_screens/buy_now_screen.dart';
import 'package:vintedclone/screens/item_screens/choose_pickup_point_screen.dart';
import 'package:vintedclone/screens/item_screens/payment_options_screen.dart';
import 'package:vintedclone/screens/navigation_screens/inbox_screens/new_message_screen.dart';
import 'package:vintedclone/screens/navigation_screens/profile_screen.dart';
import 'package:vintedclone/screens/policy_screens/preference_screen.dart';
import 'package:vintedclone/screens/profile_screens/personalisation_screens/members_screen.dart';
import 'package:vintedclone/screens/profile_screens/personalisation_screens/personalisation_screen.dart';
import 'package:vintedclone/screens/profile_screens/settings_screen/edit_profile_screen/city_screen.dart';
import 'package:vintedclone/screens/profile_screens/settings_screen/edit_profile_screen/countries_screen.dart';
import '../profile_screens/balance_screens/balance_confirmation_screen.dart';
import '../profile_screens/settings_screen/edit_profile_screen/edit_profile_screen.dart';
import 'package:vintedclone/screens/profile_screens/settings_screen/payments_screen/add_account_screen.dart';
import '../profile_screens/settings_screen/payments_screen/add_card_screen.dart';
import '../profile_screens/settings_screen/postage_screen/shipping_address_screen.dart';
import '../policy_screens/privacy_policy_screen.dart';
import '../common_search_screen/common_search_screen.dart';
import 'package:vintedclone/screens/profile_screens/donations_screens/set_up_donations_screen.dart';
import 'package:vintedclone/screens/profile_screens/donations_screens/setup_donations_detail.dart';
import 'package:vintedclone/screens/profile_screens/feedback_screens/feedback_detail_screen.dart';
import '../main_search_screen.dart';
import '../navigation_screens/sell_screen/brand_screen.dart';
import 'package:vintedclone/screens/chat_screens/offer_screen.dart';
import 'package:vintedclone/screens/chat_screens/update_screen.dart';
import 'package:vintedclone/screens/constants.dart';
import '../profile_screens/feedback_screens/feedback_intro_screen.dart';
import '../profile_screens/profile_detail_screen.dart';
import 'package:vintedclone/screens/router/profile_route/profile_route_names.dart';
import '../chat_screens/add_item_screen.dart';
import '../chat_screens/chat_info_screen.dart';
import '../chat_screens/chat_screen.dart';
import '../item_screens/item_detail_screen.dart';
import 'package:vintedclone/screens/navigation_screens/sell_screen/barcode_scanner_screen.dart';
import 'package:vintedclone/screens/navigation_screens/sell_screen/isbn_screen.dart';
import 'package:vintedclone/screens/search_screen_filters/filter_category_screen.dart';
import 'package:vintedclone/screens/search_screen_filters/filter_categroy_sub_screen.dart';
import 'package:vintedclone/screens/search_screen_filters/filter_screen.dart';
import '../../bloc/filter_bloc/filter_common_selector_bloc/filter_common_selector_bloc.dart';
import '../../bloc/filter_bloc/filter_material_bloc/filter_material_bloc.dart';
import '../navigation_screens/sell_screen/album_screen.dart';
import '../navigation_screens/sell_screen/color_screen.dart';
import '../navigation_screens/sell_screen/option_screen.dart';
import '../navigation_screens/sell_screen/parcel_size_screen.dart';
import '../navigation_screens/sell_screen/search_nav_screen.dart';
import '../navigation_screens/sell_screen/sell_screen.dart';
import '../navigation_screens/sell_screen/sub_search_nav_screen.dart';
import '../navigation_screens/sell_screen/upload_photo_screen.dart';
import 'package:vintedclone/screens/policy_screens/site_vendors_screen.dart';
import '../navigation_screens/sell_screen/price_screen.dart';
import 'package:vintedclone/screens/router/search_route/search_route_names.dart';
import 'package:vintedclone/screens/web_view_screen.dart';
import '../../bloc/carousel_indicator_bloc/carousel_indicator_bloc.dart';
import '../../bloc/scroll_bloc/scroll_bloc.dart';
import '../../bloc/see_more_bloc/see_more_bloc.dart';
import '../navigation_screens/sell_screen/condition_screen.dart';
import '../main_screen.dart';
import 'package:vintedclone/screens/auth/log_in_screen.dart';
import 'package:vintedclone/screens/auth/sign_up_screen.dart';
import 'package:vintedclone/screens/router/route_names.dart';
import 'package:vintedclone/screens/splash_screen.dart';

final PageStorageBucket mainScreenBucket = PageStorageBucket();

class AppRouter{

  StreamChatClient client = StreamChatClient(getStreamKey());

  static const Duration _duration = Duration(milliseconds: 850);

  static const Curve _curve = Curves.easeInCubic;

  static const Duration _durationShort = Duration(milliseconds: 300);
  final AuthBloc _authBloc = AuthBloc();

  final PhotoSelectorBloc _photoSelectorBloc = PhotoSelectorBloc();

  // for sell screen
  final CategorySelectionBloc _categorySelectionBloc = CategorySelectionBloc();

  final SellBloc _sellBloc = SellBloc();

  final ColorSelectionBloc _colorSelectionBloc = ColorSelectionBloc();

  final BottomNavBloc _bottomNavBloc = BottomNavBloc();

  final FilterSizeBloc _filterSizeBloc = FilterSizeBloc();

  final FilterColorBloc _filterColorBloc = FilterColorBloc();

  final FilterCommonSelectorBloc _filterConditionBloc = FilterCommonSelectorBloc();

  final FilterMaterialBloc _filterMaterialBloc = FilterMaterialBloc();

  final FilterBrandBloc _filterBrandBloc = FilterBrandBloc();

  final FilterSortByBloc _filterSortByBloc = FilterSortByBloc();

  final FilterPriceBloc _filterPriceBloc = FilterPriceBloc();

  final BookInfoBloc _bookInfoBloc = BookInfoBloc();

  final InputValidatorBloc _inputValidatorBloc = InputValidatorBloc();

  final ItemDetailBloc _itemCostBloc = ItemDetailBloc();

  final ItemScreenBloc _itemScreenBloc = ItemScreenBloc();

  final PhotoSelectorBloc _editProfilePhotoSelector = PhotoSelectorBloc();


  Route? onGenerateRoute(RouteSettings settings){
    switch(settings.name){
      case RouteNames.splashScreen:
        return MaterialPageRoute(
          builder: (_) => SplashScreen()
        );
      case RouteNames.loginScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _curve,
          child: BlocProvider(
            create: (context) => _authBloc,
            child: LoginScreen(),
          ),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case RouteNames.mainScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _bottomNavBloc,
              ),
              BlocProvider.value(
                value: _authBloc,
              )
            ],
            child: PageStorage(
              child: MainScreen(client),
              bucket: mainScreenBucket,
            )
          )
        );
      case RouteNames.forgotPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => ForgotPasswordScreen()
        );
      case RouteNames.privacyPolicy:
        return MaterialPageRoute(
          builder: (_) => PrivacyPolicyScreen(
            (settings.arguments as Map)["mainScreen"]
          )
        );
      case RouteNames.preferenceScreen:
        return PageTransition(
          curve: _curve,
          duration: _duration,
          reverseDuration: _duration,
          child: PreferenceScreen(),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case RouteNames.authScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => _authBloc,
            child: AuthScreen(client),
          )
        );
      case RouteNames.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => _authBloc,
              )
            ],
            child: SignupScreen(SignUpBloc())
          )
        );
      case RouteNames.authWrapper:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AuthBloc()
              ),
              BlocProvider(
                create: (_) => UserInfoBloc.currentUser(),
              ),
            ],
            child: AuthWrapper(client: client,)
          )
        );
      case RouteNames.vendorScreen:
        return MaterialPageRoute(
          builder: (_) => SiteVendorsScreen()
        );
      case RouteNames.webScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => WebViewBloc(),
            child: WebViewScreen(
              screenName: (settings.arguments as Map)["screenName"],
              url: (settings.arguments as Map)["url"],
            ),
          )
        );
      case RouteNames.photoSelectionScreen:
        return PageRouteBuilder(

          pageBuilder: (context, anim, secAnim){
            return UploadPhotoScreen(
              (settings.arguments as Map)["albumName"],
              (settings.arguments as Map)["mediaList"],
              _getPhotoSelectorBloc(settings.arguments as Map)
            );
          },
          transitionsBuilder: (context, anim, secAnim, child){
            return Stack(
              children: <Widget>[
                SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.0, 0.0),
                    end: const Offset(-1.0, 0.0),
                  ).animate(
                    CurvedAnimation(
                      parent: anim,
                      curve: Curves.easeInOut,
                    ),
                  ),
                  child: (settings.arguments as Map)["childCurrent"],
                ),
                SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: anim,
                      curve: Curves.easeInOut,
                    ),
                  ),
                  child: child,
                )
              ],
            );
          }
        );
      case RouteNames.sellScreen:
        return PageTransition(
          duration: _durationShort,
          reverseDuration: _durationShort,
          curve: _curve,
          type: PageTransitionType.bottomToTop,
          settings: const RouteSettings(
            name: RouteNames.sellScreen
          ),
          child: BlocProvider.value(
            // for clearing the photoBloc at willPop
            value: _photoSelectorBloc,
            child: SellScreen(
              mainScreenInstance:(settings.arguments as Map)["childCurrent"],
              photoSelectorBloc: _photoSelectorBloc,
              categorySelectionBloc: _categorySelectionBloc,
              sellBloc: _sellBloc,
              colorSelectionBloc: _colorSelectionBloc,
              authBloc: _authBloc,
              bookInfoBloc: _bookInfoBloc,
            ),
          ),
          childCurrent: (settings.arguments as Map)["childCurrent"]
        );
      case RouteNames.categoryScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _curve,
          child:  BlocProvider.value(
            value: _categorySelectionBloc,
            child: SearchScreen(
              optionScreen: (settings.arguments as Map)["optionScreen"]
            ),
          ),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case RouteNames.subSearchScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _categorySelectionBloc,
            child: SubSearchScreen(
              optionList: (settings.arguments as Map)["optionList"],
              categoryName: (settings.arguments as Map)["categoryName"],
              optionScreen: (settings.arguments as Map)["optionScreen"],
            ),
          )
        );
      case RouteNames.filterCategoryScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _curve,
          child: FilterCategoryScreen(
            categorySelectionBloc: (settings.arguments as Map)["filterCategoryBloc"] as CategorySelectionBloc,
          ),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case RouteNames.filterCategorySubScreen:
        return PageTransition(
            curve: _curve,
           duration: _duration,
           reverseDuration: _duration,
           child: FilterSubSearchScreen(
             optionList: (settings.arguments as Map)["optionList"],
             categoryName: (settings.arguments as Map)["categoryName"],
             categorySelectionBloc:(settings.arguments as Map)["filterCategoryBloc"] as CategorySelectionBloc ,
           ),
           type: PageTransitionType.rightToLeftJoined,
           childCurrent: (settings.arguments as Map)["childCurrent"],
        );
      case RouteNames.brandScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _curve,
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: BrandBloc()
              ),
              BlocProvider.value(
                value: _sellBloc,
              )
            ],
            child: BrandScreen()
          ),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case RouteNames.conditionScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _curve,
          child: BlocProvider.value(
            value: _sellBloc,
            child: ConditionScreen(
              (settings.arguments as Map)["conditionEnum"]
            ),
          ),
          type: PageTransitionType.rightToLeftJoined,
          childCurrent: (settings.arguments as Map)["childCurrent"]
        );
      case RouteNames.priceScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _curve,
          child: PriceScreen(
            enteredPrice: (settings.arguments as Map)["enteredPrice"]
          ),
          type: PageTransitionType.rightToLeftJoined,
          childCurrent: (settings.arguments as Map)["childCurrent"]
        );
      case RouteNames.optionsScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _curve,
          type: PageTransitionType.rightToLeftJoined,
          child: BlocProvider.value(
            value: _sellBloc,
            child: OptionScreen(
              screenTitle: (settings.arguments as Map)["screenTitle"],
              optionJson: (settings.arguments as Map)["optionJson"],
              screenEnum: (settings.arguments as Map)["screenEnum"],
            ),
          ),
          childCurrent: (settings.arguments as Map)["childCurrent"]
        );
      case RouteNames.coloursScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _curve,
          child: BlocProvider.value(
            value: _colorSelectionBloc,
            child: ColorsScreen(
              ColorScreenEnum.sellScreen
            ),
          ),
          type: PageTransitionType.rightToLeftJoined,
          childCurrent: (settings.arguments as Map)["childCurrent"]
        );
      case RouteNames.parcelScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _curve,
          child : BlocProvider.value(
            value: _sellBloc,
            child: ParcelSizeScreen((settings.arguments as Map)["recommendedSizeIndex"]),
          ),
          type: PageTransitionType.rightToLeftJoined,
          childCurrent: (settings.arguments as Map)["childCurrent"]
        );
      case RouteNames.itemDetailScreen:
        return PageTransition(
            type: PageTransitionType.rightToLeftJoined,
            alignment: Alignment.center,
            duration: _duration,
            reverseDuration: _duration,
            curve: _curve,
            child: StreamChatCore(
              child: ItemDetailScreen(
                itemModel: (settings.arguments as Map)["item"],
                userInfoBloc: UserInfoBloc.currentUser(),
                carouselIndicatorBloc: CarouselIndicatorBloc(),
                scrollBloc:  ScrollBloc(),
                seeMoreBloc: SeeMoreBloc(),
              ),
              client: client,
            ),
            childCurrent: (settings.arguments as Map)["childCurrent"]
        );
      case RouteNames.albumScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _curve,
          child: AlbumScreen((settings.arguments as Map)["value"]),
          type: PageTransitionType.rightToLeftJoined,
          childCurrent: (settings.arguments as Map)["childCurrent"]
        );
      case RouteNames.isbnScreen:
        return PageTransition(
          duration: Duration(milliseconds: 300),
          reverseDuration: _duration,
          curve: _curve,
          child: IsbnScreen(
            bookInfoBloc: _bookInfoBloc,
            sellBloc: _sellBloc,
            initialIsbnValue: (settings.arguments as Map)["initialIsbnValue"],
          ),
          type: PageTransitionType.rightToLeftJoined,
          childCurrent: (settings.arguments as Map)["childCurrent"]
        );

    // It is not given with 'PageTransition' because the
    // PageTransitionType.rightToLeftJoined is obtained as a result of Stack
    // and maintains state. Hence it prevents the GlobalKey usage by throwing
    // "duplication of key" error. So normal MaterialPageRoute is used

      case RouteNames.barcodeScannerScreen:
        return MaterialPageRoute(
          builder: (context){
            return BarcodeScanner();
          }
        );
      case RouteNames.chatScreen:
        return PageTransition(
            duration: _duration,
            reverseDuration: _duration,
            curve: _curve,
            child: ChatScreen(
              _authBloc,
              client,
              (settings.arguments as Map)["channel"]
            ),
            type: PageTransitionType.rightToLeftJoined,
            settings: RouteSettings(
              name: RouteNames.chatScreen
            ),
            childCurrent: (settings.arguments as Map)["childCurrent"]
        );
      case RouteNames.chatInfoScreen:
        return PageTransition(
            duration: _duration,
            reverseDuration: _duration,
            curve: _curve,
            child: ChatInfoScreen(
              channel: (settings.arguments as Map)["channel"],
              userInfoBloc: UserInfoBloc((settings.arguments as Map)["userId"]),
              ownerName: (settings.arguments as Map)["ownerName"],
              ownerId: (settings.arguments as Map)["ownerId"],
              lastMessage: (settings.arguments as Map)["lastMessage"],
            ),
            type: PageTransitionType.rightToLeftJoined,
            childCurrent: (settings.arguments as Map)["childCurrent"]
        );
      case RouteNames.addItemScreen:
        return PageTransition(
            duration: _duration,
            reverseDuration: _duration,
            curve: _curve,
            child: AddItemScreen(
              (settings.arguments as Map)["ownerId"],
              (settings.arguments as Map)["ownerName"],
              _itemCostBloc,
              (settings.arguments as Map)["channel"],
              (settings.arguments as Map)["lastMessage"]
            ),
            type: PageTransitionType.rightToLeftJoined,
            childCurrent: (settings.arguments as Map)["childCurrent"]
        );
      case RouteNames.updateScreen:
        return PageTransition(
            duration: _duration,
            reverseDuration: _duration,
            curve: _curve,
            child: BlocProvider.value(
              value: _authBloc,
              child: UpdateScreen(
                _itemCostBloc,
                (settings.arguments as Map)["channel"],
                (settings.arguments as Map)["lastMessage"]
              ),
            ),
            type: PageTransitionType.rightToLeftJoined,
            childCurrent: (settings.arguments as Map)["childCurrent"]
        );
      case RouteNames.newMessagesScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _curve,
          child: NewMessageScreen(),
          type: PageTransitionType.rightToLeftJoined,
          childCurrent: (settings.arguments as Map)["childCurrent"]
        );
      case RouteNames.offerScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _curve,
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _authBloc,
              ),
              BlocProvider.value(
                value: UserInfoBloc.currentUser(),
              ),
            ],
            child: StreamChatCore(
              client: client,
              child: OfferScreen(
                client: client,
                owner: (settings.arguments as Map)["owner"],
                productId: (settings.arguments as Map)["productId"],
              ),
            ),
          ),
          type: PageTransitionType.rightToLeftJoined,
          childCurrent: (settings.arguments as Map)["childCurrent"]
        );
      case RouteNames.countriesScreen:
        return PageTransition(
            duration: _duration,
            reverseDuration: _duration,
            curve: _curve,
            child: CountriesScreen(),
            type: PageTransitionType.rightToLeftJoined,
            childCurrent: (settings.arguments as Map)["childCurrent"]
        );
      case RouteNames.citiesScreen:
        return PageTransition(
            duration: _duration,
            reverseDuration: _duration,
            curve: _curve,
            child: BlocProvider.value(
              value: _authBloc,
              child: CityScreen(
                citiesList: (settings.arguments as Map)["cityList"],
                country:(settings.arguments as Map)["country"] ,
              ),
            ),
            type: PageTransitionType.rightToLeftJoined,
            childCurrent: (settings.arguments as Map)["childCurrent"]
        );
      case RouteNames.buyNowScreen:
        return PageTransition(
            duration: _duration,
            reverseDuration: _duration,
            curve: _curve,
            child: BuyNowScreen(
              itemCost: (settings.arguments as Map)["itemCost"],
              imageUrl: (settings.arguments as Map)["imageUrl"],
            ),
            type: PageTransitionType.rightToLeftJoined,
            childCurrent: (settings.arguments as Map)["childCurrent"]
        );
      case RouteNames.paymentOptionsScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _curve,
          child: PaymentOptionsScreen(),
          type: PageTransitionType.rightToLeftJoined,
          childCurrent: (settings.arguments as Map)["childCurrent"]
        );
      case RouteNames.choosePickupPointScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _curve,
          child: ChoosePickupPointScreen(),
          type: PageTransitionType.rightToLeftJoined,
          childCurrent: (settings.arguments as Map)["childCurrent"]
        );
        //not need because each screen router has its own implementation of
        // common search screen.....check it!

      /*case RouteNames.commonSearchScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          child: BlocProvider.value(
            value: _itemScreenBloc,
            child: CommonSearchScreen(),
          ),
          type: PageTransitionType.rightToLeftJoined,
          childCurrent: (settings.arguments as Map)["childCurrent"]
        );*/
      case SearchRouteNames.filterSizeScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _curve,
          child: BlocProvider.value(
            value: _filterSizeBloc,
            child: (settings.arguments as Map)["child"],
          ),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case SearchRouteNames.filterColorScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration : _duration,
          curve: _curve,
          child: BlocProvider.value(
            value: _filterColorBloc,
            child: (settings.arguments as Map)["child"],
          ),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case SearchRouteNames.filterConditionScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _curve,
          child: BlocProvider.value(
            value: _filterConditionBloc,
            child: (settings.arguments as Map)["child"],
          ),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case SearchRouteNames.filterPriceScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _curve,
          child: BlocProvider.value(
            value:  _filterPriceBloc,
            child: (settings.arguments as Map)["child"],
          ),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );

        // among the option in the main search screen FilterScreen is an exception, because
        // the categorySelectionBloc cannot be passed at the moment of list creation(category Bloc)
        // So the child can be passed as null and here we can declare the class
        // and pass the params explicitly

      case SearchRouteNames.filterScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _curve,
          child: BlocProvider.value(
            value: (settings.arguments as Map)[
              "itemBloc"
            ] as FilterCategoryBloc,
            child: FilterScreen(
              categorySelectionBloc:
                (settings.arguments as Map)[
                "filterCategoryBloc"
                ] as CategorySelectionBloc,
              filterSortByBloc: _filterSortByBloc,
              filterMaterialBloc: _filterMaterialBloc,
              filterBrandBloc: _filterBrandBloc,
              filterPriceBloc: _filterPriceBloc,
              filterConditionBloc: _filterConditionBloc,
              filterColorBloc: _filterColorBloc,
              filterSizeBloc: _filterSizeBloc,
            ),
          ),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined,
          settings: const RouteSettings(
            name: SearchRouteNames.filterScreen
          )
        );
      case SearchRouteNames.filterSortByScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _curve,
          child: BlocProvider.value(
            value: _filterSortByBloc,
            child: (settings.arguments as Map)["child"],
          ),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case SearchRouteNames.filterBrandScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _curve,
          child: BlocProvider.value(
            value: _filterBrandBloc,
            child: (settings.arguments as Map)["child"],
          ),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case SearchRouteNames.filterMaterialScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _curve,
          child: BlocProvider.value(
            value: _filterMaterialBloc,
            child: (settings.arguments as Map)["child"],
          ),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      /*case SearchRouteNames.resultSearchScreen:
        return PageTransition(
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => categorySelectionBloc
                ),
                BlocProvider(
                  create: (context) =>
                    ItemBloc.category(
                      categoryName: (settings.arguments as Map)["categoryName"]
                    ),
                )
              ],
              child: MainSearchScreen(
                state: (settings.arguments as Map)["state"],
                mainScreenInstance: this,
                itemBloc: FilterCategoryBloc((settings.arguments as Map)["categoryName"]),
              ),
            ),
            childCurrent: (settings.arguments as Map)["childCurrent"],
            type: PageTransitionType.rightToLeftJoined
        );*/
      case ProfileRouteNames.profileDetailScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _curve,
          child: ProfileDetailScreen(
            userInfoBloc: (settings.arguments as Map)["userBloc"],
            channel: (settings.arguments as Map)["channel"],
            client: client,
            profileScreenEnum: ProfileScreenEnum.otherUserScreen,
          ),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case ProfileRouteNames.sendFeedbackIntroScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _curve,
          child: FeedBackIntroScreen(),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case ProfileRouteNames.sendFeedbackDetailScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _curve,
          child: FeedBackDetailScreen(),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case ProfileRouteNames.shipAddressScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          child: ShippingAddressScreen(),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case ProfileRouteNames.addCardScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _curve,
          child: CardDetailsScreen(
            cardDetailScreenEnum: (settings.arguments as Map)["cardDetailScreenEnum"]
                ?? CardDetailScreenEnum.fromProfileScreen,
          ),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case ProfileRouteNames.addAccountScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _curve,
          child: AddAccountScreen(),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case ProfileRouteNames.editProfileScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _curve,
          child: BlocProvider.value(
            value: _authBloc,
            child: EditProfileScreen(_editProfilePhotoSelector),
          ),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined,
          settings: const RouteSettings(name: ProfileRouteNames.editProfileScreen)
        );
      case ProfileRouteNames.balanceConfirmationScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _curve,
          child: BalanceConfirmationScreen(),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case ProfileRouteNames.personalisationScreen:
        return PageTransition(
          curve: _curve,
          duration: _duration,
          reverseDuration: _duration,
          child: PersonalisationScreen(),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case ProfileRouteNames.membersScreen:
        return PageTransition(
          curve: _curve,
          duration: _duration,
          reverseDuration: _duration,
          child: MembersScreen(),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      default:
        return null;
    }
  }

  PhotoSelectorBloc _getPhotoSelectorBloc(Map arguments){
    return arguments["uploadPhotoScreenEnum"]
        as UploadPhotoScreenEnum == UploadPhotoScreenEnum.sellScreen
      ? _photoSelectorBloc
      : _editProfilePhotoSelector;
  }

  disposeBlocs(){

    _authBloc.manualBlocDispose();

    _photoSelectorBloc.manualBlocDispose();

    _categorySelectionBloc.manualBlocDispose();

    _sellBloc.manualBlocDispose();

    _colorSelectionBloc.manualBlocDispose();

    _bottomNavBloc.manualBlocDispose();

    _filterSizeBloc.manualBlocDispose();

    _filterColorBloc.manualBlocDispose();

    _filterConditionBloc.manualBlocDispose();

    _filterMaterialBloc.manualBlocDispose();

    _filterBrandBloc.manualBlocDispose();

    _filterSortByBloc.manualBlocDispose();

    _bookInfoBloc.manualBlocDispose();

  }
}