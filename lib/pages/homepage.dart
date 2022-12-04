import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/home_model.dart';
import 'package:blog_hanan/elements/globals.dart' as globals;

class Homepage extends StatefulWidget {
  final dynamic catID ;
  const Homepage({Key? key , this.catID}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  List<Category> categories = [];
  List<Article> articles = [];
  int page = 1 ;
  int end = 5 ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiHome(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Homepage"),),
      body: Container(
        child: Column(
          children: [
            _slider(),
            articles.isEmpty  ? const Center(child: CircularProgressIndicator()  ) :  _articles(),
          ],
        ),
      ),
    );
  }

  _articles(){
    return
    Expanded(child:
    ListView.builder(
      itemCount: end,
      itemBuilder: (context, index) {

        int keyy = index ;
        keyy ++ ;

        double eqution = keyy/5 ;
        RegExp regx = RegExp(r'([.]*0)(?!.*\d)');
        String eqution2String = eqution.toString().replaceAll(regx, '');

        if(int.tryParse(eqution2String) is int){
          page++;
          apiHome(page);
        }
        print("eqution $eqution");
        return
          Column(
            children: [
              Text(
                "${articles[index].subject}",
                style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 18 ),
                textAlign: TextAlign.center,
              ),
              Image.network(
                "${ globals.URL+articles[index].photo}",
                width: MediaQuery.of(context).size.width * .95,
                height: 300,
                fit: BoxFit.fill,
              ) ,
              _statisticArticle(index) ,
              _articleBody(index)


            ],
          );
      },
    )
    )
    ;




  }

  _articleBody(index){
    return Container(
      margin: EdgeInsets.only(left: 10 , right: 10),
      padding: EdgeInsets.all(10),
      child:
      Text(
        "${articles[index].shortDesc}",
        style: TextStyle(fontSize: 14 ),
        textAlign: TextAlign.justify,
      ),
    );
  }
  _statisticArticle(index){
    return  Container(
      margin: EdgeInsets.only(left: 10 , right: 10),
      child:  Row(
        children: [
          Text(
            "Category: ${articles[index].category.name}",
            style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 14 ),
            textAlign: TextAlign.center,
          ),
          Spacer(),
          Text(
            "Viewers: ${articles[index].viewersCount}",
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
        items: categories.map((i) {
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
                                  builder: (context)=> Homepage(catID: "${i.id}"))
                          );
                          print("${i.name}"); }, // Image tapped
                        child:
                        Image.network("${globals.URL + i.photo}" , height: 70 , fit: BoxFit.fill,),
                      ),
                      Text('${i.name}', style: TextStyle(fontSize: 16.0),)
                    ],
                  )
              );
            },
          );
        }).toList(),
      )
     ;

  }
  /////////////////////

  Future apiHome (page) async{
      final Uri url = Uri.parse("${globals.URL}api/home?page=$page&catID=${widget.catID ?? 0}");

      final response =  await http.get(url);
      if(response.statusCode == 200){
        final finalReponse = homeModelFromJson(response.body) ;
        categories.addAll(finalReponse.blog.data.categories);
        articles.addAll(finalReponse.blog.data.articles);
        end = finalReponse.blog.pagination.end ;

       // print(finalReponse);
        setState(() {});
      }
  }



}
