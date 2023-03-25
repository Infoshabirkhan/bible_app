

import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../advertisement_id.dart';
const int maxFailedLoadAttempts = 3;

class AdvertisementRepo{
  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );
static  InterstitialAd? _interstitialAd;
 static int _numInterstitialLoadAttempts = 0;

 static Future<void> createInterstitialAd() async {
   await  InterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? AdvertisementID.interstitialAndroidId
            : 'ca-app-pub-3940256099942544/4411468910',
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              createInterstitialAd();
            }
          },
        ));
  }



 static void showInterstitialAd() {

    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }



  static BannerAd myBanner = BannerAd(
    adUnitId: AdvertisementID.bannerAndroidId,
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

}