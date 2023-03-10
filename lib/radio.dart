// ignore_for_file: public_member_api_docs, sort_constructors_first, camel_case_types, depend_on_referenced_packages
import 'dart:convert';

import 'package:collection/collection.dart';

class MySongsList {
  final List<songdata> songs;
  MySongsList({
    required this.songs,
  });

  MySongsList copyWith({
    List<songdata>? songs,
  }) {
    return MySongsList(
      songs: songs ?? this.songs,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'songs': songs.map((x) => x.toMap()).toList(),
    };
  }

  factory MySongsList.fromMap(Map<String, dynamic> map) {
    return MySongsList(
      songs: List<songdata>.from((map['songs'] as List<dynamic>).map<songdata>((x) => songdata.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory MySongsList.fromJson(String source) => MySongsList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MySongsList(songs: $songs)';

  @override
  bool operator ==(covariant MySongsList other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return 
      listEquals(other.songs, songs);
  }

  @override
  int get hashCode => songs.hashCode;
}

class songdata {
  final int id;
  final String name;
  final String image;
  songdata({
    required this.id,
    required this.name,
    required this.image,
  });

  songdata copyWith({
    int? id,
    String? name,
    String? image,
  }) {
    return songdata(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
    };
  }

  factory songdata.fromMap(Map<String, dynamic> map) {
    return songdata(
      id: map['id'] as int,
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory songdata.fromJson(String source) =>
      songdata.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'songdata(id: $id, name: $name, image: $image)';

  @override
  bool operator ==(covariant songdata other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.image == image;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ image.hashCode;
}
