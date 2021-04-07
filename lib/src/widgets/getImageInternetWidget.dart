import 'package:appservicable/src/settings/responsiveSize.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget getImageInternetWidget(String url){
  return CachedNetworkImage(
        fit: BoxFit.fill,
        height: w(100),
        width: w(100),
        imageUrl: url,
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
              child: Container(
                  width: w(60),
                  height: w(60),
                  child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                  )),
            ),
        errorWidget: (context, url, error) {
          return Container(
            color: Colors.grey[300],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.portable_wifi_off, size: w(80), color: Colors.white),
                
              ],
            ),
          );
        });
}