import 'dart:async';
import 'dart:ui';
import 'package:fluttertube/api.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fluttertube/models/video_model.dart';

class VideoBloc implements BlocBase {
  late Api api;
  late List<Video> videos;

  final StreamController<List<Video>> _videoController =
      StreamController<List<Video>>();

  final StreamController<String?> _searchController = StreamController<String?>();

  Sink get inSearch => _searchController.sink;

  Stream get outVideos => _videoController.stream;

  VideoBloc() {
    api = Api();
    _searchController.stream.listen(_search);
  }

  void _search(String? search) async {
    if (search != null) {
      _videoController.sink.add([]);
      videos = await api.search(search);
    } else {
      videos += await api.nextPage();
    }
    _videoController.sink.add(videos);
  }

  @override
  void addListener(VoidCallback listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    _videoController.close();
    _searchController.close();
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
