import 'package:blog_hanan/copy/elements/drawer_class.dart';
import 'package:blog_hanan/copy/pages/Home.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:blog_hanan/elements/globals.dart' as globals;

import '../models/details_model.dart';


class ArticleDetailsCopy extends StatefulWidget {
  final articleID ;
  const ArticleDetailsCopy({Key? key , this.articleID}) : super(key: key);

  @override
  State<ArticleDetailsCopy> createState() => _ArticleDetailsState();
}

class _ArticleDetailsState extends State<ArticleDetailsCopy> {

  Details ? details;
  List<Details> related = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiDetails(widget.articleID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerClass(),
      appBar: AppBar(title: Text("Article Details"),),
      body: ListView(
        children: [
          related.isEmpty ? Center(child: CircularProgressIndicator(),) : _details()
        ],
      ),
    );
  }

  _details(){
    return Container(
      child: Card(
        child: Column(
          children: [
            Center(
              child: Text(
                details!.subject ,
                style: TextStyle(fontSize: 18 , fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 5,),
            Image.network(
              "${globals.URL + details!.photo}",
              height: 250,
              width: MediaQuery.of(context).size.width * .95,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                Text(
                  "Category: ${details!.category.name}",
                  style: TextStyle(fontSize: 14 , fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Text("Viewers: ${details!.viewersCount}",
                  style: TextStyle(fontSize: 14 , fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: 5,),
            Container(
              padding: EdgeInsets.only(top: 10 , bottom: 10 , right: 10 , left: 10),
              child:   Text(
                "${details!.content}",
                style: TextStyle(fontSize: 14 ),
                textAlign: TextAlign.justify,
              ),
            ),
            _slider(),
          ],
        ),
      ),
    );
  }

  _slider(){
    return
      CarouselSlider(
        options: CarouselOptions(
          height: 150,
          aspectRatio: 16/9,
          viewportFraction: 0.35,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 4),
          autoPlayAnimationDuration: Duration(seconds: 2),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: false,
          onPageChanged: null,
          scrollDirection: Axis.horizontal,
        ),
        items: related.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  margin:  EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context)=> ArticleDetailsCopy(articleID: "${i.id}" ,))
                        );
                        }, // Image tapped
                        child:
                        Image.network(
                          "${globals.URL + i.photo}" ,
                          height: 70 ,
                          width: MediaQuery.of(context).size.width * .95,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Text(
                        "${i.photo}",
                        style: TextStyle(fontSize: 12.0),
                        textAlign: TextAlign.center,
                      )
                    ],
                  )
              );
            },
          );
        }).toList(),
      );

  }

  Future apiDetails (articleID) async{
    final Uri url = Uri.parse("${globals.URL}api/details/$articleID");

    final response =  await http.get(url);
    if(response.statusCode == 200){
      final finalReponse = detailsModelFromJson(response.body) ;

      details = (finalReponse.blog.data.details) as Details?;
      // related = finalReponse.blog.data.related.cast<Data>();
      related.addAll(finalReponse.blog.data.related) ;
      setState(() {});
    }
  }

}
