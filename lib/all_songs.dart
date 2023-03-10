import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:music/screen1.dart';

class allsongs extends StatefulWidget {
  const allsongs({Key? key}) : super(key: key);

  @override
  State<allsongs> createState() => _allsongsState();
}
final OnAudioQuery _audioQuery = OnAudioQuery();
final AudioPlayer _player= AudioPlayer();


class _allsongsState extends State<allsongs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<SongModel>>(
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
                        if(checkFav(item, index)) {
                          fav.remove(item.data![index].id);
                          favsongs.remove(item.data![index]);

                        }
                        else{
                          fav.add(item.data![index].id);
                          favsongs.add(item.data![index]);
                        }
                        setState(() {});
                      }, icon: checkFav(item, index)? const Icon(CupertinoIcons.heart_fill):const Icon(CupertinoIcons.heart)),//Icon(CupertinoIcons.heart)),//const Icon(Icons.more_vert),
                      leading:  QueryArtworkWidget(
                        id: item.data![index].id,
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: const Icon(Icons.music_note),
                      ),//?? Icon(Icons.music_note),
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
    );
  }
}
