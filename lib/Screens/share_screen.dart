import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareScreen extends StatelessWidget {
  final String appLink = "https://play.google.com/store/apps/details?id=com.yourapp";

  void _shareApp(BuildContext context) {
    Share.share("Check out this amazing app: $appLink");
  }

  void _shareOnWhatsApp() async {
    final url = "whatsapp://send?text=Check out this amazing app: $appLink";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      print("WhatsApp is not installed!");
      Share.share("Check out this amazing app: $appLink");
    }
  }

  void _shareOnFacebook() async {
    final url = "https://www.facebook.com/sharer/sharer.php?u=$appLink";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      print("Opening in browser...");
      Share.share("Check out this amazing app: $appLink");
    }
  }

  void _shareOnInstagram() async {
    final url = "https://www.instagram.com/?url=$appLink";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      print("Opening in browser...");
      Share.share("Check out this amazing app: $appLink");
    }
  }

  void _shareOnTwitter() async {
    final url = "https://twitter.com/intent/tweet?text=Check out this amazing app: $appLink";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      print("Opening in browser...");
      Share.share("Check out this amazing app: $appLink");
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height + 600,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/images/bg_image.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 30,
            left: 30,
            child: SizedBox(
              height: 100,
              width: 300,
              child: Text(
                'S',
                style: TextStyle(
                  color: Color(0xff243642),
                  fontWeight: FontWeight.w700,
                  fontSize: 80,
                  fontFamily: 'CicleFina',
                ),
              ),
            ),
          ),
          Positioned(
            top: 71,
            left: 61,
            child: SizedBox(
              height: 50,
              width: 300,
              child: Text(
                ' hare This App',
                style: TextStyle(
                  color: Color(0xff243642),
                  fontWeight: FontWeight.w700,
                  fontSize: 40,
                  fontFamily: 'AlegreyaSans',
                ),
              ),
            ),
          ),
          Positioned(
            top: 110,
            left: 30,
            child: SizedBox(
              height: 100,
              width: 500,
              child: Text(
                'With Your Friends!',
                style: TextStyle(
                  color: Color(0xff243642),
                  fontWeight: FontWeight.w700,
                  fontSize: 40,
                  fontFamily: 'AlegreyaSans',
                ),
              ),
            ),
          ),
          isLandscape
              ? Positioned(
            top: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildShareButtons(context),
            ),
          )
              : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildShareButtons(context),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildShareButtons(BuildContext context) {
    return [
      _buildShareButton("WhatsApp", "assets/images/icons/social.png", _shareOnWhatsApp),
      _buildShareButton("Facebook", "assets/images/icons/facebook.png", _shareOnFacebook),
      _buildShareButton("Instagram", "assets/images/icons/instagram.png", _shareOnInstagram),
      _buildShareButton("Twitter", "assets/images/icons/twitter.png", _shareOnTwitter),
      _buildShareButton("More", "assets/images/icons/share.png", () => _shareApp(context)),
    ];
  }

  Widget _buildShareButton(String title, String iconPath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20, right: 40, top: 10, bottom: 10),
                height: 50,
                width: 50,
                child: Image.asset(iconPath, width: 50, height: 50),
              ),
              Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Color(0xff243642), fontFamily: 'AlegreyaSans')),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 100.0, right: 30),
            child: Divider(color: Color(0xff243642), height: 1),
          ),
        ],
      ),
    );
  }
}