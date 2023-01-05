
import 'package:flutter/material.dart';
import 'package:vintedclone/data/model/preference_model.dart';
import 'package:vintedclone/screens/constants.dart';

import '../router/route_names.dart';

class PreferenceScreen extends StatelessWidget {

  final List<PreferenceModel> _preferenceList = [
    PreferenceModel(
      title: "About Your Privacy",
      content: "About Your Privacy We process your data to deliver content or advertisements and measure the delivery of such content or advertisements to extract insights about our website. We share this information with our partners on the basis of consent. You may exercise your right to consent, based on a specific purpose below or at a partner level in the link under each purpose. These choices will be signaled to our vendors participating in the Transparency and Consent Framework.",
      choosable:  false,
      showBottom: false,
      header: true
    ),
    PreferenceModel(
      title: "Strictly Necessary Cookies",
      content: "These cookies are necessary for the website to function and cannot be switched off in our systems. They are usually only set in response to actions made by you which amount to a request for services, such as setting your privacy preferences, logging in or filling in forms. You can set your browser to block or alert you about these cookies, but some parts of the site will not then work. These cookies do not store any personally identifiable information.",
      choosable: false,
      showBottom: false
    ),
    PreferenceModel(
      title: "Performance Cookies",
      content: "These cookies allow us to count visits and traffic sources so we can measure and improve the performance of our site. They help us to know which pages are the most and least popular and see how visitors move around the site. All information these cookies collect is aggregated and therefore anonymous. If you do not allow these cookies we will not know when you have visited our site, and will not be able to monitor its performance.",
      choosable: true,
      showBottom: false
    ),
    PreferenceModel(
      title: "Functional Cookies",
      content: "These cookies enable the website to provide enhanced functionality and personalisation. They may be set by us or by third party providers whose services we have added to our pages. If you do not allow these cookies then some or all of these services may not function properly.",
      choosable: true,
      showBottom: false,
    ),
    PreferenceModel(
      title: "Targeting Cookies",
      content: "These cookies may be set through our site by our advertising partners. They may be used by those companies to build a profile of your interests and show you relevant adverts on other sites. They do not store directly personal information, but are based on uniquely identifying your browser and internet device. If you do not allow these cookies, you will experience less targeted advertising.",
      choosable: true,
      showBottom: false
    ),
    PreferenceModel(
      title: "Social Media Cookies",
      content: "These cookies are set by a range of social media services that we have added to the site to enable you to share our content with your friends and networks. They are capable of tracking your browser across other sites and building up a profile of your interests. This may impact the content and messages you see on other websites you visit. If you do not allow these cookies you may not be able to use or see these sharing tools.",
      choosable: true,
      showBottom: false
    ),
    PreferenceModel(
      title: "Store and/or access information on a device",
      content: "Cookies, device identifiers, or other information can be stored or accessed on your device for the purposes presented to you.",
      choosable: true,
      showBottom: true
    ),
    PreferenceModel(
      title: "Personalised ads and content, ad and content measurement, audience insights and product development",
      content: "Ads and content can be personalised based on a profile. More data can be added to better personalise ads and content. Ad and content performance can be measured. Insights about audiences who saw the ads and content can be derived. Data can be used to build or improve user experience, systems and software.",
      choosable: true,
      showBottom: false
    ),
    PreferenceModel(
      title: "Select basic ads",
      content: "Ads can be shown to you based on the content you're viewing, the app you're using, your approximate location, or your device type.",
      choosable: false,
      showBottom: false,
      titleStyle: TitleStyle.title2
    ),
    PreferenceModel(
      title: "Create a personalised ads profile",
      content: "A profile can be built about you and your interests to show you personalised ads that are relevant to you.",
      choosable: true,
      showBottom: false,
      titleStyle: TitleStyle.title2
    ),
    PreferenceModel(
      title: "Select personalised ads",
      content: "Personalised ads can be shown to you based on a profile about you.",
      choosable: true,
      showBottom: false,
      titleStyle: TitleStyle.title2
    ),
    PreferenceModel(
      title: "Create a personalised content profile",
      content: "A profile can be built about you and your interests to show you personalised content that is relevant to you.",
      choosable: true,
      showBottom: false,
      titleStyle: TitleStyle.title2
    ),
    PreferenceModel(
      title: "Select personalised content",
      content: "Personalised content can be shown to you based on a profile about you.",
      choosable: true,
      showBottom: false,
      titleStyle: TitleStyle.title2
    ),
    PreferenceModel(
      title: "Measure ad performance",
      content: "The performance and effectiveness of ads that you see or interact with can be measured.",
      choosable: true,
      showBottom: false,
      titleStyle: TitleStyle.title2
    ),
    PreferenceModel(
      title: "Measure content performance",
      content: "The performance and effectiveness of content that you see or interact with can be measured.",
      choosable: true,
      showBottom: false,
      titleStyle: TitleStyle.title2
    ),
    PreferenceModel(
      title: "Apply market research to generate audience in other platform",
      content: "Market research can be used to learn more about the audiences who visit sites/apps and view ads.",
      choosable: false,
      showBottom: false,
      titleStyle: TitleStyle.title2
    ),
    PreferenceModel(
      title: "Develop and improve products",
      content: "Your data can be used to improve existing systems and software, and to develop new products",
      choosable: true,
      showBottom: true,
      titleStyle: TitleStyle.title2
    ),
    PreferenceModel(
      title: "Use precise geolocation data",
      content: "Your precise geolocation data can be used in support of one or more purposes. This means your location can be accurate to within several meters.",
      choosable: true,
      showBottom: true
    ),
    PreferenceModel(
      title: "Actively scan device characteristics for identification",
      content: "Your device can be identified based on a scan of your device's unique combination of characteristics.",
      choosable: true,
      showBottom: true
    ),
    PreferenceModel(
      title: "Ensure security, prevent fraud, and debug",
      content: "Your data can be used to monitor for and prevent fraudulent activity, and ensure systems and processes work properly and securely.",
      choosable: false,
      showBottom: true
    ),
    PreferenceModel(
      title: "Technically deliver ads or content",
      content: "Your device can receive and send information that allows you to see and interact with ads and content.",
      choosable: false,
      showBottom: true
    ),
    PreferenceModel(
      title: "Match and combine offline data sources",
      content: "Data from offline data sources can be combined with your online activity in support of one or more purposes.",
      choosable: false,
      showBottom: true
    ),
    PreferenceModel(
      title: "Link different devices",
      content: "Different devices can be determined as belonging to you or your household in support of one or more of purposes.",
      choosable: false,
      showBottom: true
    ),
    PreferenceModel(
      title: "Receive and use automatically-sent device characteristics for identification",
      content: "Your device might be distinguished from other devices based on information it automatically sends, such as IP address or browser type.",
      choosable: false,
      showBottom: true
    ),
    PreferenceModel(
      title: "Non-IAB vendors",
      content: "Non-IAB vendors are vendors who haven't registered with IAB Europe and are not participating in the TCF and not following TCF policies.",
      choosable: true,
      showBottom: false
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Column(
          children: [
            buildButton(
              content: "Accept all",
              buttonColor: getBlueColor(),
              contentColor: Colors.white,
              onPressed: (){
                Navigator.pop(context);
              },
              splashColor: Colors.white24
            ),
            buildButton(
              content: "Confirm my choices",
              buttonColor: Colors.transparent,
              contentColor: getBlueColor(),
              onPressed: (){
                Navigator.pop(context);
              },
              splashColor: Colors.white24,
              side: true,
              sideColor: getBlueColor()
            )
          ],
        )
      ],
      appBar: getAppBar(context: context, title: "My preference"),
      body: ListView.builder(
        itemCount: _preferenceList.length + 1 ,
        itemBuilder: (context, index){
          return (index < _preferenceList.length)
          ? Column(
            children: [
              buildPreferenceTile(
                _preferenceList[index].title,
                _preferenceList[index].content,
                _preferenceList[index].choosable,
                _preferenceList[index].header,
                _preferenceList[index].showBottom,
                _preferenceList[index].titleStyle,
                context,
                false
              ),
              if(_preferenceList[index].titleStyle != TitleStyle.title2)
                 Divider(height: 0.5, color: Colors.grey.shade400,)
            ],
          )
          : _footerText();
        },
      ),
    );
  }

  Widget _footerText() => Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: RichText(
      text: const TextSpan(
        text: "Powered by ",
        style: TextStyle(
          fontSize: 15.0,
          color: Colors.black87
        ),
        children: [
          TextSpan(
            text: "OneTrust",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.green
            )
          )
        ]
        ),
      ),
    ),
  );

}
