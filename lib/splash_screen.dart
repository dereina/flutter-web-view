import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen>{
  int splashtime = 3;
  // duration of splash screen on second

  @override
  void initState() {
    Future.delayed(Duration(seconds: splashtime), () async {
      Navigator.pushReplacement(context, MaterialPageRoute(
        //pushReplacement = replacing the route so that
        //splash screen won't show on back button press
        //navigation to Home page.
          builder: (context){
            return Home(url : 'https://www.gobuddie.es');
          }));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
            alignment: Alignment.center,
            child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //vertically align center
                children:<Widget>[
                  Container(
                    child:SizedBox(
                        height:200,width:200,
                        child:Image.asset("assets/images/gobuddie_favicon1.png")
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:30),
                    //margin top 30
                    child:Text("GoBuddie", style: TextStyle(
                      fontSize: 30,
                    ),),
                  ),
                  Container(
                    margin:EdgeInsets.only(top:15),
                    child:Text("Version: 0.1.0", style:TextStyle(
                      color:Colors.black45,
                      fontSize: 20,
                    )),
                  ),
                ]
            )
        )
    );
  }
}