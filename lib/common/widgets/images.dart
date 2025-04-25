import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../colors.dart';

class AppImage extends StatelessWidget {
  const AppImage.asset({
    super.key,
    required this.asset,
    this.url,
    this.width = 0,
    this.height = 0,
    this.fit = BoxFit.cover,
    this.borderRadius = BorderRadius.zero,
    this.color,
    this.alignment,
    this.cached = true,
    this.gaplessPlayback = false,
    this.errorBuilder,
  });

  const AppImage.network({
    super.key,
    required this.url,
    this.asset,
    this.width = 0,
    this.height = 0,
    this.fit = BoxFit.cover,
    this.borderRadius = BorderRadius.zero,
    this.color,
    this.alignment,
    this.cached = true,
    this.gaplessPlayback = false,
    this.errorBuilder,
  });

  /// Source
  final String? url;
  final String? asset;

  /// Properties
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius borderRadius;
  final Color? color;
  final AlignmentGeometry? alignment;
  final bool cached;
  final bool gaplessPlayback;
  final Widget Function()? errorBuilder;

  @override
  Widget build(BuildContext context) {
    if (url != null) {
      return _buildNetwork();
    }
    if (asset != null) {
      return _buildAsset();
    }
    return const SizedBox();
  }

  _buildAsset() {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.asset(
        "assets/images/$asset.png",
        height: height == 0 ? null : height,
        width: width == 0 ? null : width,
        fit: fit,
        color: color,
        alignment: alignment ?? Alignment.center,
        errorBuilder: (_, __, ___) {
          return Container(
            height: height == 0 ? null : height,
            width: width == 0 ? null : width,
            decoration: BoxDecoration(borderRadius: borderRadius),
          );
        },
      ),
    );
  }

  _buildNetwork() {
    final String url = this.url!.trim();
    if (url.isEmpty) {
      if (errorBuilder != null) {
        return errorBuilder!();
      }
      return Container(
        height: height == 0 ? null : height,
        width: width == 0 ? null : width,
        decoration: BoxDecoration(borderRadius: borderRadius),
      );
    }
    if (cached == true) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: CachedNetworkImage(
          fadeInDuration: const Duration(milliseconds: 400),
          imageUrl: url,
          height: height == 0 ? null : height,
          width: width == 0 ? null : width,
          fit: fit,
          color: color,
          placeholder: (BuildContext context, String url) {
            return Center(
              child: SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(UIColors.primaryColor),
                  strokeWidth: 2,
                ),
              ),
            );
          },
          errorWidget: (BuildContext context, String url, _) {
            if (errorBuilder != null) {
              return errorBuilder!();
            }
            return Container(
              height: height == 0 ? null : height,
              width: width == 0 ? null : width,
              decoration: BoxDecoration(borderRadius: borderRadius),
            );
          },
        ),
      );
    }
    return ClipRRect(
      borderRadius: borderRadius,
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: url,
        height: height == 0 ? null : height,
        width: width == 0 ? null : width,
        fit: fit,
      ),
    );
  }
}
