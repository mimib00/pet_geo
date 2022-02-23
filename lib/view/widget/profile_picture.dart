import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pet_geo/model/user_model.dart';

class ProfilePicture extends StatelessWidget {
  final Users user;
  final double height;
  final double width;
  const ProfilePicture({
    Key? key,
    required this.user,
    this.height = 47,
    this.width = 47,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = user.photoUrl.isEmpty
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
                imageUrl: user.photoUrl,
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
