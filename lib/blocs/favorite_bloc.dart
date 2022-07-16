import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fluttertube/models/video_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteBloc implements BlocBase {
  Map<String, Video> favorites = {};

  final favController = BehaviorSubject<Map<String, Video>>();

  Stream<Map<String, Video>> get outFav => favController.stream;

  FavoriteBloc() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getKeys().contains("favorites")) {
        String? fav = prefs.getString("favorites");
        favorites = json.decode(fav!).map((k, v) {
          return MapEntry(k, Video.fromJson(v));
        }).cast<String, Video>();
        favController.add(favorites);
      }
    });
  }

  void toggleFavorite(Video video) {
    if (favorites.containsKey(video.id)) {
      favorites.remove(video.id);
    } else {
      favorites[video.id] = video;
    }
    favController.sink.add(favorites);

    saveFav();
  }

  void saveFav() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("favorites", json.encode(favorites));
    });
  }

  @override
  void addListener(VoidCallback listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    favController.close();
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(VoidCallback listener) {
    // TODO: implement removeListener
  }
}
