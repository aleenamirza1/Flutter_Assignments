import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:googleads/ad_helper.dart';

class BannerHome extends StatefulWidget {
  const BannerHome({super.key});

  @override
  State<BannerHome> createState() => _BannerHomeState();
}

class _BannerHomeState extends State<BannerHome> {
  BannerAd? bannerAd;

  @override
  void initState() {
    super.initState();
    BannerAd(
            size: AdSize.banner,
            adUnitId: AdHelper.bannerAdUmitId,
            listener: BannerAdListener(
              onAdLoaded: (ad) {
                setState(() {
                  bannerAd = ad as BannerAd;
                });
              },
              onAdFailedToLoad: (ad, error) {
                print("Failed to load the ad: ${error.message}");
                ad.dispose();
              },
            ),
            request: const AdRequest())
        .load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Ads"),
      ),
      body: SafeArea(
        child: Stack(children: [
          Center(
            child: Text("Bannner Ad"),
          ),
          if (bannerAd != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                  width: bannerAd!.size.width.toDouble(),
                  height: bannerAd!.size.height.toDouble(),
                  child: AdWidget(ad: bannerAd!)),
            )
        ]),
      ),
    );
  }
}
