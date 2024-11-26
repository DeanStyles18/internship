import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:shimmer_animation/shimmer_animation.dart';

import 'app_colors.dart';

class AppContents {
  static Widget placeHolderImage(
      {String? imageURl,
      double? height,
      double? width,
      double? topRadius,
      double? rightRadius,
      double? bottomRadius,
      double? bottomRightRidus}) {
    return Container(
      height: height,
      child: CachedNetworkImage(
        imageUrl: imageURl!,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(topRadius!),
              topRight: Radius.circular(rightRadius!),
              bottomRight: Radius.circular(bottomRightRidus!),
              bottomLeft: Radius.circular(bottomRadius!),
            ),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => Shimmer(
          duration: const Duration(seconds: 2),
          enabled: true,
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(topRadius!),
                  topRight: Radius.circular(rightRadius!),
                  bottomRight: Radius.circular(bottomRightRidus!),
                  bottomLeft: Radius.circular(bottomRadius!),
                ),
                color: Colors.black.withOpacity(0.4),
              )),
        ),
        errorWidget: (context, url, error) => Shimmer(
          duration: const Duration(seconds: 2),
          enabled: true,
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(topRadius!),
                  topRight: Radius.circular(rightRadius!),
                  bottomRight: Radius.circular(bottomRightRidus!),
                  bottomLeft: Radius.circular(bottomRadius!),
                ),
                color: Colors.black.withOpacity(0.4),
              )),
        ),
      ),
    );
  }

  static Widget AppBarImage() {
    return SvgPicture.asset(
      'assets/icon.svg',
      height: 25,
    );
  }

  static Widget backFunctionWidget(BuildContext context) {
    return SafeArea(
      child: InkWell(
        onTap: () {
          print("click");
          Navigator.pop(context);
        },
        child: Container(
          height: 40,
          width: 40,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Colors.white.withOpacity(0.3)),
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  static Widget videoWidget(
      BuildContext context,
      String videosFinalDataId,
      Color randomColor,
      String image,
      String videoTitle,
      String videoDuration,
      onTap) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: randomColor),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Stack(
            children: [
              // The image part
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
                height: 180.0,
              ),
              Container(
                height: 190.0,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.7),
                      Colors.black.withOpacity(0.9),
                    ],
                        stops: [
                      0.0,
                      0.4,
                      0.6,
                      0.8
                    ])),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 4.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 9,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    videoTitle ?? 'Unknown Title',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14.0),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.access_time,
                                          size: 10, color: Colors.white),
                                      SizedBox(width: 4),
                                      Text(
                                        videoDuration ?? 'Unknown Duration',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 12.0),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 4),
                                child: CircleAvatar(
                                  backgroundColor: AppColors.primaryColor,
                                  child: Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                  radius: 15,
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
