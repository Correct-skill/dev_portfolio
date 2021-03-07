// @dart=2.9
import 'dart:ui';
import 'dart:js' as js;

//import 'package:mailto/mailto.dart';
import 'package:dev_portfolio/styleguide/github_icon_icons.dart';
import 'package:flutter/material.dart';
import 'package:dev_portfolio/fadeanimation.dart';

//import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Shubhaankar's Dev Portfolio",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white.withOpacity(0.9),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Artboard _artboard;

  @override
  void initState() {
    _loadRiveFile();
    super.initState();
  }

  void _loadRiveFile() async {
    final bytes = await rootBundle.load('assets/tv_color.riv');
    final file = RiveFile();
    if (file.import(bytes)) {
      // Select an animation by its name
      setState(() => _artboard = file.mainArtboard
        ..addController(
          SimpleAnimation('loop'),
        ));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/background.jpg'),
          fit: BoxFit.cover,
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(color: Colors.black38.withOpacity(1)),
              ),
              Center(
                child: FadeAnimation(
                  0.9, //animation delay
                  -40.0, //animation initial position on the y axis
                  Column(
                    //animation child
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: screenHeight / 16,
                              width: 10,
                              //child: Container(height: 10),
                            ),
                            Text("Hi, I'm Shubhaankar",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 60.0,
                                    fontFamily: 'BebasNeue')),
                            Text('A Freelance Web/App developer',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'BebasNeue',
                                    fontSize: 30.0)),
                            //SizedBox(
                            //height: screenHeight / 2,
                            //),
                            Expanded(
                              child: _artboard == null
                                  ? SizedBox(
                                      height: screenHeight / 2,
                                    )
                                  : Rive(
                                      artboard: _artboard,
                                      //useArtboardSize: true,
                                      fit: BoxFit.fitHeight,
                                    ),
                            ),
                            GestureDetector(
                              onTap: () => print('tapped'),
                              child: Container(
                                //padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                width: screenWidth,
                                child: Column(
                                  children: [
                                    Text(
                                        'Tap the arrow to Learn More About What I do',
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.8),
                                            fontFamily: 'BebasNeue',
                                            fontSize: 30.0)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: screenWidth / 2 - 30.0,
                                          height: screenHeight / 7,
                                        ),
                                        Container(
                                            padding: EdgeInsets.all(10),
                                            child: Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              size: 30,
                                              color:
                                                  Colors.white.withOpacity(0.8),
                                            )),
                                        SizedBox(
                                            width: screenWidth / 2 - 30.0,
                                            height: screenHeight / 7),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          appBar: AppBar(
            backgroundColor: Colors.black38.withOpacity(1), //0.4
            centerTitle: true,
            toolbarHeight: screenHeight / 13,
            elevation: 0,
            shadowColor: Colors.transparent,
            actions: [
              GestureDetector(
                onTap: () {
                  js.context.callMethod(
                      'open', ['https://github.com/Shubhaankar-sharma']);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Icon(
                    GithubIcon.mark_github,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  js.context
                      .callMethod('open', ['mailto:shubhaankar@hotmail.com']);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Icon(
                    Icons.email,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
