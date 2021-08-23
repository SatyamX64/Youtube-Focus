import 'package:flutter/material.dart';
import 'package:youtube_focus/data/models/search/search_barrel.dart';
import 'package:youtube_focus/ui/app_router.dart';

class VideoItemCard extends StatelessWidget {
  VideoItemCard({
    required this.item,
    Key? key,
  })  : videoSnippet = item.snippet,
        super(key: key);

  final SearchItem item;
  final SearchSnippet videoSnippet;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  videoSnippet.thumbnails.high.url,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 5),
              Text(
                videoSnippet.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 5),
              // Text(
              //   videoSnippet.description,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
