


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:vintedclone/bloc/filter_bloc/filter_category_bloc/filter_category_bloc.dart';
import 'package:vintedclone/bloc/help_center_bloc/help_center_bloc.dart';
import 'package:vintedclone/screens/navigation_screens/profile_screen.dart';
import 'package:vintedclone/screens/profile_screens/about_vinted.dart';
import 'package:vintedclone/screens/profile_screens/balance_screens/balance_confirmation_screen.dart';
import 'package:vintedclone/screens/profile_screens/balance_screens/balance_screen.dart';
import 'package:vintedclone/screens/profile_screens/bundle_discounts_screen.dart';
import 'package:vintedclone/screens/profile_screens/help_center_screens/help_center_main.dart';
import 'package:vintedclone/screens/profile_screens/help_center_screens/help_center_sub_screen.dart';
import 'package:vintedclone/screens/profile_screens/help_center_screens/help_search_screen.dart';
import 'package:vintedclone/screens/profile_screens/legal_info_screen.dart';
import 'package:vintedclone/screens/profile_screens/settings_screen/accounts_screen/account_settings.dart';
import 'package:vintedclone/screens/profile_screens/settings_screen/accounts_screen/create_password_screen.dart';
import 'package:vintedclone/screens/profile_screens/settings_screen/accounts_screen/delete_acc_screen.dart';
import 'package:vintedclone/screens/profile_screens/settings_screen/data_setting/download_data_screen.dart';
import 'package:vintedclone/screens/profile_screens/settings_screen/email_notification_screen.dart';
import 'package:vintedclone/screens/profile_screens/settings_screen/language_screen.dart';
import 'package:vintedclone/screens/profile_screens/settings_screen/payments_screen/payments_screen.dart';
import 'package:vintedclone/screens/widgets/internet_builder_widget.dart';
import '../../profile_screens/profile_detail_screen.dart';
import '../../profile_screens/settings_screen/postage_screen/postage_screen.dart';
import 'package:vintedclone/screens/profile_screens/settings_screen/push_notification_screen.dart';
import 'package:vintedclone/screens/profile_screens/settings_screen/security_screen.dart';
import '../../profile_screens/settings_screen/data_setting/data_settings.dart';
import '../../profile_screens/donations_screens/donations_screen.dart';
import 'package:vintedclone/screens/profile_screens/favourite_items_screen.dart';
import 'package:vintedclone/screens/profile_screens/your_guide_screen.dart';
import 'package:vintedclone/screens/web_view_screen.dart';
import '../../../bloc/webview_bloc/web_view_bloc.dart';
import '../../profile_screens/donations_screens/set_up_donations_screen.dart';
import '../../profile_screens/donations_screens/setup_donations_detail.dart';
import '../../profile_screens/holiday_mode_screen.dart';
import 'package:vintedclone/screens/profile_screens/my_orders_screen.dart';
import 'package:vintedclone/screens/router/profile_route/profile_route_names.dart';
import 'package:vintedclone/screens/router/search_route/search_route_names.dart';
import 'package:vintedclone/screens/search_screen_filters/filter_price_screen.dart';
import 'package:vintedclone/screens/search_screen_filters/filter_screen.dart';
import 'package:vintedclone/screens/profile_screens/settings_screen/settings_screen.dart';
import '../../../bloc/auth_bloc/auth_bloc.dart';
import '../../../bloc/category_selection_bloc/category_selection_bloc.dart';
import '../../../bloc/item_bloc/item_bloc.dart';
import '../../main_search_screen.dart';
import '../../navigation_screens/sell_screen/search_nav_screen.dart';
import '../../navigation_screens/sell_screen/sub_search_nav_screen.dart';
import '../../profile_screens/settings_screen/postage_screen/shipping_address_screen.dart';

class ProfileNavRouter{

  Widget mainScreenInstance;

  StreamChatClient client;

  ProfileNavRouter({
    required this.mainScreenInstance,
    required this.client
  });

  static const Duration _duration = Duration(milliseconds: 850);

  static const Curve _navigationCurve = Curves.easeInCubic;

  final AuthBloc _authBloc = AuthBloc();

  final HelpCenterBloc _helpCenterBloc = HelpCenterBloc();

  Route? onGenerateRoute(RouteSettings settings){
    switch(settings.name){
      case ProfileRouteNames.profileScreen:
        return MaterialPageRoute(
          builder: (_) => InternetBuilderWidget(
            child: ProfileScreen(),
          )
        );
      case ProfileRouteNames.profileDetailScreen:
        return PageTransition(
          curve: _navigationCurve,
          duration: _duration,
          reverseDuration: _duration,
          child: ProfileDetailScreen(
            userInfoBloc: (settings.arguments as Map)["userBloc"],
            channel: (settings.arguments as Map)["channel"],
            client: client,
            profileScreenEnum: (settings.arguments as Map)["profileScreenEnum"],
          ),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
      );
      case ProfileRouteNames.settingsScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _navigationCurve,
          child: SettingsScreen(_authBloc, client),
          type: PageTransitionType.rightToLeftJoined,
          childCurrent: (settings.arguments as Map)["childCurrent"]
        );
      case ProfileRouteNames.myOrdersScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _navigationCurve,
          child: MyOrdersScreen(),
          type: PageTransitionType.rightToLeftJoined,
          childCurrent: (settings.arguments as Map)["childCurrent"]
        );
      case ProfileRouteNames.holidayModeScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _navigationCurve,
          child: HolidayModeScreen(),
          type: PageTransitionType.rightToLeftJoined,
          childCurrent: (settings.arguments as Map)["childCurrent"]
        );
      case ProfileRouteNames.yourGuideScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _navigationCurve,
          child: YourGuideScreen(),
          type: PageTransitionType.rightToLeftJoined,
          childCurrent: (settings.arguments as Map)["childCurrent"]
        );
      case ProfileRouteNames.favouritesScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _navigationCurve,
          child: FavouriteItemsScreen(),
          type: PageTransitionType.rightToLeftJoined,
          childCurrent: (settings.arguments as Map)["childCurrent"]
        );
      case ProfileRouteNames.donationScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _navigationCurve,
          child: DonationsScreen(),
          type: PageTransitionType.rightToLeftJoined,
          childCurrent: (settings.arguments as Map)["childCurrent"]
        );
      case ProfileRouteNames.profileWebScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _navigationCurve,
          child: BlocProvider(
            create: (context) => WebViewBloc(),
            child: WebViewScreen(
              screenName: (settings.arguments as Map)["screenName"],
              url: (settings.arguments as Map)["url"],
            ),
          ),
          type: PageTransitionType.rightToLeftJoined,
          childCurrent: (settings.arguments as Map)["childCurrent"]
        );
      case ProfileRouteNames.setUpDonationsScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _navigationCurve,
          child: SetUpDonationScreen(),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case ProfileRouteNames.setUpDonationsDetailScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _navigationCurve,
          child: SetupDonationsDetail(),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case ProfileRouteNames.aboutVintedScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _navigationCurve,
          child: AboutScreen(),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case ProfileRouteNames.legalInfoScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _navigationCurve,
          child: LegalInfoScreen(),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case ProfileRouteNames.helpMainScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _navigationCurve,
          child: HelpCenterMainScreen(),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case ProfileRouteNames.helpSubScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _navigationCurve,
          child: HelpCenterSubScreen(
            header: (settings.arguments as Map)["header"],
            list: (settings.arguments as Map)["list"],
          ),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case ProfileRouteNames.helpSearchScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _navigationCurve,
          child: HelpSearchScreen(_helpCenterBloc),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case ProfileRouteNames.dataSettingsScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _navigationCurve,
          child: DataSettingScreen(),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case ProfileRouteNames.downloadDataScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _navigationCurve,
          child: DownloadDataScreen(),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case ProfileRouteNames.langScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _navigationCurve,
          child: LanguageScreen(),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case ProfileRouteNames.emailNotificationScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _navigationCurve,
          child: EmailNotificationScreen(),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case ProfileRouteNames.pushNotificationScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _navigationCurve,
          child: PushNotificationScreen(),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case ProfileRouteNames.securityScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _navigationCurve,
          child: SecurityScreen(),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case ProfileRouteNames.postageScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _navigationCurve,
          child: PostageScreen(),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case ProfileRouteNames.shipAddressScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _navigationCurve,
          child: ShippingAddressScreen(),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case ProfileRouteNames.paymentsScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _navigationCurve,
          child: PaymentsScreen(),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case ProfileRouteNames.accountSettingsScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _navigationCurve,
          child: AccountSettings(),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case ProfileRouteNames.createPasswordScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _navigationCurve,
          child: CreatePasswordScreen(),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case ProfileRouteNames.deleteAccountScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _navigationCurve,
          child: DeleteMyAccountScreen(),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case ProfileRouteNames.bundleDiscountScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _navigationCurve,
          child: BundleDiscountsScreen(),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case ProfileRouteNames.balanceScreen:
        return PageTransition(
          duration: _duration,
          reverseDuration: _duration,
          curve: _navigationCurve,
          child: BalanceScreen(),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      default:
        return null;
    }
  }
}