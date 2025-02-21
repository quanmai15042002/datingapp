
import 'package:dating_app/api/notifications_api.dart';
import 'package:dating_app/constants/constants.dart';
import 'package:dating_app/helpers/app_localizations.dart';
import 'package:dating_app/models/app_model.dart';
import 'package:dating_app/models/user_model.dart';
import 'package:dating_app/widgets/store_products.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VipDialog extends StatelessWidget {
  final _notificationsApi = NotificationsApi();

  @override
  Widget build(BuildContext context) {

    final i18n = AppLocalizations.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  color: Theme.of(context).primaryColor,
                  child: Column(
                    children: <Widget>[
                      /// User image
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Image.asset('assets/images/crow_badge.png'),
                        ) 
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(i18n.translate("vip_account"),
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundColor: Theme.of(context).primaryColor,
                          backgroundImage: NetworkImage(UserModel().user.userProfilePhoto),
                        ),
                        title: Text(
                            '${i18n.translate("hello")} ${UserModel().user.userFullname.split(' ')[0]}, '
                            '${i18n.translate("become_a_vip_member_and_enjoy_the_benefits_below")}',
                            style:
                                TextStyle(fontSize: 18, color: Colors.white),
                            textAlign: TextAlign.center),
                      ),
                      SizedBox(height: 8)
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  child: IconButton(
                      icon: Icon(Icons.cancel, color: Colors.white, size: 35),
                      onPressed: () {
                        /// Close Dialog
                        Navigator.of(context).pop();
                      }),
                )
              ],
            ),

            /// VIP Plans
            // Container(
            //   color: Colors.grey.withAlpha(70),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: <Widget>[
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Text(i18n.translate("vip_subscriptions"),
            //             style: TextStyle(
            //                 fontSize: 20, fontWeight: FontWeight.bold)),
            //       ),
            //       Divider(height: 10, thickness: 1),
            //       /// VIP Subscriptions
            //       StoreProducts(
            //         priceColor: Colors.green,
            //         icon: Image.asset('assets/images/crow_badge.png',
            //             width: 50, height: 50),
            //       ),
            //       Divider(thickness: 1),
            //     ],
            //   ),
            // ),
            Divider(),

            /// VIP Benefits
            Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(i18n.translate("benefits"),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  Divider(height: 10, thickness: 1),

                  // Passport
                  ListTile(
                    leading: CircleAvatar(
                      radius: 18,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Icon(Icons.flight,
                              color: Colors.white),
                    ),
                    title: Text(i18n.translate("passport"),
                        style: TextStyle(fontSize: 18)),
                    subtitle: Text(i18n.translate("travel_to_any_country_or_city_and_match_with_people_there")),
                  ),
                  Divider(height: 10, thickness: 1),

                  // Discover more people around you
                  ListTile(
                    leading: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.purple,
                      child: Icon(Icons.location_on_outlined, 
                      color: Colors.white),
                    ),
                    title: Text(i18n.translate("discover_more_people"),
                        style: TextStyle(fontSize: 18)),
                    subtitle: Text("${i18n.translate('get')} "
                      "${AppModel().appInfo.vipAccountMaxDistance} km " 
                      "${i18n.translate('radius_away')}"),
                  ),
                  Divider(height: 10, thickness: 1),

                  // Add more pictures
                  ListTile(
                    leading: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.green,
                      child: Icon(Icons.camera_alt, 
                      color: Colors.white),
                    ),
                    title: Text(i18n.translate("add_more_pictures_on_your_profile_gallery"),
                        style: TextStyle(fontSize: 18)),
                    subtitle: Text(i18n.translate("make_your_profile_attractive_by_adding_more_photos")),
                  ),
                  Divider(height: 10, thickness: 1),

                  /// See who liked you
                  ListTile(
                    leading: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.pinkAccent,
                      child: Icon(Icons.favorite, color: Colors.white),
                    ),
                    title: Text(i18n.translate("see_people_who_liked_you"),
                        style: TextStyle(fontSize: 18)),
                    subtitle: Text(i18n.translate(
                        "unravel_the_mystery_and_find_out_who_liked_you")),
                  ),
                  Divider(height: 10, thickness: 1),

                  /// See who visited you
                  ListTile(
                    leading: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.remove_red_eye, color: Colors.white),
                    ),
                    title: Text(
                        i18n.translate("see_people_who_visited_your_profile"),
                        style: TextStyle(fontSize: 18)),
                    subtitle: Text(i18n.translate(
                        "unravel_the_mystery_and_find_out_who_visited_your_profile")),
                  ),
                  Divider(height: 10, thickness: 1),

                  /// See disliked profiles
                  ListTile(
                    leading: CircleAvatar(
                      radius: 18,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Icon(Icons.close, color: Colors.white),
                    ),
                    title: Text(
                        i18n.translate("see_people_you_have_rejected"),
                        style: TextStyle(fontSize: 18)),
                    subtitle: Text(
                        i18n.translate("retrieve_and_review_all_profiles")),
                  ),
                  Divider(height: 10, thickness: 1),

                  /// Verified account badge
                  ListTile(
                    leading: Image.asset('assets/images/verified_badge.png',
                        width: 40, height: 40),
                    title: Text(i18n.translate("verified_account_badge"),
                        style: TextStyle(fontSize: 18)),
                    subtitle: Text(i18n.translate(
                        "let_other_users_know_that_you_are_a_real_person")),
                  ),
                  Divider(height: 10, thickness: 1),

                  /// No Ads
                  ListTile(
                    leading: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.red,
                      child: Icon(Icons.block, color: Colors.white),
                    ),
                    title: Text(i18n.translate("no_ads"),
                        style: TextStyle(fontSize: 18)),
                    subtitle:
                        Text(i18n.translate("have_a_unique_experience")),
                  ),
                  Divider(height: 10, thickness: 1),
                  SizedBox(height: 15),

                  Center(
                    child: RaisedButton(
                      onPressed: () async {
                        await _handlePurchaseUpdates(i18n).then((value){
                          Navigator.pop(context);
                        });

                      },
                      child: Text("BUY NOW"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  Future _handlePurchaseUpdates( AppLocalizations appLocalizations) async {
    // listen purchase updates
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('isBuy',true);
    UserModel().setUserVip();
    // Set Vip Subscription Id
    UserModel().setActiveVipId("ka");

    /// Update user verified status
    await UserModel().updateUserData(
        userId: UserModel().user.userId,
        data: {USER_IS_VERIFIED: true});

    // User first name
    final String userFirstname =
    UserModel().user.userFullname.split(' ')[0];

    /// Save notification in database for user
    _notificationsApi.onPurchaseNotification(
      nMessage: '${appLocalizations.translate("hello")} $userFirstname, '
          '${appLocalizations.translate("your_vip_account_is_active")}\n '
          '${appLocalizations.translate("thanks_for_buying")}',
    );

    // _inAppPurchaseStream = InAppPurchaseConnection
    //     .instance.purchaseUpdatedStream
    //     .listen((purchases) async {
    //   // Loop incoming purchases
    //   for (var purchase in purchases) {
    //     // Control purchase status
    //     switch (purchase.status) {
    //       case PurchaseStatus.pending:
    //         // Handle this case.
    //         break;
    //       case PurchaseStatus.purchased:
    //
    //         /// **** Deliver product to user **** ///
    //         ///
    //         /// Update User VIP Status to true
    //         UserModel().setUserVip();
    //         // Set Vip Subscription Id
    //         UserModel().setActiveVipId(purchase.productID);
    //
    //         /// Update user verified status
    //         await UserModel().updateUserData(
    //             userId: UserModel().user.userId,
    //             data: {USER_IS_VERIFIED: true});
    //
    //         // User first name
    //         final String userFirstname =
    //             UserModel().user.userFullname.split(' ')[0];
    //
    //         /// Save notification in database for user
    //         _notificationsApi.onPurchaseNotification(
    //           nMessage: '${_i18n.translate("hello")} $userFirstname, '
    //               '${_i18n.translate("your_vip_account_is_active")}\n '
    //               '${_i18n.translate("thanks_for_buying")}',
    //         );
    //
    //         if (purchase.pendingCompletePurchase) {
    //           /// Complete pending purchase
    //           InAppPurchaseConnection.instance.completePurchase(purchase);
    //           print('Success pending purchase completed!');
    //         }
    //         break;
    //       case PurchaseStatus.error:
    //         // Handle this case.
    //         print('purchase error-> ${purchase.error?.message}');
    //         break;
    //     }
    //   }
    // });
  }

}
