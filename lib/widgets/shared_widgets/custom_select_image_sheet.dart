import 'package:flutter/material.dart';
import 'package:instagram_clone_app/resources/constants/colors/colors.dart';
import 'package:instagram_clone_app/resources/constants/constants.dart';
import 'package:instagram_clone_app/resources/constants/dimensions/dimensions.dart';
import 'package:instagram_clone_app/resources/constants/icons/icons.dart';

class CustomSelectImageSheet extends StatelessWidget {
  final Function() selectImageFromGallery;
  final Function() selectImageFromCamera;
  final String? imgUrl;
  const CustomSelectImageSheet(
      {super.key,
      required this.selectImageFromCamera,
      required this.selectImageFromGallery,
      required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: imgUrl == null 
          ? 200
          : 250,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.borderRadiusSmall),
          topRight: Radius.circular(AppDimensions.borderRadiusSmall),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            height: 5,
            width: 40,
            decoration: BoxDecoration(
              color: AppColors.secondaryTextColor,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          imgUrl == null 
          ? Container()
          : const SizedBox(height: 20),
          imgUrl == null 
          ? Container()
          : ClipRRect(
            borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
            child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: AppColors.bgColor,
                  borderRadius:
                      BorderRadius.circular(AppDimensions.borderRadiusLarge),
                ),
                child: imgUrl == ""
                    ? Image.asset(Constants.defaultImage)
                    : FittedBox(
                        fit: BoxFit.fill,
                        child: Image.network(imgUrl!),
                      )),
          ),
          const SizedBox(height: 10),
          imgUrl == null 
          ? Container()
          : Container(
            color: AppColors.primaryTextColor,
            height: 1,
            width: MediaQuery.of(context).size.width,
          ),
          const SizedBox(height: 10),
          ListTile(
            onTap: selectImageFromGallery,
            leading: Image.asset(AppIcons.galleryIcon),
            title: Text(
              "Choose from library",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          ListTile(
            onTap: selectImageFromCamera,
            leading: Image.asset(AppIcons.cameraIcon),
            title: Text(
              "Take photo",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
