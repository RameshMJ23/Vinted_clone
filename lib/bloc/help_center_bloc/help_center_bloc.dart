

import 'package:bloc/bloc.dart';
import 'package:vintedclone/data/model/help_center_model/help_center_item.dart';

class HelpCenterBloc extends Cubit<List<HelpCenterItem>?>{

  static List<HelpCenterItem> gettingStarted = [
    HelpCenterItem(
      topicName: "Selling step-by-step",
      url: "https://www.vinted.com/help/26-selling-step-by-step?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "What you can sell on Vinted",
      url: "https://www.vinted.com/help/52-what-you-can-sell-on-vinted?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "How shipping works",
      url: "https://www.vinted.com/help/753-how-shipping-works?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "What is Item Bump?",
      url: "https://www.vinted.com/help/340-what-is-item-bump?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "Vinted Wallet: how it works",
      url: "https://www.vinted.com/help/437-vinted-wallet-how-it-works?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "Paying through Vinted",
      url: "https://www.vinted.com/help/483-paying-through-vinted?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "Buying step by step",
      url: "https://www.vinted.com/help/25-buying-step-by-step?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "Buyer Protection",
      url: "https://www.vinted.com/help/550-buyer-protection?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "Personalize your Vinted",
      url: "https://www.vinted.com/help/409-personalize-your-vinted?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "Invite your friends to Vinted",
      url: "https://www.vinted.com/help/318-invite-your-friends-to-vinted?access_channel=hc_topics"
    )
  ];


  static List<HelpCenterItem> selling = [
    HelpCenterItem(
      topicName: "Selling your items faster",
      url: "https://www.vinted.com/help/57-selling-your-items-faster?access_channel=hc_topics",
      recommended: true
    ),
    HelpCenterItem(
      topicName: "Canceling an order",
      url: "https://www.vinted.com/help/58-canceling-an-order?access_channel=hc_topics",
      recommended: true
    ),
    HelpCenterItem(
      topicName: "Paying out your earnings",
      url: "https://www.vinted.com/help/68-paying-out-your-earnings?access_channel=hc_topics",
      recommended: true
    ),
    HelpCenterItem(
      topicName: "What is Item Bump?",
      url: "https://www.vinted.com/help/340-what-is-item-bump?access_channel=hc_topics",
      recommended: true
    ),
    HelpCenterItem(
      topicName: "Pending balance",
      url: "https://www.vinted.com/help/460-pending-balance?access_channel=hc_topics",
      recommended: true
    ),
    HelpCenterItem(
      topicName: "How selling works",
      url: "https://www.vinted.com/help/413-how-selling-works?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "Listing an item",
      url: "https://www.vinted.com/help/8-listing-an-item?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "Selling faster",
      url: "https://www.vinted.com/help/10-selling-faster?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "Shipping",
      url: "https://www.vinted.com/help/12-shipping?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "Getting paid",
      url: "https://www.vinted.com/help/146-getting-paid?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "Feedback & Communication",
      url: "https://www.vinted.com/help/411-feedback-communication?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "Returns & Cancellations",
      url: "https://www.vinted.com/help/414-returns-cancellations?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "My items",
      url: "https://www.vinted.com/help/9-my-items?access_channel=hc_topics"
    )
  ];


  static List<HelpCenterItem> buying = [
    HelpCenterItem(
      topicName: "Canceling an order",
      url: "https://www.vinted.com/help/58-canceling-an-order?access_channel=hc_topics",
      recommended: true
    ),
    HelpCenterItem(
      topicName: "Payment methods",
      url: "https://www.vinted.com/help/94-payment-methods?access_channel=hc_topics",
      recommended: true
    ),
    HelpCenterItem(
      topicName: "Using a coupon",
      url: "https://www.vinted.com/help/95-using-a-coupon?access_channel=hc_topics",
      recommended: true
    ),
    HelpCenterItem(
      topicName: "Buying process",
      url: "https://www.vinted.com/help/423-buying-process?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "Finding items to buy",
      url: "https://www.vinted.com/help/424-finding-items-to-buy?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "Before you buy",
      url: "https://www.vinted.com/help/143-before-you-buy?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "Making a payment",
      url: "https://www.vinted.com/help/37-making-a-payment?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "Shipping and Delivery",
      url: "https://www.vinted.com/help/39-shipping-and-delivery?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "Feedback & Communication",
      url: "https://www.vinted.com/help/411-feedback-communication?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "Returns & Cancellations",
      url: "https://www.vinted.com/help/414-returns-cancellations?access_channel=hc_topics"
    )
  ];

  static List<HelpCenterItem> shipping = [
    HelpCenterItem(
      topicName: "Tracking a package",
      url: "https://www.vinted.com/help/100-tracking-a-package?access_channel=hc_topics",
      recommended: true
    ),
    HelpCenterItem(
      topicName: "Shipping label not received",
      url: "https://www.vinted.com/help/154-shipping-label-not-received?access_channel=hc_topics",
      recommended: true
    ),
    HelpCenterItem(
      topicName: "How shipping works",
      url: "https://www.vinted.com/help/753-how-shipping-works?access_channel=hc_topics",
      recommended: true
    ),
    HelpCenterItem(
      topicName: "How to send an item with each shipping provider",
      url: "https://www.vinted.com/help/982-how-to-send-an-item-with-each-shipping-provider?access_channel=hc_topics",
      recommended: true
    ),
    HelpCenterItem(
      topicName: "Seller topics",
      url: "https://www.vinted.com/help/419-seller-topics?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "Buyer topics",
      url: "https://www.vinted.com/help/420-buyer-topics?access_channel=hc_topics"
    )
  ];

  static List<HelpCenterItem> paymentsAndWithdrawals = [
    HelpCenterItem(
      topicName: "Paying out your earnings",
      url: "https://www.vinted.com/help/68-paying-out-your-earnings?access_channel=hc_topics",
      recommended: true
    ),
    HelpCenterItem(
      topicName: "Adding your payout details",
      url: "https://www.vinted.com/help/70-adding-your-payout-details?access_channel=hc_topics",
      recommended: true
    ),
    HelpCenterItem(
      topicName: "Payment methods",
      url: "https://www.vinted.com/help/94-payment-methods?access_channel=hc_topics",
      recommended: true
    ),
    HelpCenterItem(
      topicName: "Using a coupon",
      url: "https://www.vinted.com/help/95-using-a-coupon?access_channel=hc_topics",
      recommended: true
    ),
    HelpCenterItem(
      topicName: "Vinted Wallet: how it works",
      url: "https://www.vinted.com/help/437-vinted-wallet-how-it-works?access_channel=hc_topics",
      recommended: true
    ),
    HelpCenterItem(
      topicName: "Payment methods",
      url: "https://www.vinted.com/help/430-payment-methods?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "Vinted Wallet",
      url: "https://www.vinted.com/help/431-vinted-wallet?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "Payouts",
      url: "https://www.vinted.com/help/432-payouts?access_channel=hc_topics"
    )
  ];

  static List<HelpCenterItem> trustAndSafety = [
    HelpCenterItem(
      topicName: "What you can sell on Vinted",
      url: "https://www.vinted.com/help/58-canceling-an-order?access_channel=hc_topics",
      recommended: true
    ),
    HelpCenterItem(
      topicName: "Why your listing was hidden or deleted",
      url: "https://www.vinted.com/help/94-payment-methods?access_channel=hc_topics",
      recommended: true
    ),
    HelpCenterItem(
        topicName: "Phone number verification not working",
        url: "https://www.vinted.com/help/95-using-a-coupon?access_channel=hc_topics",
        recommended: true
    ),
    HelpCenterItem(
        topicName: "COVID-19",
        url: "https://www.vinted.com/help/423-buying-process?access_channel=hc_topics"
    ),
    HelpCenterItem(
        topicName: "Buyer protection",
        url: "https://www.vinted.com/help/424-finding-items-to-buy?access_channel=hc_topics"
    ),
    HelpCenterItem(
        topicName: "Seller protection",
        url: "https://www.vinted.com/help/143-before-you-buy?access_channel=hc_topics"
    ),
    HelpCenterItem(
        topicName: "Private data usage & protection",
        url: "https://www.vinted.com/help/37-making-a-payment?access_channel=hc_topics"
    ),
    HelpCenterItem(
        topicName: "Identity verifications",
        url: "https://www.vinted.com/help/39-shipping-and-delivery?access_channel=hc_topics"
    ),
    HelpCenterItem(
        topicName: "Catalog rules",
        url: "https://www.vinted.com/help/411-feedback-communication?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "Community and forum rules",
      url: "https://www.vinted.com/help/414-returns-cancellations?access_channel=hc_topics"
    )
  ];

  static List<HelpCenterItem> myAccAndSettings = [
    HelpCenterItem(
        topicName: "Activate your Vinted Wallet",
        url: "https://www.vinted.com/help/68-paying-out-your-earnings?access_channel=hc_topics",
        recommended: true
    ),
    HelpCenterItem(
        topicName: "Invite your friends to Vinted",
        url: "https://www.vinted.com/help/70-adding-your-payout-details?access_channel=hc_topics",
        recommended: true
    ),
    HelpCenterItem(
        topicName: "Managing your profile details",
        url: "https://www.vinted.com/help/94-payment-methods?access_channel=hc_topics",
        recommended: true
    ),
    HelpCenterItem(
        topicName: "Vinted Wallet: how it works",
        url: "https://www.vinted.com/help/95-using-a-coupon?access_channel=hc_topics",
        recommended: true
    ),
    HelpCenterItem(
        topicName: "Managing shipping options for selling",
        url: "https://www.vinted.com/help/437-vinted-wallet-how-it-works?access_channel=hc_topics",
        recommended: true
    ),
    HelpCenterItem(
      topicName: "New Vinted",
      url: "https://www.vinted.com/help/430-payment-methods?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "My closet settings",
      url: "https://www.vinted.com/help/431-vinted-wallet?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "Shipping & Payments settings",
      url: "https://www.vinted.com/help/432-payouts?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "Vinted Wallet",
      url: "https://www.vinted.com/help/432-payouts?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "Personalization",
      url: "https://www.vinted.com/help/432-payouts?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "Referrals",
      url: "https://www.vinted.com/help/432-payouts?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "Notifications & emails",
      url: "https://www.vinted.com/help/432-payouts?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "Why was my account blocked?",
      url: "https://www.vinted.com/help/432-payouts?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "Vinted is not loading on my device",
      url: "https://www.vinted.com/help/432-payouts?access_channel=hc_topics"
    )
  ];

  static List<HelpCenterItem> community = [
    HelpCenterItem(
      topicName: "Notifications & emails",
      url: "https://www.vinted.com/help/432-payouts?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "Why was my account blocked?",
      url: "https://www.vinted.com/help/432-payouts?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "Vinted is not loading on my device",
      url: "https://www.vinted.com/help/432-payouts?access_channel=hc_topics"
    )
  ];

  static List<HelpCenterItem> notLoggedIn = [
    HelpCenterItem(
      topicName: "I registered using a wrong email address",
      url: "https://www.vinted.com/help/587-i-registered-using-a-wrong-email-address?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "I don’t have an account, but I receive Vinted emails",
      url: "https://www.vinted.com/help/588-i-don-t-have-an-account-but-i-receive-vinted-emails?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "Signing up on Vinted",
      url: "https://www.vinted.com/help/105-signing-up-on-vinted?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "Why can't I log in to my account?",
      url: "https://www.vinted.com/help/104-why-can-t-i-log-in-to-my-account?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "Why was my account blocked?",
      url: "https://www.vinted.com/help/92-why-was-my-account-blocked?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "Why is my IP address blocked?",
      url: "https://www.vinted.com/help/93-why-is-my-ip-address-blocked?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "How do I change my password?",
      url: "https://www.vinted.com/help/106-how-do-i-change-my-password?access_channel=hc_topics"
    ),
    HelpCenterItem(
      topicName: "Trying to register on Vinted, but my email is taken",
      url: "https://www.vinted.com/help/315-trying-to-register-on-vinted-but-my-email-is-taken?access_channel=hc_topics"
    )
  ];

  List<HelpCenterItem> fullList = [
    ...notLoggedIn,
    ...myAccAndSettings,
    ...trustAndSafety,
    ...paymentsAndWithdrawals,
    ...shipping,
    ...buying,
    ...selling,
    ...gettingStarted
  ];

  HelpCenterBloc():super(null);

  filterSearch(String searchText){

    List<HelpCenterItem> filteredList = fullList.where(
      (element) => element.topicName.toLowerCase().contains(
        searchText.toLowerCase()
      )
    ).toList();

    emit(filteredList);
  }

  resetSearch(){
    emit(null);
  }

}