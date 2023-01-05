

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiffy/jiffy.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:vintedclone/screens/router/route_names.dart';

import '../bloc/vendor_selector_bloc/vendor_bloc.dart';
import '../data/model/condition_model.dart';
import '../data/model/location/location_info_model.dart';
import '../data/model/location/location_model.dart';
import '../data/model/photo_tip_model.dart';
import '../data/model/preference_model.dart';
import '../data/model/vendor_model.dart';
import 'package:collection/collection.dart';

String getStreamKey() => "t9uw9qekxq98";

String get getMapKey => "pk.eyJ1IjoicmFtZXNoaXJ2aW5nMjMiLCJhIjoiY2xjaGVrNW5iMDRsOTNvcGc1djcxOG52NCJ9.LxRNpkJV70DySy0pge0g9A";

String get getMapApi => "https://api.mapbox.com/styles/v1/rameshirving23/ckowujt8306yu17o59bln8o9s/tiles/256/{z}/{x}/{y}@2x?access_token=$getMapKey";

enum SignUpTextField{
  fullName,
  userName,
  email,
  password
}

enum CategoryScreenType{
  categoryInSellScreen,
  categoryInFilterScreen
}

Color getBlueColor() => const Color(0xff007782);

Widget getAppBarLeading(
    BuildContext context, {
    Function? leadingFunction,
    bool doPop = true,
    Widget? leadingWidget,
    VoidCallback? onPressed
}) => leadingWidget ?? IconButton(
  icon: const Icon(Icons.arrow_back, color: Colors.black87,),
  onPressed: onPressed ?? (){
    if(leadingFunction != null) leadingFunction();
    FocusManager.instance.primaryFocus!.unfocus();
    if(doPop) Navigator.pop(context);
  },
);


// lang dialog Box
// all buttons in auth screen

Widget buildButton({
  required String content,
  required Color buttonColor,
  required Color contentColor,
  required VoidCallback? onPressed,
  required Color splashColor,
  bool side = false,
  Color? sideColor,
  double fontSize = 16.0,
  double verticalPadding = 10.0
}) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 5.0),
  child: SizedBox(
    width: double.infinity,
    child: MaterialButton(
      highlightColor: Colors.transparent,
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
        side: side
          ? BorderSide(color: sideColor ?? getBlueColor(), width: 1.5)
          : const BorderSide(color: Colors.transparent)
      ),
      highlightElevation: 0.0,
      elevation: 0.0,
      splashColor: splashColor,
      child: Text(
        content,
        style: TextStyle(
          fontFamily: "MaisonMedium",
          color: contentColor,
          fontSize: fontSize
        ),
      ),
      color: buttonColor,
      onPressed: onPressed,
    ),
  ),
);

AppBar getAppBar({
  required BuildContext context,
  required String title,
  bool showLeading = true,
  Widget? titleWidget,
  List<Widget>? trailingWidget,
  Function? leadingFunction,
  bool doPop = true,
  Widget? leadingWidget,
  double? leadingWidth,
  double titleFontSize = 18.0
}) => AppBar(
  leadingWidth: leadingWidth,
  title: titleWidget ?? Text(
    title,
    style: TextStyle(
      fontFamily: "MaisonMedium",
      color: Colors.black87,
      fontSize: titleFontSize
    ),
  ),
  leading: showLeading ? getAppBarLeading(
    context,
    leadingFunction: leadingFunction,
    doPop: true,
    leadingWidget: leadingWidget,
  ): null,
  elevation: 0.5,
  backgroundColor: Colors.grey[50],
  actions: trailingWidget,
);

List<Widget> getFilterTrailingWidget(VoidCallback onPressed) => [
  TextButton(
    onPressed: onPressed,
    child: const Text(
      "CLEAR ALL",
      style: TextStyle(
          fontFamily: "MaisonMedium",
          color: Colors.black87,
          fontSize: 16.0
      ),
    )
  )
];

Widget getCloseLeadingWidget({
  required BuildContext context,
  VoidCallback? onPressed
}) => IconButton(
  onPressed: onPressed ?? (){
    Navigator.pop(context);
  },
  icon: const Icon(Icons.close, color: Colors.black87,)
);

// Textfields in signup and login screen
Widget buildTextField({
  required String hintText,
  String? helperText,
  String? errorText,
  VoidCallback? onTap,
  Function(String?)? onChanged,
  required TextEditingController controller,
  bool obscureText = false,
  required String? Function(String?) validatorFunc,
  bool multiLine = false,
  double marginPadding = 5.0,
  bool autoFocus = false,
  GlobalKey<FormFieldState>? key,
  double? errorTextSize = 14.0,
  Color? errorTextColor,
  Widget? trailingWidget,
  TextInputType? keyboardType,
  ValueChanged<bool>? onFocusFunc,
  int? maxLength
}) => Padding(
  padding: EdgeInsets.symmetric(vertical: marginPadding),
  child: Focus(
    child: TextFormField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength),
      ],
      //maxLength: maxLength,
      key: key,
      autofocus: autoFocus,
      expands: multiLine,
      validator: validatorFunc,
      controller: controller,
      onTap: onTap,
      minLines: null,
      maxLines: multiLine ? null : 1,
      onChanged: onChanged,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          hintMaxLines: 3,
          contentPadding: EdgeInsets.zero,
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: "MaisonLight",
            fontSize: 15.0,
            color: Colors.grey.shade700,
            overflow: TextOverflow.clip
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: getBlueColor())
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade200)
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300)
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: errorTextColor ?? getBlueColor())
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: errorTextColor ?? getBlueColor())
          ),
          helperText: helperText,
          errorText: errorText,
          helperMaxLines: 3,
          errorMaxLines: 2,
          errorStyle: TextStyle(
              fontFamily: "MaisonMedium",
              fontSize: errorTextSize,
              color: errorTextColor
          ),
          suffixIcon: trailingWidget
      ),
      obscureText: obscureText,
      cursorColor: getBlueColor(),
      style: const TextStyle(
        fontFamily: "MaisonLight",
        fontSize: 16.0
      ),
      buildCounter: null,
    ),
    onFocusChange: onFocusFunc,
  ),
);

// text button in sign up, login screens

Widget buildTextButton({
  required String content,
  required VoidCallback? onPressed,
  double fontSize = 16.0,
  bool? enabled,
  Color? buttonColor,
  double vertPadding = 20.0
}) => GestureDetector(
  child: Padding(
    child: Text(
      content,
      style: TextStyle(
        fontFamily: "MaisonMedium",
        fontSize: fontSize,
        color: enabled == null
          ? buttonColor ?? getBlueColor()
          : enabled
          ? buttonColor ?? getBlueColor()
          : Colors.grey.shade700
      ),
    ),
    padding: EdgeInsets.symmetric(vertical: vertPadding),
  ),
  onTap: onPressed
);

showErrorDialog(BuildContext context, String content){
  showDialog(
      context: context,
      builder: (dialogContext){
        return AlertDialog(
          title: const Text(
            "Error",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "MaisonMedium",
                fontSize: 22.0
            ),
          ),
          content: Text(
              content,
              style:  TextStyle(
                  fontFamily: "MaisonMedium",
                  fontSize: 16.0,
                  color: Colors.grey.shade600
              )
          ),
          actions: [
            buildButton(
                content: "OK",
                buttonColor: getBlueColor(),
                contentColor: Colors.white,
                onPressed: (){
                  Navigator.pop(dialogContext);
                },
                splashColor: Colors.white24
            )
          ],
        );
      }
  );
}

Widget getUserImage(
  String? photoUrl,
  { double size = 30.0,
    double borderRadius = 20.0,
    ImageProvider? assetWidget
  }
){
  return (photoUrl == null)
  ? Container(
    height: size,
    width: size,
    decoration: BoxDecoration(
      image:  DecorationImage(
        image: assetWidget ?? const AssetImage(
          "assets/empty_user_photo.jpg"
        )
      ),
      borderRadius: BorderRadius.circular(size)
    ),
  ): Container(
    height: size,
    width: size,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(
          photoUrl
        )
      ),
      borderRadius: BorderRadius.circular(borderRadius)
    ),
  );
}

Widget getSpacingWidget(
  BuildContext context
) => Container(
  height: 20.0,
  color: Colors.grey.shade300,
  width: MediaQuery.of(context).size.width,
);

Widget customRadioButton(
  bool selected,
  {double size = 25.0, double centerCircleRadius = 4.0}
) => SizedBox(
  height: size,
  width: size,
  child: Stack(
    children: [
      Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selected ? getBlueColor() : Colors.transparent,
            border: Border.all(color: !selected ? Colors.grey : Colors.transparent)
          ),
          height: size,
          width: size
      ),
      Center(
        child: CircleAvatar(
          backgroundColor: selected ? Colors.white : Colors.transparent,
          maxRadius: centerCircleRadius,
        ),
      )
    ],
  ),
);

AppBar getSearchAppBar({
  VoidCallback? onTap,
  bool showLeading = false,
  List<Widget>? actionWidgets,
  required BuildContext context,
  String hintText = "Search for items or members",
  GlobalKey? key,
  Widget? leading
}) => AppBar(
  key: key,
  leadingWidth: showLeading ? 40.0 : 0.0,
  leading: showLeading
    ? getAppBarLeading(context, leadingWidget: leading)
    : const SizedBox(height: 0.0, width: 0.0,),
  centerTitle: true,
  elevation: 0.2,
  title: GestureDetector(
    child: buildSearchTypeTextField(
      content: [
        Icon(
          Icons.search,
          color: Colors.grey.shade600,
          size: 20.0,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: Text(
              hintText,
              style: TextStyle(
                fontFamily: "MaisonBook",
                fontSize: 15.0,
                color: Colors.grey.shade600
              ),
            ),
          ),
        )
      ]
    ),
    onTap: onTap,
  ),
  backgroundColor: Colors.grey[50],
  actions: actionWidgets,
);

Widget buildSearchTypeTextField({required List<Widget> content}) => Container(
  margin: const EdgeInsets.symmetric(vertical: 5.0),
  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
  width: double.infinity,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(5.0),
    color: Colors.grey.shade300
  ),
  child: Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: content,
  ),
);

Widget getBottomSheetScrollHeader() => Container(
  width: double.infinity,
  color: Colors.transparent,
  height: 20.0,
  child: Align(
    child: Container(
      width: 40.0,
      height: 6.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white70
      ),
    ),
    alignment: Alignment.center,
  ),
);

Widget getBottomSheetContentHeader(
  String sheetName,
  BuildContext sheetContext
) => Container(
  height: 30.0,
  //color: Colors.orangeAccent,
  width: double.infinity,
  child: Stack(
    children: [
      Center(
        child: Text(
          sheetName,
          style: const TextStyle(
            fontFamily: "MaisonMedium",
            color: Colors.black87,
            fontSize: 16.0
          ),
        ),
      ),
      Positioned(
        top: -7,
        right: 10.0,
        child: Align(
          child: IconButton(
            icon: const Icon(Icons.clear, size: 32.0, color: Colors.black87,),
            onPressed: (){
              Navigator.pop(sheetContext);
            },
          ),
        ),
      )
    ],
  ),
);

Widget getProfileInfoWidget({
  required String title,
  required Widget subTitle,
  required String? imageLink,
  required VoidCallback onTap
}) => ListTile(
  contentPadding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
  title: Text(
    title,
    style: const TextStyle(
      fontFamily: "MaisonMedium",
      color: Colors.black,
      fontSize: 16
    ),
  ),
  subtitle: subTitle,
  leading: getUserImage(imageLink, size: 50.0),
  trailing: getTrailingIcon(),
  onTap: onTap,
);

Widget getTrailingIcon() => Icon(
  Icons.arrow_forward_ios,
  size: 16.0,
  color: Colors.grey.shade400,
);

List<String> getPageKey() => [
  "home",
  "search",
  "sell",
  "inbox",
  "profile"
];

Widget buildCheckBoxTileWidget({
  required VoidCallback onTap,
  required Widget trailingWidget,
  required String tileName,
  String? subTitle,
  double verticalPadding = 0.0,
  double horizontalPadding = 0.0
}) => GestureDetector(
  child: SizedBox(
    child: Padding(
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: horizontalPadding
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tileName,
                  style: const TextStyle(
                    fontFamily: "MaisonMedium",
                    color: Colors.black87,
                    fontSize: 16.0
                  ),
                ),
                if(subTitle != null) Text(
                  subTitle,
                  style: TextStyle(
                    fontFamily: "MaisonMedium",
                    color: Colors.grey.shade700,
                    fontSize: 16.0
                  ),
                )
              ],
            )
          ),
          Transform.scale(
            scale: 1.5,
            child: trailingWidget,
          )
        ],
      ),
    ),
  ),
  onTap: onTap,
);

Widget buildCustomCheckBox(bool isSelected) => Checkbox(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(3.0),
    ),
    visualDensity: const VisualDensity(horizontal: -4 ,vertical: -4),
    onChanged: (val){

    },
    value: isSelected,
    activeColor: getBlueColor(),
    checkColor: Colors.white,
    side: BorderSide(color: Colors.grey.shade500, width: 0.8)
);


// For brand screen and Filter brand screen
Widget buildBrandHeading(String headingName) => Padding(
  padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5.0, top: 30.0),
  child: Text(
    headingName,
    style: TextStyle(
      fontFamily: "MaisonBook",
      fontSize: 15.0,
      color: Colors.grey.shade600
    ),
  ),
);

List<String> getSortByList() => [
  "Relevance",
  "Price: high to low",
  "Price: low to high",
  "Newest first"
];


List<ConditionModel> getConditionList() => [
  ConditionModel(
    conditionTitle: "New with tags",
    conditionDefinition: "Just like in the store. The tags are still attached "
        "and/or it’s packed in the original packaging. "
        "Never used and has no flaws."
  ),
  ConditionModel(
    conditionTitle: "New without tags",
    conditionDefinition: "Brand new, but the tags or original "
        "packaging isn’t there. Never used and has no flaws."
  ),
  ConditionModel(
    conditionTitle : "Very good",
    conditionDefinition: "Used a few times, but still looks great. It might have "
        "a few slight imperfections, which are clearly shown "
        "and mentioned in your listing."
  ),
  ConditionModel(
    conditionTitle: "Good",
    conditionDefinition: "Used frequently and may have signs of wear,"
        " which are clearly shown and mentioned in your listing."
  ),
  ConditionModel(
    conditionTitle: "Satisfactory",
    conditionDefinition: "Used a lot and has defects, which are "
        "clearly shown and mentioned in your listing."
  )
];

List<PhotoTipModel> getPhotoTipList() => [
  PhotoTipModel(
      heading: "Use your own images",
      imageUrl: "https://5a2583d7dd16c25cb2e8-358d15e499fca729302e63598be13736.ssl.cf3.rackcdn.com/uploads/classifiers/photo_tip/image/66/main_5.png",
      definition: "Take photos yourself or ask a friend for help. Copyrighted images are not allowed."
  ),
  PhotoTipModel(
      heading: "Don't use flash",
      imageUrl: "https://5a2583d7dd16c25cb2e8-358d15e499fca729302e63598be13736.ssl.cf3.rackcdn.com/uploads/classifiers/photo_tip/image/64/main_3.png",
      definition: "Artificial light can distort colours, so avoid using the flash."
  ),
  PhotoTipModel(
      heading: "Choose natural light",
      imageUrl: "https://5a2583d7dd16c25cb2e8-358d15e499fca729302e63598be13736.ssl.cf3.rackcdn.com/uploads/classifiers/photo_tip/image/62/main_1.png",
      definition: "Take photos in a well-lit area. Bright daylight is best."
  ),
  PhotoTipModel(
      heading: "Pick a neutral background",
      imageUrl: "https://5a2583d7dd16c25cb2e8-358d15e499fca729302e63598be13736.ssl.cf3.rackcdn.com/uploads/classifiers/photo_tip/image/63/main_2.png",
      definition: "Use an uncluttered, neutral background to make your item stand out."
  ),
  PhotoTipModel(
      heading: "Show off your item",
      imageUrl: "https://5a2583d7dd16c25cb2e8-358d15e499fca729302e63598be13736.ssl.cf3.rackcdn.com/uploads/classifiers/photo_tip/image/65/main_4.png",
      definition: "Take photos from multiple angles. Don't forget the details: labels, signs of wear, defects, etc."
  ),
];

Widget getSwitchListTile({
  required String tileName,
  required bool isSelected,
  String? subTitle,
  bool showDivider = false,
  double dividerHeight = 0.5,
  bool? initialVal
}) => Column(
  children: [
    ListTile(
      title: Text(
        tileName,
        style: const TextStyle(
          fontFamily: "MaisonMedium",
          fontSize: 16.0,
          color: Colors.black87
        ),
      ),
      subtitle: subTitle != null
      ? Text(
        subTitle,
        style: TextStyle(
          fontSize: 15.5,
          fontFamily: "MaisonBook",
          color: Colors.grey.shade600
        ),
      ): null,
      tileColor: Colors.white,
      trailing: buildSwitch(
          horPad: 0.0, enabled: true, initialValue: initialVal,
      ),
    ),
    if(showDivider) Divider(height: dividerHeight, color: Colors.grey.shade600,)
  ],
);

Widget lastSeenWidget(Channel channel, TextStyle lastSeenStyle) => Row(
  children: [
    Icon(
      Icons.timer,
      size: 18.0,
      color: Colors.grey.shade600,
    ),
    const SizedBox(width: 3.0,),
    BetterStreamBuilder<List<Member>>(
      stream: channel.state!.membersStream,
      initialData: channel.state!.members,
      builder: (context, data) => ConnectionStatusBuilder(
        statusBuilder: (context, status) {
          switch (status) {
            case ConnectionStatus.connected:
              return _buildConnectedTitleState(context, data, lastSeenStyle);
            case ConnectionStatus.connecting:
              return Text(
                'Connecting',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,
                ),
              );
            case ConnectionStatus.disconnected:
              return Text(
                'Offline',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,
                ),
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    )
  ],
);

Widget _buildConnectedTitleState(
    BuildContext context,
    List<Member>? members,
    TextStyle lastSeenStyle
 ) {
  Widget? alternativeWidget;

  final channel = StreamChannel
      .of(context)
      .channel;

  final memberCount = channel.memberCount;
  if (memberCount != null && memberCount > 2) {
    var text = 'Members: $memberCount';
    final watcherCount = channel.state?.watcherCount ?? 0;
    if (watcherCount > 0) {
      text = 'watchers $watcherCount';
    }
    alternativeWidget = Text(
      text,
    );
  } else {

    final userId = StreamChatCore
      .of(context)
      .currentUser
      ?.id;

    final otherMember = members?.firstWhereOrNull(
        (element) => element.userId != userId,
    );

    if (otherMember != null) {
      if (otherMember.user?.online == true) {
        alternativeWidget = Text(
          'Online',
          style: lastSeenStyle,
        );
      } else {
        alternativeWidget = Text(
          'Last seen: '
              '${Jiffy(otherMember.user?.lastActive).fromNow()}',
          style: lastSeenStyle,
        );
      }
    }
  }

  return alternativeWidget ?? Text(
      "Unknown",
      style: TextStyle(
        fontFamily: "MaisonMedium",
        fontSize: 10,
        fontWeight: FontWeight.bold,
        color: Colors.grey.shade700,
      )
  );
}

Widget getLastSeenWithUser({
  required User? user,
  required TextStyle textStyle
}){

  Widget? alternativeWidget;

  if (user?.online == true) {
    alternativeWidget = Text(
      'Online',
      style: textStyle,
    );
  } else {
    alternativeWidget = Text(
      'Last seen: '
          '${Jiffy(user?.lastActive).fromNow()}',
      style: textStyle,
    );
  }

  return Row(
    children: [
      Icon(
        Icons.timer,
        size: 18.0,
        color: Colors.grey.shade600,
      ),
      const SizedBox(width: 8.0,),
      alternativeWidget
    ],
  );
}

class ConnectionStatusBuilder extends StatelessWidget {
  /// Creates a new ConnectionStatusBuilder
  const ConnectionStatusBuilder({
    Key? key,
    required this.statusBuilder,
    this.connectionStatusStream,
    this.errorBuilder,
    this.loadingBuilder,
  }) : super(key: key);

  /// The asynchronous computation to which this builder is currently connected.
  final Stream<ConnectionStatus>? connectionStatusStream;

  /// The builder that will be used in case of error
  final Widget Function(BuildContext context, Object? error)? errorBuilder;

  /// The builder that will be used in case of loading
  final WidgetBuilder? loadingBuilder;

  /// The builder that will be used in case of data
  final Widget Function(BuildContext context, ConnectionStatus status)
  statusBuilder;

  @override
  Widget build(BuildContext context) {
    final stream = connectionStatusStream ??
        StreamChatCore.of(context).client.wsConnectionStatusStream;
    final client = StreamChatCore.of(context).client;
    return BetterStreamBuilder<ConnectionStatus>(
      initialData: client.wsConnectionStatus,
      stream: stream,
      noDataBuilder: loadingBuilder,
      errorBuilder: (context, error) {
        if (errorBuilder != null) {
          return errorBuilder!(context, error);
        }
        return const Offstage();
      },
      builder: statusBuilder,
    );
  }
}

buildDonationsHeader({
  required String headerTitle,
  VoidCallback? onPressed,
  double? titleVertPadding,
  double? titleHorizontalPadding,
  double headerTopPadding = 30.0
})=> Padding(
  padding: EdgeInsets.only(top: headerTopPadding),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      buildDonationHeaderTitle(
        headerTitle: headerTitle,
        vertPadding: titleVertPadding,
        horizontalPadding: titleHorizontalPadding
      ),
      InkWell(
        child: Container(
          height: 200.0,
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60.0,
                width: 60.0,
                child: Image.asset(
                  "assets/UNHCR_logo.png"
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      "UNHCR's Ukraine Emergency Relief Appeal",
                      style: TextStyle(
                          color: Colors.black87,
                          fontFamily: "MaisonMedium",
                          fontSize: 16.0
                      ),
                    ),
                    Text(
                        "A campaign to support those affected by war in Ukraine."
                            " Bonus: our payment provider will match the amount you donate to this cause.",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontFamily: "MaisonMedium",
                          fontSize: 16.0
                        )
                    )
                  ],
                ),
              ),
              Container(
                width: 40,
                height: double.infinity,
                alignment: Alignment.center,
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 20.0,
                  color: Colors.grey.shade700,
                ),
              )
            ],
          ),
        ),
        onTap: onPressed,
      )
    ],
  ),
);

buildDonationHeaderTitle({
  required String headerTitle,
  double? vertPadding,
  double? horizontalPadding
}) => Padding(
  child: Text(
    headerTitle,
    style: TextStyle(
      color: Colors.grey.shade600
    ),
  ),
  padding: EdgeInsets.symmetric(
    vertical: vertPadding ?? 10.0,
    horizontal: horizontalPadding ?? 10.0
  ),
);


// For web screen options in Your vinted guide and about

Widget buildGuideOptions({
  required String guideName,
  VoidCallback? onTap,
  String? subTitle
}) => ListTile(
  title: Text(
    guideName,
    style: const TextStyle(
      fontSize: 16.0,
      fontFamily: "MaisonMedium",
    ),
  ),
  trailing: Icon(
    Icons.arrow_forward_ios,
    size: 16.0,
    color: Colors.grey.shade400,
  ),
  subtitle: subTitle != null
  ? Text(
    subTitle,
    style: TextStyle(
      fontFamily: "MaisonMedium",
      fontSize: 16.0,
      color: Colors.grey.shade600
    ),
  ) : null,
  focusColor: Colors.grey.shade100,
  hoverColor: Colors.grey.shade100,
  selectedColor: Colors.grey.shade100 ,
  onTap: onTap,
);

Widget buildGuideWithMultiTrail({
  required String title,
  required String trailingText,
  VoidCallback? onTap,
  IconData trailingIcon = Icons.arrow_forward_ios,
  double trailingIconSize = 15.0,
  Widget? leading,
  Color color = Colors.white
}) => InkWell(
  child: Container(
    color: color,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if(leading != null) leading,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontFamily: "MaisonMedium",
                ),
              ),
            )
          ],
        ),
        Row(
          children: [
            Text(
              trailingText,
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: "MaisonMedium",
                color: Colors.grey.shade600
              ),
            ),
            const SizedBox(width: 8.0,),
            Icon(
              trailingIcon,
              color: Colors.grey.shade600,
              size: trailingIconSize,
            )
          ],
        )
      ],
    ),
    padding:  const EdgeInsets.symmetric(
      horizontal: 18.0,
      vertical: 15.0
    ),
  ),
  onTap: onTap,
);


Widget buildGuidOptionWithDiv({
  required String guideName,
  VoidCallback? onTap,
  String? subTitle,
  double divHeight = 0.5
}) => Column(
  children: [
    buildGuideOptions(guideName: guideName, onTap: onTap, subTitle: subTitle),
    Divider(height: divHeight, color: Colors.grey.shade300, thickness: 1.2,)
  ],
);

// For common search screen starting text

Widget buildIntroText(String text1, String text2) => Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Text(
      text1,
      style: const TextStyle(
          fontFamily: "MaisonMedium",
          color: Colors.black87,
          fontSize: 24.0
      ),
    ),
    const SizedBox(
      height: 15.0,
    ),
    Text(
      text2,
      style: TextStyle(
          fontFamily: "MaisonMedium",
          color: Colors.grey.shade700,
          fontSize: 16.0
      ),
      textAlign: TextAlign.center,
    )
  ],
);

// For brand screen and common search screen
Widget buildFilledSearchTextField({
  TextEditingController? controller ,
  Function(String)? onChanged,
  String? hintText,
  VoidCallback? suffixOnPressed,
  required bool showSuffix
}) => TextField(
  controller: controller,
  autofocus: true,
  cursorColor: getBlueColor(),
  onChanged: onChanged,
  decoration: InputDecoration(
      contentPadding: EdgeInsets.zero,
      prefixIcon: Icon(
        Icons.search,
        color: Colors.grey.shade500,
      ),
      hintText: hintText,
      hintStyle: TextStyle(
        fontSize: 16.0,
        fontFamily: "MaisonBook",
        color: Colors.grey.shade700,
      ),
      filled: true,
      fillColor: Colors.grey.shade200,
      border: _getbuildFilledSearchTextFieldBorder(),
      enabledBorder: _getbuildFilledSearchTextFieldBorder(),
      focusedBorder: _getbuildFilledSearchTextFieldBorder(),
      suffixIcon: showSuffix ? IconButton(
        splashColor: Colors.transparent,
        onPressed: suffixOnPressed,
        icon: const Icon(Icons.close, color: Colors.black87, size: 18.0,)
      ): const SizedBox.shrink()
  ),
  style: TextStyle(
    fontSize: 16.0,
    fontFamily: "MaisonBook",
    color: Colors.grey.shade800,
  ),
);

OutlineInputBorder _getbuildFilledSearchTextFieldBorder() => OutlineInputBorder(
  borderRadius: BorderRadius.circular(5.0),
  borderSide: const BorderSide(color: Colors.transparent)
);

Widget buildHelpScreenHeader(String content) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
  child: Text(
    content,
    style: const TextStyle(
      fontFamily: "MaisonMedium",
      fontSize: 24.0,
      color: Colors.black87
    ),
  ),
);

Widget buildPreferenceTile(
    String title,
    String content,
    bool choosable,
    bool isHeader,
    bool showVendors,
    TitleStyle titleStyle,
    BuildContext context,
    bool showLearnMore
){
  TextStyle textStyle = (isHeader)
      ? _headerStyle()
      : (titleStyle == TitleStyle.title1)
      ? titleStyle1()
      : _titleStyle2();

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildHeaderOne(
                      title,
                      textStyle
                    ),
                  ),
                  if(!choosable && !isHeader) Text(
                    "Always Active",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontFamily: "MaisonBook",
                      fontSize: 15.0
                    ),
                  )
                ],
              ),
              buildSubText(
                content
              ),
              const SizedBox(height: 8.0,),
              if(isHeader) _buildHeaderBottom(context),
              if(showVendors) _buildListOfIABVendors(context),
              if(showLearnMore) _buildLearnMore(context)
            ],
          ),
        ),
        if(choosable) buildSwitch(enabled: true),
      ],
    ),
  );
}

Widget _buildListOfIABVendors(BuildContext context) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 10.0),
  child: _buildBottomText(
      "List of IAB Vendors",
          () {
        Navigator.pushNamed(
            context,
            RouteNames.vendorScreen
        );
      }
  ),
);

Widget _buildHeaderBottom(BuildContext context) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 10.0),
  child: Row(
    children: [
      _buildBottomText("More information", () {
        Navigator.pushNamed(
          context,
          RouteNames.webScreen,
          arguments: {
            "screenName": "Cookie Notices and Cookie Consent",
            "url": "https://cookiepedia.co.uk/"
          });
      }),
      const Text(" • "),
      _buildBottomText("View Full Legal Text", () {

        Navigator.pushNamed(
          context,
          RouteNames.webScreen,
          arguments: {
            "screenName": "IAB TCF legal text | Cookiepedia",
            "url": "https://tcf.cookiepedia.co.uk/"
          });
      })
    ],
  ),
);

TextStyle _headerStyle() => const TextStyle(
  fontFamily: "MaisonMedium",
  fontSize: 22.0,
);

TextStyle titleStyle1() => const TextStyle(
  color: Colors.black87,
  fontSize: 16.0,
);

TextStyle _titleStyle2() => TextStyle(
  color: Colors.grey.shade600,
  fontSize: 15.0,
);

Widget _buildBottomText(
  String content,
  VoidCallback onTap
) => GestureDetector(
  child: Text(
    content,
    style: TextStyle(
      decoration: TextDecoration.underline,
      color: getBlueColor(),
      fontSize: 16.0
    ),
  ),
  onTap: onTap,
);

Widget _buildLearnMore(BuildContext context) => GestureDetector(
  child: Text(
    "Learn more",
    style: TextStyle(
      color: getBlueColor(),
      fontSize: 16.0
    ),
  ),
  onTap: (){
    Navigator.pushNamed(
      context,
      RouteNames.webScreen,
      arguments: {
        "screenName": "third-party tracking",
        "url": "https://tcf.cookiepedia.co.uk/"
      });
  },
);

Text buildSubText(String content) => Text(
  content,
  style: TextStyle(
    fontFamily: "MaisonBook",
    color: Colors.grey.shade700,
    fontSize: 16.0
  ),
);


Widget _buildHeaderOne(
  String content,
  TextStyle style
) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 5.0),
  child: Text(
    content,
    style: style,
  ),
);

/*class buildSwitch extends StatelessWidget {

  double horPad;
  bool? selected;
  bool enabled;
  Function(bool)? onChange;

  buildSwitch({
    this.horPad = 10.0,
    this.selected,
    this.enabled = true,
    this.onChange,

  });

  final ValueNotifier<bool> _switchNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horPad),
      child: Transform.scale(
        child: ValueListenableBuilder(
          valueListenable: _switchNotifier,
          builder: (context, bool isSelected, child){
            return CupertinoSwitch(
              activeColor: getBlueColor(),
              value: isSelected,
              onChanged: (enabled)
                ? (val){
                  if(onChange != null) onChange!(val);

                  _switchNotifier.value = val;
                }
                : null,
            );
          },
        ),
        scale: 0.80,
      ),
    );
  }
}*/

class buildSwitch extends StatefulWidget {

  double horPad;
  bool? selected;
  bool enabled;
  Function(bool)? onChange;
  bool? initialValue;

  buildSwitch({
    this.horPad = 10.0,
    this.selected,
    this.enabled = true,
    this.onChange,
    this.initialValue
  });

  @override
  _buildSwitchState createState() => _buildSwitchState();
}

class _buildSwitchState extends State<buildSwitch> {

  late ValueNotifier<bool> _switchNotifier;

  @override
  void initState() {
    // TODO: implement initState
   _switchNotifier = ValueNotifier<bool>(widget.initialValue ?? false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.horPad),
      child: Transform.scale(
        child: ValueListenableBuilder(
          valueListenable: _switchNotifier,
          builder: (context, bool isSelected, child){
            return CupertinoSwitch(
              activeColor: getBlueColor(),
              value: isSelected,
              onChanged: (widget.enabled)
              ? (val){
                if(widget.onChange != null) widget.onChange!(val);
                _switchNotifier.value = val;
              }
              : null,
            );
          },
        ),
        scale: 0.80,
      ),
    );
  }
}



// Used in setting screens
Widget buildBaseContainer({
  required String containerName,
  required List<Widget> children,
  double vertPad = 22.0,
  bool showBorder = true
}) => Container(
  decoration: BoxDecoration(
    color: Colors.white,
    border: showBorder ? Border(
      top: BorderSide(color: Colors.grey.shade300),
      bottom: BorderSide(color: Colors.grey.shade300)
    ): null
  ),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(
          vertical: vertPad,
          horizontal: 18.0
        ),
        child: Text(
          containerName,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.grey.shade600
          ),
        ),
      ),
      ...children
    ],
  ),
);

Text buildTextFieldLabel({
  required String textFieldName,
  double fontSize = 16.0
}) => Text(
  textFieldName,
  style: TextStyle(
    fontFamily: "MaisonBook",
    color: Colors.grey.shade600,
    fontSize: fontSize
  ),
);

Widget buildPaymentIcons({
  required String imageUrl,
  required Color borderColor,
  required double borderRadius,
  double height = 20.0,
  double width = 30.0
}) => Container(
  margin: const EdgeInsets.symmetric(horizontal: 5.0),
  padding: const EdgeInsets.symmetric(horizontal: 3.0),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(borderRadius),
    border: Border.all(color: borderColor),
    color: Colors.grey[50],
  ),
  height: height,
  width: width,
  child: Image.asset(
    imageUrl
  ),
);

buildCustomSnackBar({
  required String content,
  required IconData iconData,
  required Color iconColor,
  required BuildContext context,
  double? iconSize = 35.0,
  Duration? duration,
  double marginHorizontalPadding = 20,
  double elevation = 4.0,
  double contentVertPadding = 0.0,
  double marginTopPadding = 8.0,
  double iconLeftPadding = 20.0,
  double iconRightPadding = 20.0
}){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: duration ?? const Duration(milliseconds: 800),
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0)
      ),
      backgroundColor: Colors.white,
      dismissDirection: DismissDirection.horizontal,
      content: Padding(
        padding: EdgeInsets.symmetric(vertical: contentVertPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: iconLeftPadding,
                right: iconRightPadding
              ),
              child: Icon(
                iconData,
                color: iconColor,
                size: iconSize,
              ),
            ),
            Expanded(
              child: Text(
                content,
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: "MaisonBook",
                  color: Colors.grey.shade600
                ),
              ),
            )
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
      padding: EdgeInsets.fromLTRB(
        marginHorizontalPadding,
        marginTopPadding,
        20,
        marginHorizontalPadding
      ),
    )
  );
}

Widget buildSpacingText({
  required String content,
  double topPad = 10,
  double bottomPad = 20,
  double rightPad = 18,
  double leftPad = 18,
}) => Container(
  padding: EdgeInsets.fromLTRB(
    leftPad,
    topPad,
    rightPad,
    bottomPad
  ),
  color: Colors.grey.shade300,
  child: Text(
    content,
    style: TextStyle(
      color: Colors.grey.shade600,
      fontSize: 12.0,
      fontFamily: "MaisonBook"
    ),
  ),
);

Widget buildAccountsTile({
  required String title,
  Widget? subTitle,
  Widget? trailing,
  Widget? leading,
  bool showDivider = false,
  double vertPad = 5.0
}) => Column(
  children: [
    ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: vertPad, horizontal: 18.0),
      leading: leading,
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: "MaisonMedium",
          color: Colors.black87
        ),
      ),
      subtitle: subTitle,
      trailing: trailing,
    ),
    if(showDivider) Divider(height: 0.5, color: Colors.grey.shade300,)
  ],
);

Widget buildAccountButton({
  required String buttonName,
  required VoidCallback? onTap,
  double width = 70.0
}) => SizedBox(
  height: 40.0,
  width: width,
  child: buildButton(
    verticalPadding: 0.0,
    content: buttonName,
    buttonColor: Colors.transparent,
    contentColor: getBlueColor().withOpacity(0.7),
    onPressed: onTap,
    side: true,
    sideColor: getBlueColor().withOpacity(0.7),
    splashColor: getBlueColor().withOpacity(0.2),
    fontSize: 13.0
  ),
);

Widget getPersonalisationBrandWidget({
  required Color buttonColor,
  required Color contentColor,
  required Color sideColor,
  String? brandName,
  String? fans,
  String? items,
  double buttonHeight = 48.0,
  double buttonWidth = 80.0,
  double buttonFontSize = 14.0,
  bool showFans = true,
  String buttonName = "Follow",
  VoidCallback? onTap,
}) => Column(
  children: [
    ListTile(
      title: Text(
       brandName ?? "H&M",
        style: const TextStyle(
          fontFamily: "MaisonMedium",
          color: Colors.black87,
          fontSize: 16.0
        ),
      ),
      subtitle: Text(
        showFans
          ? "${fans ?? "3M"} fans • ${items ?? "48.9M"} items"
          : "${items ?? "48.9M"} items",
        style: TextStyle(
          fontFamily: "MaisonMedium",
          color: Colors.grey.shade600,
          fontSize: 16.0
        )
      ),
      trailing: SizedBox(
        width: buttonWidth,
        height: buttonHeight,
        child: buildButton(
          fontSize: buttonFontSize,
          content: buttonName,
          buttonColor: buttonColor,
          contentColor: contentColor,
          onPressed: onTap,
          splashColor: Colors.white24,
          sideColor: sideColor,
          side: true
        ),
      ),
    ),
    const Divider()
  ],
);

Widget buildMasterCard({
  bool showBorder = true,
  double height = 20.0,
  double width = 30.0
}) => buildPaymentIcons(
  imageUrl: "assets/mastercard_logo.jpg",
  borderColor: showBorder ? Colors.grey.shade200: Colors.transparent,
  borderRadius: 3.0,
  height: height,
  width: width
);

Widget buildVisaCard({
  bool showBorder = true,
  double height = 20.0,
  double width = 30.0
}) => buildPaymentIcons(
  imageUrl: "assets/visa_logo.jpg",
  borderColor: showBorder ? Colors.grey.shade200: Colors.transparent,
  borderRadius: 3.0,
  height: height,
  width: width
);

Widget buildDiscoverCard({
  bool showBorder = true,
  double height = 20.0,
  double width = 30.0
}) => buildPaymentIcons(
  imageUrl: "assets/discover_logo.png",
  borderColor: showBorder ? Colors.grey.shade200: Colors.transparent,
  borderRadius: 3.0,
  height: height,
  width: width
);

Widget buildLocationInfo(
  LocationModel markerState
) => Row(
  children: [
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 10.0
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 40.0,
                  height: 25.0,
                  child: Image.asset(
                    _getImage(markerState.locationInfo.providerEnum)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    markerState.locationInfo.providerName,
                    style: const TextStyle(
                        color: Colors.black87,
                        fontFamily: "MaisonMedium",
                        fontSize: 16.0
                    ),
                  ),
                )
              ],
            ),
          ),
          Text(
            "€" + markerState.locationInfo.cost,
            style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black87,
                fontFamily: "MaisonMedium"
            ),
          ),
          buildInfoLine(
            content: markerState.locationInfo.addressFirstLine,
            iconData: Icons.location_on_outlined
          ),
          buildInfoLine(
            content: markerState.locationInfo.detailedAddress,
            iconData: Icons.location_on_outlined
          ),
          buildInfoLine(
            content: markerState.locationInfo.timeTaken,
            iconData: Icons.timelapse_outlined
          )
        ],
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey.shade600,
        size: 15.0,
      ),
    )
  ],
);

String _getImage(ProviderEnum providerEnum) {
  switch(providerEnum){
    case ProviderEnum.omniva:
      return "assets/omniva_location_logo.png";
    case ProviderEnum.dpd:
      return "assets/dpd_location_logo.png";
    case ProviderEnum.Lp:
      return "assets/lietuvos_location_logo.png";
  }
}

Widget buildInfoLine({
  required String content,
  required IconData iconData
}) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 3.0),
  child: Row(
    children: [
      Icon(
        iconData,
        color: Colors.grey.shade600,
      ),
      Text(
        content,
        style: TextStyle(
            fontSize: 14.0,
            fontFamily: "MaisonBook",
            color: Colors.grey.shade600
        ),
      )
    ],
  ),
);

Widget vintedCircularBar() => SizedBox(
  height: 20.0,
  width: 20.0,
  child: CircularProgressIndicator(
    color: getBlueColor(),
    strokeWidth: 2.0,
  ),
);