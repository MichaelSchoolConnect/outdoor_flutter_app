import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:outdoor_flutter_app/ui/NewPostScreen.dart';
import 'package:page_transition/page_transition.dart';

class ActivitySelectionPage extends StatelessWidget {
  var imageList;

  ActivitySelectionPage(String s);
  @override
  Widget build(BuildContext context) {
    final title = 'What`s happening?';
    imageList = <Image>[];
    imageList.add(Image.asset('assets/images/slider_1'));
    imageList.add(Image.asset('assets/images/slider_1'));
    imageList.add(Image.asset('assets/images/slider_1'));
    imageList.add(Image.asset('assets/images/slider_2'));
    imageList.add(Image.asset('assets/images/slider_2'));
    imageList.add(Image.asset('assets/images/slider_2'));
    imageList.add(Image.asset('assets/images/slider_3'));
    imageList.add(Image.asset('assets/images/slider_3'));
    imageList.add(Image.asset('assets/images/slider_3'));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Baloo_Da_2',
          brightness: Brightness.light,
          primaryColor: Colors.white),
      home: Scaffold(
        appBar: AppBar(leading: Icon(Icons.arrow_back), title: Text(title)),
        body: GestureDetector(
          child: GridView.count(
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            crossAxisCount: 3,
            padding: EdgeInsets.only(top: 8),
            // Generate 100 widgets that display their index in the List.
            children: <Widget>[
              returnImageViewWithText(
                  'assets/activities_images/accident.png', 'Accident'),
              returnImageViewWithText('assets/activities_images/alcohol.png',
                  'No alcohol beverage'),
              returnImageViewWithText(
                  'assets/activities_images/atm_offline.png', 'ATM Offline'),
              returnImageViewWithText(
                  'assets/activities_images/closed_road.png', 'Road closed'),
              returnImageViewWithText(
                  'assets/activities_images/event.png', 'Event'),
              returnImageViewWithText(
                  'assets/activities_images/flight_delay.png', 'Flight delay'),
              returnImageViewWithText(
                  'assets/activities_images/floods.png', 'Floods'),
              returnImageViewWithText(
                  'assets/activities_images/gas_.png', 'Fuel shortage'),
              returnImageViewWithText(
                  'assets/activities_images/sys.png', 'Offline System'),
              returnImageViewWithText(
                  'assets/activities_images/construction_one.png',
                  'Construction works'),
              returnImageViewWithText(
                  'assets/activities_images/food_stock_shortage.png',
                  'Stock shortage'),
              returnImageViewWithText(
                  'assets/activities_images/funeral.png', 'Funeral procession'),
              returnImageViewWithText(
                  'assets/activities_images/heavy_traffic.png',
                  'Heavy traffic'),
              returnImageViewWithText(
                  'assets/activities_images/long_queue.png', 'Long queue'),
              returnImageViewWithText(
                  'assets/activities_images/community_meeting.png',
                  'Community meeting'),
              returnImageViewWithText(
                  'assets/activities_images/power_outage.png', 'Power outage'),
              returnImageViewWithText(
                  'assets/activities_images/water_restriction.png',
                  'Water outage'),
              returnImageViewWithText(
                  'assets/activities_images/train_delay.png', 'Train delay')
            ],
          ),
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.leftToRight,
                    child: NewPostScreen()));
          },
        ),
      ),
    );
  }

  Widget returnImageViewWithText(String path, String name) {
    return Container(
      alignment: Alignment.center,
      //padding: EdgeInsets.,
      child: Column(
        children: <Widget>[
          Image.asset(
            path,
            height: 70,
            width: 70,
          ),
          Text(
            name,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget returnAnimation() {
    return SafeArea(
      child: AnimationLimiter(
        child: GridView.count(
          crossAxisCount: 3,
          padding: EdgeInsets.only(top: 8),
          children: List.generate(
            100,
            (int index) {
              return AnimationConfiguration.staggeredGrid(
                columnCount: imageList,
                position: index,
                duration: const Duration(milliseconds: 375),
                child: ScaleAnimation(
                  scale: 0.5,
                  child: FadeInAnimation(
                    child: returnImageViewWithText('path', 'name'),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
