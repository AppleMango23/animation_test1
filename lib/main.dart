import 'package:flutter/material.dart';
import 'data.dart';
import 'dart:math';

void main()=> runApp(MaterialApp(
  home: MyApp(),
  debugShowCheckedModeBanner: false,
));

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState()=>new _MyAppState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio;

class _MyAppState extends State<MyApp>{
  var currentPage = images.length - 1.0;
  

  snackbarFunction(BuildContext context){
    final snackBar = SnackBar(
      content: Text('Yay! A SnackBar!'),
      action: SnackBarAction(
        label: 'Undo',textColor: Colors.white,
        onPressed: () {
          // Some code to undo the change.
        },
      ),
      backgroundColor: Color(0xFFff6e6e),
      );
    Scaffold.of(context).showSnackBar(snackBar);
  }
  @override
  Widget build(BuildContext context){
  
  PageController controller = PageController(initialPage: images.length - 1);
  controller.addListener((){
    setState((){
      currentPage = controller.page;
    });
  });

    return Scaffold(
      backgroundColor:Color(0xFF2d3447),
      body: 
        Builder(
        builder: (context) => 
        SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left:12.0,top:30.0,bottom:8.0),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // padding: const EdgeInsets.all(8.0),
              IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 30.0,
                ),
                onPressed: (){},
              ),
              IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
                size: 30.0,
              ),
              onPressed:(){snackbarFunction(context);},
              )
            ],
            ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Trending",style: TextStyle(
                    color:Colors.white,
                    fontSize: 46.0,
                    // The font family isnt working.
                    fontFamily: "Calibre-Semibold",
                    letterSpacing: 1.0,
                  ),),
                  IconButton(
                    icon: Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                      size: 45.0,
                    ),
                    onPressed: (){},
                  ),
                  
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFff6e6e),
                  borderRadius: BorderRadius.circular(20.0)
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 6.0),
                    child: Text(
                      "Animated",
                      style: TextStyle(color: Colors.white))
                    ),
                  ),
                ),
              SizedBox(width: 15.0,),
              Text("25+ Storries",style: TextStyle(color: Colors.blueAccent),)
            ],),
            ),
            Stack(
              children: <Widget>[
                CardScrollWidget(currentPage),
                Positioned.fill(
                  child: PageView.builder(
                    itemCount: images.length,
                    controller: controller,
                    reverse: true,
                    itemBuilder: (context,index){
                      return Container();
                    },
                  ),
                )
              ],
            )
          ],
          )
        ),
        )
    );
  }
}


class CardScrollWidget extends StatelessWidget {
  var currentPage;
  var padding = 20.0;
  var verticalInset = 20.0;

  CardScrollWidget(this.currentPage);

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth+10;
        var height = contraints.maxHeight;

        var safeWidth = width - 2 * padding+10;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight - 50;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio - 10;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = new List();

        for (var i = 0; i < images.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding +
            // Left
            max(
                primaryCardLeft -
                    horizontalInset * -delta * (isOnRight ? 15 : 1),
                0.0) - 45;

          var cardItem = Positioned.directional(
            // Size of the photo
            top: padding + verticalInset * max(-delta, 0.0)+20 ,
            bottom: padding + verticalInset * max(-delta, 0.0)+20,
            start: start,
            textDirection: TextDirection.rtl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3.0, 6.0),
                      blurRadius: 10.0)
                ]),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image.asset(images[i], fit: BoxFit.cover),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 20.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, bottom: 12.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 22.0, vertical: 6.0),
                                decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Text("Read Later",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}