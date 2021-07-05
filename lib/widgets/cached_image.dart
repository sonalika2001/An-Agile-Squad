import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

//caches the image uploaded and also beauties the way it is displayed
//a normal image from the image class would disappear when we scroll the list view of the chat messages and would take a while to load. Cached network image solves this problem.
class CachedImage extends StatelessWidget {
  final String url;

  CachedImage({
    @required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
          child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: CachedNetworkImage(
          imageUrl: url,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}