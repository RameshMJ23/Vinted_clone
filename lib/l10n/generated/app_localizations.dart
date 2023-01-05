
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_lt.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations returned
/// by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// localizationDelegates list, and the locales they support in the app's
/// supportedLocales list. For example:
///
/// ```
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('lt')
  ];

  /// Home bottomNav
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Search bottomNav
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// Sell bottomNav
  ///
  /// In en, this message translates to:
  /// **'Sell'**
  String get sell;

  /// Inbox bottomNav
  ///
  /// In en, this message translates to:
  /// **'Inbox'**
  String get inbox;

  /// Profile bottomNav
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Recommended for you title
  ///
  /// In en, this message translates to:
  /// **'Recommended for you'**
  String get recommendedForYou;

  /// Brands you might like
  ///
  /// In en, this message translates to:
  /// **'Brands you might like'**
  String get brandsYouMightLike;

  /// Shop by category
  ///
  /// In en, this message translates to:
  /// **'Shop by category'**
  String get shopByCategory;

  /// Popular items
  ///
  /// In en, this message translates to:
  /// **'Popular items'**
  String get popularItems;

  /// Shop by brand
  ///
  /// In en, this message translates to:
  /// **'Shop by brand'**
  String get shopByBrand;

  /// Suggested searches
  ///
  /// In en, this message translates to:
  /// **'Suggested searches'**
  String get suggestedSearches;

  /// Newsfeed
  ///
  /// In en, this message translates to:
  /// **'Newsfeed'**
  String get newsFeed;

  /// Wardrobe Spotlight
  ///
  /// In en, this message translates to:
  /// **'Wardrobe Spotlight'**
  String get wardrobeSpotlight;

  /// See all
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// Search for items or members
  ///
  /// In en, this message translates to:
  /// **'Search for items or members'**
  String get searchBarHint;

  /// See all items
  ///
  /// In en, this message translates to:
  /// **'See all items'**
  String get seeAllItems;

  /// Sell an item title
  ///
  /// In en, this message translates to:
  /// **'Sell an item'**
  String get sellAnItem;

  /// Add up to 20 photos text
  ///
  /// In en, this message translates to:
  /// **'Add up to 20 photos'**
  String get addUpTo20Photos;

  /// See photo tips text
  ///
  /// In en, this message translates to:
  /// **'See photo tips'**
  String get seePhotoTips;

  /// Upload photos button
  ///
  /// In en, this message translates to:
  /// **'Upload photos'**
  String get uploadPhotos;

  /// titleTextField
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get titleTextField;

  /// titleFieldHint
  ///
  /// In en, this message translates to:
  /// **'e.g. White COS Jumper'**
  String get titleFieldHint;

  /// Describe your item field
  ///
  /// In en, this message translates to:
  /// **'Describe your item'**
  String get describeItem;

  /// describeItemHint
  ///
  /// In en, this message translates to:
  /// **'e.g. only worn a fw times, true to size'**
  String get describeItemHint;

  /// Category tab
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get categoryTab;

  /// brand tab
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get brandTab;

  /// Condition tab
  ///
  /// In en, this message translates to:
  /// **'Condition'**
  String get conditionTab;

  /// price Tab
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get priceTab;

  /// Material Tab
  ///
  /// In en, this message translates to:
  /// **'Material'**
  String get materialTab;

  /// price Tab
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get uploadButton;

  /// sellScreenDisclaimer
  ///
  /// In en, this message translates to:
  /// **'A professional seller who fraudulently presents itself as a consumer or a non-professional seller on the Vinted platform may be subject to the fines provided for in Article 13 of the Republic of Lithuania Law on the Prohibition of Unfair Business-to-Consumer Commercial Practices.'**
  String get sellScreenDisclaimer;

  /// Save changes before closing dialog title
  ///
  /// In en, this message translates to:
  /// **'Save changes before closing?'**
  String get saveChangesBeforeClosing;

  /// Save dialog button
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Discard dialog button
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get discard;

  /// interestedInSwapping tab
  ///
  /// In en, this message translates to:
  /// **'I\'m interested in swapping this'**
  String get interestedInSwapping;

  /// Size tab
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get sizeTab;

  /// Colour tab
  ///
  /// In en, this message translates to:
  /// **'Colour'**
  String get colorTab;

  /// Messages tab
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messages;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// days ago trailing
  ///
  /// In en, this message translates to:
  /// **'{day} days ago'**
  String daysAgo(String day);

  /// items trailing
  ///
  /// In en, this message translates to:
  /// **'items'**
  String get items;

  /// Make an offer button
  ///
  /// In en, this message translates to:
  /// **'Make an offer'**
  String get makeAnOffer;

  /// Buy button
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get buy;

  /// introText
  ///
  /// In en, this message translates to:
  /// **'Hey! I\'m'**
  String get introText;

  /// reviews
  ///
  /// In en, this message translates to:
  /// **'reviews'**
  String get reviews;

  /// noReview
  ///
  /// In en, this message translates to:
  /// **'no review'**
  String get noReview;

  /// Distance
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get distance;

  /// Last seen
  ///
  /// In en, this message translates to:
  /// **'Last seen'**
  String get lastSeen;

  /// You've offered
  ///
  /// In en, this message translates to:
  /// **'You\'ve offered'**
  String get youOffered;

  /// Declined
  ///
  /// In en, this message translates to:
  /// **'Declined'**
  String get declined;

  /// Write a message here
  ///
  /// In en, this message translates to:
  /// **'Write a message here'**
  String get writeMessageHint;

  /// send button
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// Details screen title
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get detailsScreenTitle;

  /// Add more items button
  ///
  /// In en, this message translates to:
  /// **'Add more items'**
  String get addMoreItems;

  /// Help option
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// Block option
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get block;

  /// report option
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// Delete conversation option
  ///
  /// In en, this message translates to:
  /// **'Delete conversation'**
  String get deleteConversation;

  /// Build a bundle title
  ///
  /// In en, this message translates to:
  /// **'Build a bundle'**
  String get buildABuildScreenTitle;

  /// update button
  ///
  /// In en, this message translates to:
  /// **'UPDATE'**
  String get update;

  /// create A Bundle Explanation
  ///
  /// In en, this message translates to:
  /// **'Create a bundle from items in'**
  String get createABundleExp;

  /// wardrobe ending
  ///
  /// In en, this message translates to:
  /// **'Wardrobe'**
  String get wardrobe;

  /// policy disclaimer at Build a Bundle screen
  ///
  /// In en, this message translates to:
  /// **'If you want to learn more, please read our'**
  String get policyBuildABundle;

  /// Hyper link text at policy disclaimer
  ///
  /// In en, this message translates to:
  /// **'bundle policy'**
  String get policyBuildABundleSplText;

  /// add Button
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get addButton;

  /// remove Button
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get removeButton;

  /// view My Profile subtitle
  ///
  /// In en, this message translates to:
  /// **'View my profile'**
  String get viewMyProfile;

  /// Your guide to Vinted profile option
  ///
  /// In en, this message translates to:
  /// **'Your guide to Vinted'**
  String get yourGuideToVinted;

  /// Favourite items profile option
  ///
  /// In en, this message translates to:
  /// **'Favourite items'**
  String get favouriteItems;

  /// Personalisation profile option
  ///
  /// In en, this message translates to:
  /// **'Personalisation'**
  String get personalisation;

  /// Balance profile option
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balanceOption;

  /// My orders profile option
  ///
  /// In en, this message translates to:
  /// **'My orders'**
  String get myOrders;

  /// Bundle discounts profile option
  ///
  /// In en, this message translates to:
  /// **'Bundle discounts'**
  String get bundleDiscounts;

  /// Donations profile option
  ///
  /// In en, this message translates to:
  /// **'Donations'**
  String get donations;

  /// Forum profile option
  ///
  /// In en, this message translates to:
  /// **'Forum'**
  String get forum;

  /// Holiday mode profile option
  ///
  /// In en, this message translates to:
  /// **'Holiday mode'**
  String get holidayMode;

  /// Settings profile option
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Cookie settings profile option
  ///
  /// In en, this message translates to:
  /// **'Cookie settings'**
  String get cookieSettings;

  /// About Vinted profile option
  ///
  /// In en, this message translates to:
  /// **'About Vinted'**
  String get aboutVinted;

  /// Legal information profile option
  ///
  /// In en, this message translates to:
  /// **'Legal information'**
  String get legalInformation;

  /// Our platform profile option
  ///
  /// In en, this message translates to:
  /// **'Our platform'**
  String get ourPlatform;

  /// helpCenter profile option
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get helpCenter;

  /// Send your feedback profile option
  ///
  /// In en, this message translates to:
  /// **'Send your feedback'**
  String get sendYourFeedback;

  /// Privacy Policy bottom
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// Terms & Condition bottom
  ///
  /// In en, this message translates to:
  /// **'Terms & Condition'**
  String get termsAndCondition;

  /// on status
  ///
  /// In en, this message translates to:
  /// **'on'**
  String get on;

  /// off status
  ///
  /// In en, this message translates to:
  /// **'off'**
  String get off;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'lt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'lt': return AppLocalizationsLt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
