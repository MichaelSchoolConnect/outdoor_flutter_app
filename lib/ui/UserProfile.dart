//Form widget for sign ups:
// Flutter code sample for Form

// This example shows a [Form] with one [TextFormField] to enter an email
// address and a [RaisedButton] to submit the form. A [GlobalKey] is used here
// to identify the [Form] and validate input.
//
// ![](https://flutter.github.io/assets-for-api-docs/assets/widgets/form.png)

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outdoor_flutter_app/ui/HomeScreen.dart';
import 'package:page_transition/page_transition.dart';

/// This Widget is the main application widget.
class UserProfile extends StatelessWidget {
  static const String _title = 'User profile';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Baloo_Da_2',
          brightness: Brightness.light,
          primaryColor: Colors.white),
      home: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back),
          title: const Text(_title),
          //automaticallyImplyLeading: true,
          // backgroundColor: Colors.grey,
        ),
        //backgroundColor: Colors.white,
        body: SafeArea(child: MyStatefulWidget()),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailEditingContrller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(24),
            child: Center(
              child: Column(
                children: <Widget>[
                  Center(
                    child: AvatarGlow(
                      endRadius: 90,
                      duration: Duration(seconds: 2),
                      glowColor: Colors.grey,
                      repeat: true,
                      repeatPauseDuration: Duration(seconds: 2),
                      startDelay: Duration(seconds: 1),
                      child: Material(
                          elevation: 8.0,
                          shape: CircleBorder(),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[100],
                            child: CircleAvatar(
                              radius: 50.0,
                              //child: Image.asset('assets/images/img.jpg')
                              backgroundImage:
                                  ExactAssetImage('assets/images/img.jpg'),
                            ),
                            radius: 50.0,
                          )),
                    ),
                  ),
                  fab(),
                  SizedBox(
                    height: 80,
                  ),
                  Row(
                    children: <Widget>[],
                  ),
                  TextField(
                    autofocus: false,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    controller: emailEditingContrller,
                    decoration: InputDecoration(
                      icon: Icon(Icons.account_circle),
                      labelText: 'Name',
                      hintText: 'Name',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ButtonTheme(
                    //elevation: 4,
                    //color: Colors.green,
                    minWidth: double.infinity,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                      onPressed: () => {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.leftToRight,
                                child: HomeScreen())),
                      },
                      textColor: Colors.white,
                      color: Colors.grey,
                      height: 50,
                      child: Text('Continue'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget fab() {
    return FloatingActionButton.extended(
        backgroundColor: Colors.grey,
        onPressed: () {},
        label: Text('Edit Profile'),
        icon: Icon(Icons.edit));
  }
}
