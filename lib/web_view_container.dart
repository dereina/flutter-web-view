import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

class WebViewContainer extends StatefulWidget {
  final url;
  WebViewContainer(this.url);
  @override
  createState() => _WebViewContainerState(this.url);
}

class _WebViewContainerState extends State<WebViewContainer> {
  var _url;
  bool isLoading = true;
  bool isConnected = true;
  final _key = UniqueKey();
  _WebViewContainerState(this._url);

  late WebViewController webViewController;
  Future<bool> _onBack() async {
    bool goBack = false;
    var value =
        await webViewController.canGoBack(); // check webview can go back
    if (value) {
      webViewController.goBack(); // perform webview back operation
      return false;
    } else {
      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title:
              new Text('Confirmation ', style: TextStyle(color: Colors.purple)),
          // Are you sure?
          content: new Text('Do you want exit app ? '),
          // Do you want to go back?
          actions: <Widget>[
            new TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
                setState(() {
                  goBack = false;
                });
              },
              child: new Text("No"), // No
            ),
            new TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  goBack = true;
                });
              },
              child: new Text("Yes"), // Yes
            ),
          ],

        ),
      );
      if (Navigator.canPop(context)) {
        if (goBack) Navigator.pop(context); // If user press Yes pop the page
        return goBack;
      }
      return goBack;
    }
  }

  Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup("www.google.com");

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected ' + _url);
        return true;
      } else {
        print('not connected ' + _url);
        return false;
      }
    } on SocketException catch (_) {
      print(_);
      print('socket error not connected ' + _url);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBack,
        child: Scaffold(
            //appBar: AppBar(),
            /*body: Column(
          children: [
            Expanded(
                child: WebView(
                    key: _key,
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: _url))
          ],
        ),*/
            body: !isConnected
                ? Center(
                    child: TextButton(
                      child: const Text("RELOAD"),
                      onPressed: () async {
                        print("reload");
                        bool value = await checkInternetConnection();
                        setState(() {
                          isConnected = value;
                        });
                      },
                    ),
                  )
                : Stack(
                    children: <Widget>[
                      WebView(
                        onWebViewCreated: (WebViewController controler) {
                          webViewController = controler;
                        },
                        key: _key,
                        initialUrl: _url,
                        javascriptMode: JavascriptMode.unrestricted,
                        onProgress: (progress) {
                          setState(() {
                            isLoading = true;
                          });
                        },
                        onPageFinished: (finish) {
                          setState(() {
                            isLoading = false;
                          });
                        },
                        onWebResourceError: (error) async {
                          print("webresource error");
                          bool value = await checkInternetConnection();
                          setState(() {
                            isConnected = value;
                          });
                        },
                      ),
                      isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Stack(),
                    ],
                  )));
  }
}
