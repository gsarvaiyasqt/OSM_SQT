
import 'package:flutter/material.dart';

class SkeletonView extends StatelessWidget {
  const SkeletonView({super.key, this.child, this.skeletonBody, this.radius, this.isLoading, this.borderRadius});
  final Widget? child;
  final Widget? skeletonBody;
  final double? radius;
  final bool? isLoading;
  final BorderRadiusGeometry? borderRadius;
  @override
  Widget build(BuildContext context) {

    if(isLoading == true) {
      return Skeleton(
          skeletonBody: skeletonBody,
          radius: radius,
          isLoading: isLoading,
          borderRadius: borderRadius,
          child: child,
      );
    } else {
      if(child != null) {
        return child!;
      } else {
        return const SizedBox.shrink();
      }
    }

  }
}


class Skeleton extends StatefulWidget {
  final Widget? child;
  final Widget? skeletonBody;
  final double? radius;
  final bool? isLoading;
  final BorderRadiusGeometry? borderRadius;
  const Skeleton({Key? key, this.child, this.isLoading, this.radius, this.borderRadius, this.skeletonBody}) : super(key: key);

  @override
  createState() => SkeletonState();
}

class SkeletonState extends State<Skeleton> with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  Animation? gradientPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);
    if(widget.isLoading == true){
      gradientPosition = Tween<double>(begin: -3, end: 10,).animate(CurvedAnimation(parent: _controller!.view, curve: Curves.linear),
      )..addListener(() {
        setState(() {});
      });
      _controller?.repeat();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if(widget.isLoading == true) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(widget.radius ?? 0),
          gradient: LinearGradient(
            begin: Alignment(gradientPosition?.value ?? 0, 0),
            end: const Alignment(-1, 0),
            colors: [
              Colors.grey.shade200,
              Colors.grey.shade50,
              Colors.grey.shade200,
            ],
          ),
        ),
        child: Opacity(opacity: 0.0,child: widget.skeletonBody ?? widget.child),
      );
    } else {

      if(widget.child != null) {
        return widget.child!;
      } else {
        return const SizedBox.shrink();
      }

    }


  }
}



