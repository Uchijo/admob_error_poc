import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: NativeAdWidget(),
    );
  }
}

class NativeAdWidget extends StatefulWidget {
  const NativeAdWidget({Key? key}) : super(key: key);

  @override
  State<NativeAdWidget> createState() => _NativeAdWidgetState();
}

class _NativeAdWidgetState extends State<NativeAdWidget> {
  NativeAd? _ad;

  @override
  void initState() {
    super.initState();

    NativeAd(
      adUnitId:
          'ca-app-pub-3940256099942544/2247696110', // test native unit id for android
      factoryId: 'test',
      listener: NativeAdListener(
        onAdLoaded: (ad) async {
          await Future<void>.delayed(const Duration(seconds: 1));
          setState(() {
            _ad = ad as NativeAd;
          });
          await Future<void>.delayed(const Duration(seconds: 1));
        },
      ),
      request: const AdRequest(),
    ).load();
  }

  @override
  Widget build(BuildContext context) {
    if (_ad != null) {
      return AdWidget(ad: _ad!);
    }
    return const Text('loading');
  }
}
