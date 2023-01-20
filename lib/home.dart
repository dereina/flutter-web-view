import 'package:flutter/material.dart';
import 'web_view_container.dart';
import 'about.dart';
import 'package:flutter/gestures.dart';
import 'package:page_transition/page_transition.dart';

class AllowMultipleGestureRecognizer extends DragGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }

  @override
  // TODO: implement debugDescription
  String get debugDescription => throw UnimplementedError();

  @override
  bool isFlingGesture(VelocityEstimate estimate, PointerDeviceKind kind) {
    // TODO: implement isFlingGesture
    throw UnimplementedError();
  }
}

void onStart(BuildContext context, DragStartDetails details) {
  print(details);
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const About(title: 'About')));
}

class Home extends StatelessWidget {
  Home({Key? key, required this.url}) : super(key: key);
  final String url;
  final _links = ['https://www.google.com', 'https://gobuddie.es'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: WebViewContainer(url)),
     /* drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 117, 217, 166),
                image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: AssetImage('assets/images/gobuddie_favicon1.png')),
              ),
              child: Text(
                'Go Buddie',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.normal),
              ),
            ),
            ListTile(
              title: const Text('About'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration: Duration(milliseconds: 250),
                        //child: MaterialPageRoute(builder: (context) => const About(title: 'About')),
                        child: const About(title: 'About'),
                        inheritTheme: true,
                        ctx: context));
              },
            ),
            /*ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),*/
          ],
        ),
      ),*/
    );
    return RawGestureDetector(
        gestures: {
          AllowMultipleGestureRecognizer: GestureRecognizerFactoryWithHandlers<
              AllowMultipleGestureRecognizer>(
            () => AllowMultipleGestureRecognizer(),
            (AllowMultipleGestureRecognizer instance) {
              instance.onStart =
                  (DragStartDetails details) => onStart(context, details);
            },
          )
        },
        behavior: HitTestBehavior.opaque,
        child: Scaffold(body: SafeArea(child: WebViewContainer(url))));
    /*  child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: _links.map((link) => _urlButton(context, link)).toList(),
                ))));*/
  }

  Widget _urlButton(BuildContext context, String url) {
    return Container(
        padding: EdgeInsets.all(20.0),
        child: TextButton(
          //color: Theme.of(context).primaryColor,
          //padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
          child: Text(url),
          onPressed: () => _handleURLButtonPress(context, url),
        ));
  }

  void _handleURLButtonPress(BuildContext context, String url) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewContainer(url)));
  }
}
