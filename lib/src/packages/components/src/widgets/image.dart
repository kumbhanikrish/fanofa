import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../resouces/resources.dart';

class ImageFromAsset extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit fit;
  final Color? color;
  final bool matchTextDirection;

  const ImageFromAsset(
    this.image, {
    this.height,
    this.width,
    this.color,
    this.fit = BoxFit.contain,
    this.matchTextDirection = true,
    super.key,
  });

  const ImageFromAsset.square(
    this.image, {
    double size = 24,
    this.color,
    this.fit = BoxFit.contain,
    this.matchTextDirection = true,
    super.key,
  })  : height = size,
        width = size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      fit: fit,
      color: color,
      width: width,
      height: height,
      matchTextDirection: matchTextDirection,
    );
  }
}

class SvgImageFromAsset extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit fit;
  final Color? color;
  final bool matchTextDirection;

  const SvgImageFromAsset(
    this.image, {
    this.height,
    this.width,
    this.color,
    this.fit = BoxFit.contain,
    this.matchTextDirection = true,
    super.key,
  });

  const SvgImageFromAsset.square(
    this.image, {
    double size = 24,
    this.color,
    this.fit = BoxFit.contain,
    this.matchTextDirection = true,
    super.key,
  })  : height = size,
        width = size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      image,
      fit: fit,
      color: color,
      width: width,
      height: height,
      matchTextDirection: matchTextDirection,
    );
  }
}

class SvgImageFromNetwork extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit fit;
  final Color? color;
  final bool matchTextDirection;

  const SvgImageFromNetwork(
    this.imageUrl, {
    this.height,
    this.width,
    this.color,
    this.fit = BoxFit.contain,
    this.matchTextDirection = true,
    super.key,
  });

  const SvgImageFromNetwork.square(
    this.imageUrl, {
    double size = 24,
    this.color,
    this.fit = BoxFit.contain,
    this.matchTextDirection = true,
    super.key,
  })  : height = size,
        width = size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.network(
      imageUrl,
      fit: fit,
      color: color,
      width: width,
      height: height,
      matchTextDirection: matchTextDirection,
    );
  }
}

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final String placeholder;
  final Widget? placeholderWidget;
  final double width;
  final double height;
  final BoxFit fit;
  final Color? color;
  final bool matchTextDirection;

  const CachedImage({
    required this.imageUrl,
    this.placeholder = "",
    this.placeholderWidget,
    this.width = 24,
    this.height = 24,
    this.fit = BoxFit.fill,
    this.color,
    this.matchTextDirection = true,
    super.key,
  }) : assert(placeholderWidget == null);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: imageUrl,
      placeholder: (context, url) =>
          placeholderWidget ??
          (placeholder.isEmpty
              ? const SizedBox.shrink()
              : const ImageFromAsset.square(
                  AppIcons.placeHolder,
                  fit: BoxFit.fill,
                )),
      errorWidget: (context, url, error) =>
          placeholderWidget ??
          (placeholder.isEmpty
              ? const SizedBox.shrink()
              : const ImageFromAsset.square(
                  AppIcons.placeHolder,
                  fit: BoxFit.fill,
                )),
      fit: fit,
      useOldImageOnUrlChange: false,
    );
  }
}
