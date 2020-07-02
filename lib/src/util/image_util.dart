import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class ImageUtil {
  static Widget loadCoverImage(String url, double height) {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/images/default_image.png',
      image: url,
      width: double.maxFinite,
      height: height ?? 230.0,
      fit: BoxFit.cover,
      alignment: Alignment.center,
    );
  }


  static Widget loadCoverImageDimen(String url, double width, double height) {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/images/default_image.png',
      image: url,
      width: width ,
      height: height,
      fit: BoxFit.cover,
      alignment: Alignment.center,
    );
  }



  static Widget loadDefaultImage() {
    return Image.asset(
      'assets/images/default_image.png',
      width: double.infinity,
      height:  230.0,
      fit: BoxFit.cover,
      alignment: Alignment.center,
    );
  }
}