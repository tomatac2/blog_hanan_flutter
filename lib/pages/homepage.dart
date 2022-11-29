import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Homepage"),),
      body: Container(
        child: ListView(
          children: [
            _slider(),
            _articles(),
            _articles(),
            _articles(),
            _articles(),
            _articles(),

          ],
        ),
      ),
    );
  }

  _articles(){
    return Column(
        children: [
          Text(
            "Design Unique Promotional Items HTML Templat",
            style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 18 ),
            textAlign: TextAlign.center,
          ),
          Image.network(
            "https://images.unsplash.com/photo-1531297484001-80022131f5a1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=820&q=80",
            height: 300,
          ) ,
          _statisticArticle() ,
          _articleBody()




        ],
    );
  }

  _articleBody(){
    return Container(
      margin: EdgeInsets.only(left: 10 , right: 10),
      padding: EdgeInsets.all(10),
      child:
      Text(
        "Design Unique Promotional Items HTML Templat When using HTML Builder you will be able to adjust colors, fonts, header and fooer, layout, columns and other design elements, as well as content and image When using HTML Builder you will be able to adjust colors, fonts, header and fooer, layout, columns and other design elements, as well as content and image When using HTML Builder you will be able to adjust colors, fonts, header and fooer, layout, columns and other design elements, as well as content and image",
        style: TextStyle(fontSize: 14 ),
        textAlign: TextAlign.justify,
      ),
    );
  }
  _statisticArticle(){
    return  Container(
      margin: EdgeInsets.only(left: 10 , right: 10),
      child:  Row(
        children: [
          Text(
            "Category: News",
            style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 14 ),
            textAlign: TextAlign.center,
          ),
          Spacer(),
          Text(
            "Viewers: 500",
            style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 14 ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  _slider(){
    return
      CarouselSlider(
          options: CarouselOptions(
            height: 120,
            aspectRatio: 16/9,
            viewportFraction: 0.4,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: false,
            autoPlayInterval: Duration(seconds: 4),
            autoPlayAnimationDuration: Duration(seconds: 2),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: false,
            onPageChanged: null,
            scrollDirection: Axis.horizontal,
          ),
        items: [1,2,3,4,5].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  margin:  EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Column(
                    children: [
                      Image.asset("assets/icons/3034595.png" , height: 70 , fit: BoxFit.fill,),
                      Text('News', style: TextStyle(fontSize: 16.0),)
                    ],
                  )
              );
            },
          );
        }).toList(),
      )
     ;

  }
}
