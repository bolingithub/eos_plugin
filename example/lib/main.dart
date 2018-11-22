import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:eos_plugin/eos_plugin.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      var eosWallet = await EosPlugin.createEosWallet();
      print("获取到的eos钱包账号是：$eosWallet");
      var pk = await EosPlugin.mnemonicToPrivateKey(eosWallet.mnemonic);
      //var pu = await EosPlugin.mnemonicToPublicKey(eosWallet.mnemonic);
      var pu2 = await EosPlugin.privateKeyToPublicKey(pk);
      platformVersion = eosWallet.toString();
      print("获取到的eos钱包账号是pk：$pk");
      //print("获取到的eos钱包账号是pu：$pu");
      print("获取到的eos钱包账号是pu2：$pu2");
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new Center(
          child: new Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
