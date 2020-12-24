import 'package:flutter/material.dart';
import 'package:matchfinder/Utilities/Common.dart';
import 'package:matchfinder/Utilities/style.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('F1F1F1'),
      appBar: AppBar(
        shadowColor: appColor,
        backgroundColor: appColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Image.asset(
          'assets/logowhite.png',
          // width: 142,
          height: 50,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                  text:
                      "Your privacy is important to us, and so is being transparent about how we"
                      " collect, use, and share information about you. This policy is intended to"
                      "help you understand.\n\n",
                  style: miniGreyTextStyle,
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          'What information does Matchfinder collect from you?\n',
                      style: miniGreyFontWeightStyle,
                    ),
                    TextSpan(
                      text:
                          "Matchfinder is an advertising platform providing targeted advertising services"
                          " for the purpose of matchmaking (Service). In order to do provide the services"
                          " , we ask for certain personal information which is displayed on the site on"
                          " behalf of you to find the perfect life partner. You hereby provide your consent"
                          " to collect, process, and share of your personal information in order to provide"
                          "the service.\n\n",
                      style: miniGreyTextStyle,
                    ),
                    TextSpan(
                      text:
                          'Matchfinder gathers following types of information:\n',
                      style: miniGreyFontWeightStyle,
                    ),
                    TextSpan(
                      text: "I. Information you submit; and\n",
                      style: miniGreyTextStyle,
                    ),
                    TextSpan(
                      text: "I. Information you submit; and\n",
                      style: miniGreyTextStyle,
                    ),
                    TextSpan(
                      text:
                          "ii. Information not directly submitted by the you\n",
                      style: miniGreyTextStyle,
                    ),
                    TextSpan(
                      text: "iii. Information we receive from others\n\n",
                      style: miniGreyTextStyle,
                    ),
                    TextSpan(
                      text: 'i. Information Submitted by you\n',
                      style: miniGreyFontWeightStyle,
                    ),
                    TextSpan(
                      text:
                          "In order to avail the service you provide the following information:-\n\n",
                      style: miniGreyTextStyle,
                    ),
                    TextSpan(
                      text:
                          "While registering for our service, you share with us your personal"
                          " details, such as name, your gender date of birth, contact details,"
                          " educational, qualification, employment details, photos, marital status"
                          " and your interests etc...\n",
                      style: miniGreyTextStyle,
                    ),
                    TextSpan(
                      text:
                          "When you avail for a paid service, you provide us or our payment"
                          " service provider with information, such as your debit or credit card"
                          " number or UPI.\n",
                      style: miniGreyTextStyle,
                    ),
                    TextSpan(
                      text:
                          "Testimonials submitted by you including your success story and photos."
                          " Information submitted by you voluntarily while participating in surveys"
                          " contest, promotions or events.\n",
                      style: miniGreyTextStyle,
                    ),
                    TextSpan(
                      text:
                          "Details shared with our customer care team (This information used to"
                          " monitor or for training purpose and to ensure a better service).\n",
                      style: miniGreyTextStyle,
                    ),
                    TextSpan(
                      text:
                          "You have the option to send interesting profiles/ articles to your friends."
                          " We will use your friend's email address only to send a one-time"
                          " message to them per request. Then they will never ever hear from us"
                          " again unless they voluntarily subscribe to our services.\n",
                      style: miniGreyTextStyle,
                    ),
                    TextSpan(
                      text:
                          "Your chats and messages with other users as well as the content you"
                          " publish will be processed as a part of the service\n\n",
                      style: miniGreyTextStyle,
                    ),
                    TextSpan(
                      text: 'ii. Information not directly submitted by you\n\n',
                      style: miniGreyFontWeightStyle,
                    ),
                    TextSpan(
                      text: 'User activity\n',
                      style: miniGreyFontWeightStyle,
                    ),
                    TextSpan(
                      text:
                          "We collect information about your activity on our services, such as"
                          " date and time you logged in, features you've been using, searches,"
                          " clicks and pages visited by you, your interaction with other users"
                          " including messages exchanged.\n\n",
                      style: miniGreyTextStyle,
                    ),
                    TextSpan(
                      text: 'Device Information\n',
                      style: miniGreyFontWeightStyle,
                    ),
                    TextSpan(
                      text:
                          "We collect information from and about the devices(s) such as IP"
                          " address device ID and type, device-specification and apps settings,"
                          " app error reports, browser type and version, operating system,"
                          " identifiers associated with cookies or other technologies that may"
                          "uniquely identify your device or browser.\n\n",
                      style: miniGreyTextStyle,
                    ),
                    TextSpan(
                      text: 'SMS Permission\n',
                      style: miniGreyFontWeightStyle,
                    ),
                    TextSpan(
                      text:
                          "We need SMS permission for authenticating transactions via OTP."
                          " sent by the Payment Gateway.\n",
                      style: miniGreyTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
