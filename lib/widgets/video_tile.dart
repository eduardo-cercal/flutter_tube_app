import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertube/blocs/favorite_bloc.dart';
import 'package:fluttertube/models/video_model.dart';

class VideoTile extends StatelessWidget {
  final Video video;

  const VideoTile(this.video, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              video.thumb,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        video.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(video.channel,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          )),
                    ),
                  ],
                ),
              ),
              StreamBuilder<Map<String, Video>>(
                  initialData:{},
                  stream: BlocProvider
                      .getBloc<FavoriteBloc>()
                      .outFav,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return IconButton(
                        onPressed: () {
                          BlocProvider.getBloc<FavoriteBloc>().toggleFavorite(
                              video);
                        },
                        icon: Icon(snapshot.data!.containsKey(video.id)
                            ? Icons.star
                            : Icons.star_border),
                        color: Colors.white,
                        iconSize: 30,
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  })
            ],
          ),
        ],
      ),
    );
  }
}
