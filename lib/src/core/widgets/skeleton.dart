import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({super.key, this.height = 18, this.width = double.infinity});

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).colorScheme.surfaceContainerHighest;
    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: base.withValues(alpha: .35),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(color: base, borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
