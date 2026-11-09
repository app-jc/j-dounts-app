import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';

class AppCachedImage extends StatelessWidget {
  const AppCachedImage({
    required this.source,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    super.key,
  });

  static const String fallbackAsset =
      'assets/images/placeholders/image_fallback.png';

  final String source;
  final BoxFit fit;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final trimmedSource = source.trim();
    final uri = Uri.tryParse(trimmedSource);
    if (uri == null) return _fallback();

    switch (uri.scheme.toLowerCase()) {
      case 'asset':
        final assetPath = trimmedSource
            .substring(trimmedSource.indexOf(':') + 1)
            .trim();
        if (assetPath.isEmpty) return _fallback();
        return Image.asset(
          assetPath,
          fit: fit,
          width: width,
          height: height,
          errorBuilder: (context, error, stackTrace) => _fallback(),
        );
      case 'https':
        if (uri.host.isEmpty) return _fallback();
        return CachedNetworkImage(
          imageUrl: uri.toString(),
          fit: fit,
          width: width,
          height: height,
          placeholder: (context, url) => _fallback(),
          errorWidget: (context, url, error) => _fallback(),
        );
      default:
        return _fallback();
    }
  }

  Widget _fallback() => Image.asset(
    fallbackAsset,
    fit: fit,
    width: width,
    height: height,
    errorBuilder: (context, error, stackTrace) =>
        SizedBox(width: width, height: height),
  );
}
