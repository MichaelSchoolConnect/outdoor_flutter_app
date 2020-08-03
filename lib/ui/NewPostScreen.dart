import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outdoor_flutter_app/model/ActivityType.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../Strings.dart';

class NewPostScreen extends StatefulWidget {
  @override
  _NewPostScreen createState() => _NewPostScreen();
}

class _NewPostScreen extends State<NewPostScreen>
    with TickerProviderStateMixin {
  _NewPostScreen({Key key, @required this.activityType});

  BuildContext buildContext;
  ActivityType activityType;

  AnimationController _animationController;

  TextEditingController moreInfoController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  double _containerPaddingLeft = 20.0;
  double _animationValue;
  double _translateX = 0;
  double _translateY = 0;
  double _rotate = 0;
  double _scale = 1;

  bool show;
  bool sent = false;
  Color _color = Colors.lightBlue;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1300));
    show = true;
    _animationController.addListener(() {
      setState(() {
        show = false;
        _animationValue = _animationController.value;
        if (_animationValue >= 0.2 && _animationValue < 0.4) {
          _containerPaddingLeft = 100.0;
          _color = Colors.green;
        } else if (_animationValue >= 0.4 && _animationValue <= 0.5) {
          _translateX = 80.0;
          _rotate = -20.0;
          _scale = 0.1;
        } else if (_animationValue >= 0.5 && _animationValue <= 0.8) {
          _translateY = -20.0;
        } else if (_animationValue >= 0.81) {
          _containerPaddingLeft = 20.0;
          sent = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    buildContext = context;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Baloo_Da_2',
          brightness: Brightness.light,
          primaryColor: Colors.white,
          primaryColorLight: Colors.black),
      home: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back),
          title: Text(Strings.new_post_title),
        ),
        body: setContentView(),
      ),
    );
  }

  Widget animatedButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(
            padding:
                const EdgeInsets.only(left: 120.00, bottom: 8.0, top: 40.0),
            child: Center(
                child: GestureDetector(
                    onTap: () {
                      _animationController.forward();
                      Future.delayed(Duration(seconds: 10));
                      Alert(
                        context: context,
                        title: 'Hey Lebo',
                        desc: 'Thank you for notifying',
                        image: Image.asset('assets/images/slider_1.png'),
                      ).show();
                    },
                    child: AnimatedContainer(
                        decoration: BoxDecoration(
                          color: _color,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          boxShadow: [
                            /*BoxShadow(
                              color: _color,
                              blurRadius: 21,
                              spreadRadius: -15,
                              offset: Offset(
                                0.0,
                                20.0,
                              ),
                            )*/
                          ],
                        ),
                        padding: EdgeInsets.only(
                            left: 120.00, top: 8.0, bottom: 8.0),
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeOutCubic,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            (!sent)
                                ? AnimatedContainer(
                                    duration: Duration(milliseconds: 400),
                                    child: Icon(Icons.send),
                                    curve: Curves.fastOutSlowIn,
                                    transform: Matrix4.translationValues(
                                        _translateX, _translateY, 0)
                                      ..rotateZ(_rotate)
                                      ..scale(_scale),
                                  )
                                : Container(),
                            AnimatedSize(
                              vsync: this,
                              duration: Duration(milliseconds: 600),
                              child: show ? SizedBox(width: 10.0) : Container(),
                            ),
                            AnimatedSize(
                              vsync: this,
                              duration: Duration(milliseconds: 200),
                              child: show ? Text("Send") : Container(),
                            ),
                            AnimatedSize(
                              vsync: this,
                              duration: Duration(milliseconds: 200),
                              child: sent ? Icon(Icons.done) : Container(),
                            ),
                            AnimatedSize(
                              vsync: this,
                              alignment: Alignment.topLeft,
                              duration: Duration(milliseconds: 600),
                              child: sent ? SizedBox(width: 10.0) : Container(),
                            ),
                            AnimatedSize(
                              vsync: this,
                              duration: Duration(milliseconds: 200),
                              child: sent ? Text("Done") : Container(),
                            ),
                          ],
                        ))))),
      ],
    );
  }

  Widget setContentView() {
    return Stack(
      children: <Widget>[
        Positioned(top: 30.0, left: 15.0, child: _circularAvatar()),
        /*Align(
          alignment: Alignment.bottomCenter,
          child: _buttonBarLayout(),
        ),*/
        Align(
          alignment: Alignment.topRight,
          child: columnLayout(),
        ),
        //Positioned(bottom: 0.0, right: 0.0, child: Text("Bottom\nright")),
      ],
    );
  }

  Widget _moreInfoTextField() {
    return InkWell(
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(left: 120.00, top: 40.0),
          child: Container(
            //color: Colors.grey[300],
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: TextField(
                // Tell your textfield which controller it owns
                controller: moreInfoController,
                // Every single time the text changes in a
                // TextField, this onChanged callback is called
                // and it passes in the value.
                //
                // Set the text of your controller to
                // to the next value.
                onChanged: (v) => moreInfoController.text = v,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(50.0),
                  labelText: 'More details',
                  //prefixIcon: Icon(Icons.insert_comment),
                  enabledBorder: InputBorder.none,
                  hintMaxLines: 8,
                  helperMaxLines: 8,
                )),
          ),
        ),
        onTap: () {},
      ),
    );
  }

  Widget _circularAvatar() {
    return CircleAvatar(
      backgroundColor: Colors.grey,
      radius: 40.0,
      //child: Image.asset('assets/images/img.jpg')
      backgroundImage: ExactAssetImage('assets/images/img.jpg'),
    );
  }

  Widget textView() {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(left: 120.00, bottom: 8.0, top: 38.0),
        child: Container(
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Text('Store closed')),
      ),
    );
  }

  Widget _locationTextField() {
    return InkWell(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              buildContext,
              PageTransition(
                  type: PageTransitionType.leftToRight,
                  child: NewPostScreen()));
        },
        child: ListTile(
          title: Padding(
            padding:
                const EdgeInsets.only(left: 120.00, bottom: 8.0, top: 40.0),
            child: Container(
                //color: Colors.grey[300],
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Text('Get location')),
          ),
        ),
      ),
    );
  }

  Widget _buttonBarLayout() {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.grey[300],
            offset: Offset(5, 5),
            blurRadius: 1.0,
            spreadRadius: 5.0)
      ], color: Colors.white),
      child: ButtonBar(
        // this will take space as minimum as possible(to center)
        mainAxisSize: MainAxisSize.max,

        children: <Widget>[
          IconButton(
              icon: Icon(
                Icons.videocam,
                color: Colors.grey,
                size: 35,
              ),
              onPressed: () => null),
          Expanded(
            flex: 50,
            child: IconButton(
                icon: Icon(
                  Icons.image,
                  color: Colors.grey,
                  size: 35,
                ),
                onPressed: () => null),
          ),
          Expanded(flex: 6, child: _buttonBarLayoutSend())
        ],
      ),
    );
  }

  Widget _buttonBarLayoutSend() {
    return Container(
      color: Colors.white,
      /*decoration: BoxDecoration(
          boxShadow: [
          BoxShadow(color: Color.fromRGBO(0, 0, 0, .25), blurRadius: 16.0)
        ],
          ),*/
      child: ButtonBar(
        // this will take space as minimum as possible(to center)
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          IconButton(
              icon: Icon(
                Icons.send,
                color: Colors.grey,
                size: 35,
              ),
              onPressed: () => null),
        ],
      ),
    );
  }

  Widget columnLayout() {
    return ListView(
      children: <Widget>[
        textView(),
        _moreInfoTextField(),
        _locationTextField(),
        animatedButton()
      ],
    );
  }
}
