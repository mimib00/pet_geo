import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pet_geo/model/community_model.dart';
import 'package:pet_geo/model/user_model.dart';

class CommunityPicture extends StatelessWidget {
  final Community community;
  final double height;
  final double width;
  const CommunityPicture({
    Key? key,
    required this.community,
    this.height = 47,
    this.width = 47,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = community.photo.isEmpty
        ? ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              'assets/images/People PH.png',
              height: height,
              width: width,
              fit: BoxFit.cover,
            ),
          )
        : SizedBox(
            height: height,
            width: width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                imageUrl: community.photo,
                fit: BoxFit.cover,
                placeholder: (context, url) => ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/images/People PH.png',
                    height: height,
                    width: width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
    return child;
  }
}
/**
 * authController.user.value!.photoUrl.isEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/images/People PH.png',
                      height: 47,
                      width: 47,
                      fit: BoxFit.cover,
                    ),
                  )
                : SizedBox(
                    height: 47,
                    width: 47,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        imageUrl: authController.user.value!.photoUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            'assets/images/People PH.png',
                            height: 47,
                            width: 47,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
 */
