// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music/radio.dart';
import 'package:music/screen1.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rxdart/rxdart.dart';
import 'package:velocity_x/velocity_x.dart';


class screen2 extends StatefulWidget {
  const screen2({Key? key}) : super(key: key);

  @override
  State<screen2> createState() => _screen2State();
}
final OnAudioQuery _audioQuery = OnAudioQuery();
final AudioPlayer _player= AudioPlayer();
class _screen2State extends State<screen2> {

  @override
  void initState() {

    super.initState();
    requestStoragePermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: favsongs.length,
            itemBuilder: (context, index) {
              print("screen2: ${favsongs.length}");
              print("screen2: ${fav.length}");
              print("screen2: ${fav}");
              return Container(

                margin: const EdgeInsets.only(top: 15.0,
                  left: 12.0,
                  right: 12.0,),
                padding: const EdgeInsets.only(top: 5.0,
                    bottom: 5.0),

                child: ListTile(
                  title: Text(favsongs[index].title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
                  ),
                  subtitle: Text(favsongs[index].displayName),
                  trailing: IconButton(onPressed: (){}, icon: Icon(Icons.favorite)),
                  leading: QueryArtworkWidget(
                    id: favsongs[index].id,
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: Icon(Icons.music_note,size: 40,),
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
        ),
      // FutureBuilder<List<SongModel>>(
      //     future: _audioQuery.querySongs(
      //       sortType: SongSortType.TITLE,
      //       orderType: OrderType.ASC_OR_SMALLER,
      //       uriType: UriType.EXTERNAL,
      //       ignoreCase: true,
      //     ),
      //
      //     builder: (context, item) {
      //       if (item.data == null) {
      //         return const Center(child: CircularProgressIndicator(),);
      //       }
      //       if (item.data!.isEmpty) {
      //         return const Center(child: Text("No Songs Found"),);
      //       }
      //
      //       //songs.clear();
      //       //songs = item.data!;
      //
      //
      //       return ListView.builder(
      //           itemCount: item.data!.length,
      //           itemBuilder: (context, index) {
      //
      //             return Container(
      //               margin: const EdgeInsets.only(top: 15.0,
      //                 left: 12.0,
      //                 right: 12.0,),
      //               padding: const EdgeInsets.only(top: 5.0,
      //                   bottom: 5.0),
      //
      //               child: ListTile(
      //                 title: Text(item.data![index].title,
      //                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
      //                 ),
      //                 subtitle: Text(item.data![index].displayName),
      //                 trailing: IconButton(onPressed: (){}, icon: Icon(Icons.favorite)),
      //                 leading: QueryArtworkWidget(
      //                   id: item.data![index].id,
      //                   type: ArtworkType.AUDIO,
      //                 ),
      //                 // onTap: () async {
      //                 //   currentIndex=index;
      //                 //   _changePlayerViewVisibility();
      //                 //
      //                 //   currentSongTitle=item.data![index].title;
      //                 //   toast(context,"playing: ${item.data![index].title}");
      //                 //
      //                 //   await _player.setAudioSource(
      //                 //     createPlaylist(item.data!),
      //                 //     initialIndex: index,
      //                 //   );
      //                 //   await _player.play();
      //                 // },
      //               ),
      //
      //             );
      //           }
      //       );
      //     }
      // ),
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
