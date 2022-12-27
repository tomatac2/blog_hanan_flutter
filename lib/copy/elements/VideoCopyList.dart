import 'package:blog_hanan/copy/elements/drawer.dart';
import 'package:blog_hanan/copy/elements/drawer_class.dart';
import 'package:blog_hanan/models/videos_model.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:blog_hanan/elements/globals.dart' as globals;

/// Creates list of video players
class VideoCopyList extends StatefulWidget {
  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoCopyList> {

  int page = 1 ;

  List<Datum>  videoArr = [] ;

  final List _listOfIds = [] ;

  int end = 3 ;

  static List<YoutubePlayerController> ? _controllers ;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadVideosByApi(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerClass2(),
        appBar: AppBar(
          title: const Text('Video List Demo'),
        ),
        body: videoArr.isEmpty ? Center(child: CircularProgressIndicator(),) : _vidosListPage()

    );
  }
  _vidosListPage(){
    return  ListView.separated(
      itemBuilder: (context, index) {
        int keyy = index ;
        keyy ++ ;

        double eqution = keyy/3 ;
        RegExp regx = RegExp(r'([.]*0)(?!.*\d)');
        String eqution2String = eqution.toString().replaceAll(regx, '');

        if(int.tryParse(eqution2String) is int){
          page++;
          loadVideosByApi(page);
        }

        return
          Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(5),
            child:
            Card(
              child:  Column(
                children: [
                  Text(
                    videoArr[index].subject ,
                    style: TextStyle(fontSize: 18 , fontWeight: FontWeight.w600),),
                  SizedBox(height: 10,),
                  _youtubePlayer(index),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Text(
                        "Category: ${videoArr[index].category.name}",
                        style: TextStyle(fontSize: 14 , fontWeight: FontWeight.w600),
                      ),
                      Spacer(),
                      Text("Viewers: ${videoArr[index].viewersCount}",
                        style: TextStyle(fontSize: 14 , fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Container(
                    padding: EdgeInsets.only(top: 10 , bottom: 10 , right: 10 , left: 10),
                    child:   Text(
                      "${videoArr[index].shortDesc}",
                      style: TextStyle(fontSize: 14 ),
                      textAlign: TextAlign.justify,
                    ),
                  )
                ],
              ) ,
            ),
          )

        ;


      },
      itemCount: end,
      separatorBuilder: (context, _) => const SizedBox(height: 10.0),
    );
  }
  _youtubePlayer(index){
    return
      YoutubePlayer(
        key: ObjectKey(_controllers ! [index]),
        controller: _controllers ! [index],
        actionsPadding: const EdgeInsets.only(left: 16.0),
        bottomActions: [
          CurrentPosition(),
          const SizedBox(width: 10.0),
          ProgressBar(isExpanded: true),
          const SizedBox(width: 10.0),
          RemainingDuration(),
          FullScreenButton(),
        ],
      );
  }


  Future loadVideosByApi(page) async{
    final Uri url = Uri.parse("${globals.URL}api/videos?page=$page");

    final response =  await http.get(url);
    if(response.statusCode == 200){
      final finalReponse = videosModelFromJson(response.body) ;
      videoArr.addAll(finalReponse.blog.data);
      end = finalReponse.blog.pagination.end ;

      for(var allVideos in  videoArr){
        var videosIds = YoutubePlayer.convertUrlToId(allVideos.viedoLink);
        _listOfIds.add(videosIds) ;
      }
      _controllers =
          _listOfIds.map<YoutubePlayerController>(
                (videoId) => YoutubePlayerController(
              initialVideoId: videoId,
              flags: const YoutubePlayerFlags(
                autoPlay: false,
              ),
            ),
          )
              .toList();
      // print(finalReponse);
      setState(() {});
    }

  }
}