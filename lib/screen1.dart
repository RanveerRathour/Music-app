// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music/radio.dart';
import 'package:music/screen2.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:velocity_x/velocity_x.dart';

import 'all_songs.dart';

List<songdata> sng=[];
List<dynamic> favsongs=[];
List<int> fav=[];
class call1 extends StatelessWidget {
  const call1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //fetchSongs();

    return screen1();
  }
}

fetchSongs() async {
  final songjson = await rootBundle.loadString("assets/song.json");
  sng = MySongsList
      .fromJson(songjson)
      .songs;
  // print(sng);
 // setState(() {});
}

class screen1 extends StatefulWidget {
  const screen1({Key? key}) : super(key: key);

  @override
  State<screen1> createState() => _screen1State();
}

final OnAudioQuery _audioQuery = OnAudioQuery();
final AudioPlayer _player= AudioPlayer();


List<String> j=["assets/images/c1.png","assets/images/c2.png","assets/images/c3.png"];

bool checkFav(AsyncSnapshot<List<SongModel>> item, int index)
{
  return fav.contains(item.data![index].id);
}

class _screen1State extends State<screen1> {

  @override
  void initState() {
    super.initState();
    //fetchSongs();
    WidgetsBinding.instance.addPostFrameCallback((_)=> fetchSongs());
    requestStoragePermission();
  }

void removeSong(int id)
{
  int i=favsongs.indexOf(id);

  print("index of give id:$id is$i");
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        endDrawer: const Drawer(),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(
              255, 244, 249, 255), //Color.fromARGB(255, 214, 206, 181),//
          title: "Music".text.xl4.bold.black.fontFamily('OpenSans').make(),
          elevation: 0.0,

          actions: [
            Builder(
              builder: ((context) =>
                  IconButton(
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      icon: const Icon(
                        Icons.sort_rounded,
                        size: 30,
                        color: Colors.black,
                      ))),
            )
          ],
        ),
        body:   ListView(
          children:[
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    VxSwiper.builder(
                        itemCount: sng.length,
                        aspectRatio: 1.5,
                        enableInfiniteScroll: true,
                        enlargeCenterPage: true,
                        itemBuilder: (context, index) {
                          final rad = sng[index];
                          return VxBox(
                              child: ZStack([
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: HStack([
                                    rad.name.text.xl4.white.bold.make().p16(),

                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 55, bottom: 40),
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(CupertinoIcons
                                            .arrowtriangle_right_square_fill,
                                          size: 60, color: Colors.white,),
                                      ),
                                    ),
                                  ]),
                                ),
                              ])).shadowXl.bgImage(DecorationImage(
                            image: AssetImage(rad.image),
                            fit: BoxFit.cover,
                          ))
                              .withRounded(value: 30)
                              .make().p12();
                        }),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: GestureDetector(
                        onTap: ()=> Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => screen2()),
                        ),
                        child: Container(
                          color: const Color.fromARGB(255, 244, 249, 255),
                          height: 250.0,
                          width: 50,
                          child: Column(
                            children: const [
                              Icon(
                                CupertinoIcons.square_on_square,
                                //Icons.music_note,
                                size: 25,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              RotatedBox(
                                quarterTurns: -1,
                                child: Text(
                                  "Your   favourite",
                                  style: TextStyle(
                                      fontSize: 20, fontFamily: 'OpenSans'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Container(
                      child: "New Album".text.bold.xl4.make().p16(),
                    ),
                    Spacer(),
                    //Text("see all >", style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 246, 171, 184)),).px16().onInkTap(() { }),
                    "see all >".text.sm.semiBold.gray700.make()
                        .px16()
                        .onInkTap(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => screen2()),
                      );
                    })
                  ],
                ),
                Row(
                  children: [
                    Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: const[
                            BoxShadow(
                              blurRadius: 4.0,
                              offset: Offset(-4, -4),
                              color: Colors.white24,
                            ),
                            BoxShadow(
                              blurRadius: 4.0,
                              offset: Offset(4, 4),
                              color: Colors.black12,
                            ),
                          ],
                        ),
                        child: Card(
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),


                          child: Image(
                            image: AssetImage(j[2]),

                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: const[
                            BoxShadow(
                              blurRadius: 4.0,
                              offset: Offset(-4, -4),
                              color: Colors.white24,
                            ),
                            BoxShadow(
                              blurRadius: 4.0,
                              offset: Offset(4, 4),
                              color: Colors.black12,
                            ),
                          ],
                        ),
                        child: Card(

                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Image(
                            image: AssetImage(j[1]),

                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: const[
                            BoxShadow(
                              blurRadius: 4.0,
                              offset: Offset(-4, -4),
                              color: Colors.white24,
                            ),
                            BoxShadow(
                              blurRadius: 4.0,
                              offset: Offset(4, 4),
                              color: Colors.black12,
                            ),
                          ],
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Image(
                            image: AssetImage(j[0]),

                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      child: "Songs List".text.bold.xl4.make().p16(),
                    ),
                    Spacer(),
                    //Text("see all >", style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 246, 171, 184)),).px16().onInkTap(() { }),
                    "see all >".text.sm.semiBold.gray700.make()
                        .px16()
                        .onInkTap(() {

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => allsongs()),
                      );
                    })
                  ],
                ),
              ],
            ),
                Container(
                  height: 400,//MediaQuery.of(context).size.height,
                  child: RefreshIndicator(
                      child: FutureBuilder<List<SongModel>>(
                          future: _audioQuery.querySongs(
                            sortType: SongSortType.TITLE,
                            orderType: OrderType.ASC_OR_SMALLER,
                            uriType: UriType.EXTERNAL,
                            ignoreCase: true,
                          ),

                          builder: (context, item) {
                            if (item.data == null) {
                              return const Center(child: CircularProgressIndicator(),);
                            }
                            if (item.data!.isEmpty) {
                              return const Center(child: Text("No Songs Found"),);
                            }

                            //songs.clear();
                            //songs = item.data!;


                            return ListView.builder(
                                shrinkWrap: true,

                                itemCount: item.data!.length,
                                itemBuilder: (context, index) {

                                  return Container(
                                    //height: MediaQuery.of(context).size.height,
                                    margin: const EdgeInsets.only(top: 15.0,
                                      left: 12.0,
                                      right: 12.0,),
                                    padding: const EdgeInsets.only(top: 5.0,
                                        bottom: 5.0),

                                    child: ListTile(

                                      title: Text(item.data![index].displayName,
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
                                      ),
                                      subtitle: Text(item.data![index].title),
                                      trailing: IconButton(onPressed: (){
                                        setState(() {});
                                        if(checkFav(item, index)) {
                                          print("before");
                                          print(favsongs);
                                          fav.remove(item.data![index].id);

                                          favsongs.remove(item.data![index]);

                                          print("after");
                                          print(favsongs);
                                          removeSong(item.data![index].id);

                                        }
                                        else{
                                          fav.add(item.data![index].id);
                                          favsongs.add(item.data![index]);
                                          favsongs.toSet().toList();
                                          fav.toSet().toList();
                                        }
                                        setState(() {});
                                      }, icon: checkFav(item, index)? Icon(CupertinoIcons.heart_fill):Icon(CupertinoIcons.heart)),//Icon(CupertinoIcons.heart)),//const Icon(Icons.more_vert),
                                      leading:  QueryArtworkWidget(
                                        id: item.data![index].id,
                                        type: ArtworkType.AUDIO,
                                        nullArtworkWidget: Icon(Icons.music_note),
                                      ),
                                      // onTap: () async {
                                      //   currentIndex=index;
                                      //   _changePlayerViewVisibility();
                                      //
                                      //   currentSongTitle=item.data![index].title;
                                      //   toast(context,"playing: ${item.data![index].title}");
                                      //
                                      //   await _player.setAudioSource(
                                      //     createPlaylist(item.data!),
                                      //     initialIndex: index,
                                      //   );
                                      //   await _player.play();
                                      // },
                                    ),

                                  );
                                }
                            );
                          }
                      ),
                      onRefresh: (){
                        return Future.delayed(Duration(seconds: 1),(){
                          setState(() {});

                        });
                      }
                  ),

                ),
         ],
        ),
      ),
    );
  }

  void requestStoragePermission() async {
    bool permissionStatus = await _audioQuery.permissionsStatus();
    if(!permissionStatus){
      await _audioQuery.permissionsRequest();
    }
    setState((){});
  }

}
