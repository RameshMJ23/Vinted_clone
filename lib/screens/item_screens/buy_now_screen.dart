import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/router/profile_route/profile_route_names.dart';
import 'package:vintedclone/screens/router/route_names.dart';


PageStorageBucket buyNowBucket = PageStorageBucket();

class BuyNowScreen extends StatefulWidget {

  String itemCost;

  String imageUrl;

  BuyNowScreen({
    required this.itemCost,
    required this.imageUrl
  });

  @override
  _BuyNowScreenState createState() => _BuyNowScreenState();
}

class _BuyNowScreenState extends State<BuyNowScreen>
                                        with AutomaticKeepAliveClientMixin{

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: "Payment"),
      persistentFooterButtons: [
        Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 3.0
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock_outlined, color: Colors.grey.shade500),
                    Text(
                      "This is a secure encrypted payment",
                      style: TextStyle(
                          fontFamily: "MaisonBook",
                          fontSize: 12.0,
                          color: Colors.grey.shade500
                      ),
                    )
                  ],
                ),
              ),
              buildButton(
                  content: "Pay",
                  buttonColor: Colors.green.shade800,
                  contentColor: Colors.white,
                  onPressed: (){

                  },
                  splashColor: Colors.black12
              )
            ],
          ),
        )
      ],
      body: PageStorage(
        bucket: buyNowBucket,
        child: ListView(
          key: const PageStorageKey("buyNowKey"),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15.0, horizontal: 20.0
              ),
              child: SizedBox(
                height: 150.0,
                width: 100.0,
                child: Image.network(
                  widget.imageUrl
                ),
              ),
            ),
            Divider(height: 0.5, color: Colors.grey.shade600,),
            Container(
              color: Colors.white,
              padding:  const EdgeInsets.symmetric(
                  vertical: 8.0
              ),
              child: Column(
                children: [
                  _buildCostWidget(cost: widget.itemCost, title: "Order"),
                  _buildCostWidget(
                      cost: "0.99", title: "Buyer protection fee", showInfoIcon: true
                  ),
                  _buildCostWidget(cost: "0.99", title: "Postage"),
                  _buildCostWidget(
                      cost: _getTotalCost(widget.itemCost),
                      title: "Total to pay",
                      color: Colors.black87, vertPad: 10.0
                  )
                ],
              ),
            ),
            Divider(height: 0.5, color: Colors.grey.shade600,),
            _addressWidget(context),
            Divider(height: 0.5, color: Colors.grey.shade600,),
            buildBaseContainer(containerName: "Delivery details", children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 18.0, vertical: 10.0
                ),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: Colors.grey.shade300)
                  ),
                  highlightElevation: 0.0,
                  splashColor: Colors.grey.shade50,
                  elevation: 0.0,
                  color: Colors.transparent,
                  onPressed: () async{

                    await Permission.locationAlways.request().then((value) async{
                      if(value == PermissionStatus.granted){
                        Navigator.pushNamed(
                            context,
                            RouteNames.choosePickupPointScreen,
                            arguments: {
                              "childCurrent": widget
                            }
                        );
                      }
                    });
                  },
                  child: _buildOptionTile(
                      optionName: "Choose a pick-up point",
                      leading: Icon(Icons.map_outlined, color: Colors.grey.shade700,)
                  ),
                ),
              )
            ], showBorder: false),
            Divider(height: 0.5, color: Colors.grey.shade600,),
            buildBaseContainer(containerName: "Payment", children: [
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 10.0
                ),
                child: _buildOptionTile(
                    optionName: "Choose a payment method",
                    onTap: (){
                      Navigator.pushNamed(
                          context,
                          RouteNames.paymentOptionsScreen,
                          arguments: {
                            "childCurrent": widget
                          }
                      );
                    }
                ),
              )
            ], showBorder: false)
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile({
    required String optionName,
    Widget? leading,
    VoidCallback? onTap
  }) => ListTile(
    minLeadingWidth: 30.0,
    leading: leading,
    horizontalTitleGap: 5.0,
    title: Text(
      optionName,
      style: const TextStyle(
          fontFamily: "MaisonMedium",
          fontSize: 16.0,
          color: Colors.black87
      ),
    ),
    trailing: const Icon(
      Icons.add,
      color: Colors.black87,
    ),
    onTap: onTap,
  );

  Widget _buildCostWidget({
    required String cost,
    required String title,
    Color? color,
    bool showInfoIcon = false,
    double vertPad = 2.0
  }) => Padding(
    padding: EdgeInsets.symmetric(vertical: vertPad, horizontal: 18.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                  fontFamily: "MaisonBook",
                  fontSize: 16.0,
                  color: color ?? Colors.grey.shade600
              ),
            ),
            if(showInfoIcon) GestureDetector(
              child: Icon(
                Icons.info_outline,
                color: Colors.grey..shade600,
              ),
              onTap: (){

              },
            )
          ],
        ),
        Text(
            "€$cost",
            style:  TextStyle(
                fontFamily: "MaisonMedium",
                fontSize: 16.0,
                color: color ?? Colors.grey.shade600
            )
        )
      ],
    ),
  );

  String _getTotalCost(String stringItemCost) {
    double itemCost = double.parse(stringItemCost);

    return (itemCost + 0.99 + 0.99).toStringAsFixed(2);
  }

  Widget _addressWidget(BuildContext context) => buildBaseContainer(
      containerName: "Address",
      children: [
        Padding(
          padding: const EdgeInsets.only(
              right: 18.0, left: 18.0, bottom: 10.0
          ),
          child: InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "rameshMa",
                      style: TextStyle(
                          fontFamily: "MaisonMeidum",
                          fontSize: 16.0,
                          color: Colors.black87
                      ),
                    ),
                    Text(
                        "Sauletekis",
                        style: TextStyle(
                            fontFamily: "MaisonMeidum",
                            fontSize: 16.0,
                            color: Colors.grey.shade700
                        )
                    ),
                    Text(
                        "10225, Vilnius",
                        style: TextStyle(
                            fontFamily: "MaisonMeidum",
                            fontSize: 16.0,
                            color: Colors.grey.shade700
                        )
                    ),
                  ],
                ),
                Icon(Icons.edit_outlined, color: Colors.grey.shade500,)
              ],
            ),
            onTap: (){
              Navigator.pushNamed(
                  context,
                  ProfileRouteNames.shipAddressScreen,
                  arguments: {
                    "childCurrent": widget
                  }
              );
            },
          ),
        )
      ], showBorder: false
  );
}

