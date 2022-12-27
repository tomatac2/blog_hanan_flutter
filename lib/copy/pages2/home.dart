import 'package:blog_hanan/copy/models/home_model.dart';
import 'package:blog_hanan/copy/pages/details.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:blog_hanan/copy/elements/globals.dart' as globals;

//import '../elements/drawer_class.dart';

//copy2
import 'package:blog_hanan/copy/elements/drawer.dart';

class Home extends StatefulWidget {

  final dynamic catID ;
  const Home({Key? key ,  this.catID}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Category> categories = [];
  List<Article> articles = [];
  int page = 1 ;
  int countPages = 5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeApi(page);
    readStore();
  }

  @override
  Widget build(BuildContext context) {

    print("Token is Storeage ${globals.Token}");
    return Scaffold(
      drawer: DrawerClass2(),
      appBar: AppBar(title: Text("Homepage"),),
      body:
        Column(
        children: [
          _slider(),
          articles.isEmpty ?  const Center(child: CircularProgressIndicator()) :  _articles(),
        ],
      ),
    );
  }



  Future<void> _readTokenFromStorage() async {
    final storage = new FlutterSecureStorage();
    globals.Token = (await storage.read(key: "Token"))!;
     setState(() { });
  }

  _articles(){
    return Expanded(
        child: ListView.builder(
            itemCount: countPages,
            itemBuilder: (BuildContext context , int index){
              int count = index ;
              count++ ;

              //paginate every 5 articles 
              double eqution = count/5 ;
              RegExp regx = RegExp(r'([.]*0)(?!.*\d)');
              String eqtionString = eqution.toString().replaceAll(regx, '');

                if(int.tryParse(eqtionString) is int) {
                  page ++ ;
                  homeApi(page);
                }
          return
          Card(
            child:  Column(
              children: [
                Text(
                  articles[index].subject,
                  style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 18 ),
                  textAlign: TextAlign.center,
                ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context)=> ArticleDetailsCopy(articleID : "${articles[index].id}") )
                );
              }, // Image tapped
              child:
                Image.network(
                  "${globals.URL+ articles[index].photo}",
                  fit:  BoxFit.fill,
                  height: 300,
                  width: MediaQuery.of(context).size.width * .95,
                )
              ),
                _statisticArticle(index) ,
                _articleBody(index)
              ],
            ) ,
          );

        })
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
                            MaterialPageRoute(builder: (context) => Home(catID: i.id,) )    
                        );
                      },
                       child: Image.network("${globals.URL+i.photo}" , height: 70 , fit: BoxFit.fill,),
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

  ///api
  Future homeApi(page) async{
    final Uri url = Uri.parse("${globals.URL}api/home?page=$page&catID=${widget.catID ?? 0}");
    final response = await http.get(url);

    if(response.statusCode == 200){
      final getResult = detailsModelFromJson(response.body);

      categories.addAll(getResult.blog.data.categories);
      articles.addAll(getResult.blog.data.articles);
      countPages = getResult.blog.pagination.end;
      setState(() {});
    }
  }


  readStore() async {
    // Create storage
    final storage = new FlutterSecureStorage();

// Read value
    String? tokenFromStorge = await storage.read(key: "Token");
    globals.Token = tokenFromStorge! ;
  }

}
