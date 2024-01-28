import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:frontend/data/data.dart';
import 'package:frontend/extensions/extensions.dart';

class CarouselCard extends StatelessWidget {
  const CarouselCard({
    super.key,
    this.fit,
    this.onTap,
    required this.child,
  });

  final BoxFit? fit;
  final VoidCallback? onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: child,
      ),
    );
  }
}

class CarouselSliderController extends PageController {
  CarouselSliderController({super.initialPage, super.keepPage})
      : super(viewportFraction: 0.7);

  int get index =>
      hasClients ? super.page?.round() ?? initialPage : initialPage;
}

class CarouselSlider extends StatefulWidget {
  const CarouselSlider({
    super.key,
    this.controller,
    this.slideAfter,
    this.repeats = true,
    this.slideDuration,
    this.slideCurve,
    this.onPageChanged,
    required this.children,
  });

  const CarouselSlider.autoSlide({
    super.key,
    this.controller,
    required Duration this.slideAfter,
    this.repeats = true,
    this.slideDuration,
    this.slideCurve,
    this.onPageChanged,
    required this.children,
  });

  const CarouselSlider.noAutoSlide({
    super.key,
    this.controller,
    this.slideDuration,
    this.slideCurve,
    this.onPageChanged,
    required this.children,
  })  : slideAfter = null,
        repeats = false;

  final CarouselSliderController? controller;

  /// Enables auto sliding. If null, no auto-slide will be present.
  final Duration? slideAfter;

  /// Whether the carousel repeats after reaching the end.
  final bool repeats;

  /// The slide duration for the carousel.
  ///
  /// Defaults to [defaultSlideDuration].
  final Duration? slideDuration;

  /// The slide curve for the carousel.
  ///
  /// Defaults to [defaultSlideCurve].
  final Curve? slideCurve;

  final ValueChanged<int>? onPageChanged;

  final List<Widget> children;

  static const defaultSlideDuration = Duration(milliseconds: 350);
  static const defaultSlideCurve = Curves.easeInOut;

  @override
  State<CarouselSlider> createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<CarouselSlider> {
  Timer? _timer;
  late int _currentIndex;
  final _controller = CarouselSliderController();

  CarouselSliderController get _effectiveController =>
      widget.controller ?? _controller;
  Duration get _slideDuration =>
      widget.slideDuration ?? CarouselSlider.defaultSlideDuration;
  Curve get _slideCurve => CarouselSlider.defaultSlideCurve;

  @override
  void initState() {
    super.initState();
    _setupCurrentIndex();
    _setupTimer();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CarouselSlider oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.slideAfter != widget.slideAfter) {
      _setupTimer();
    }
  }

  void _setupCurrentIndex() {
    _currentIndex = _effectiveController.index;
  }

  void _setupTimer() {
    final slideAfter = widget.slideAfter;
    if (slideAfter == null) {
      _timer?.cancel();
      return;
    }

    _timer?.cancel();
    _timer = Timer.periodic(slideAfter, (_) => _slideToNext());
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _effectiveController,
      onPageChanged: (index) {
        widget.onPageChanged?.call(index);

        // Reset timer if user moved it manually
        _setupTimer();
        setState(() => _currentIndex = index);
      },
      children: widget.children
          .mapIndexed(
            (index, e) => AnimatedContainer(
              duration: _slideDuration,
              curve: _slideCurve,
              padding: _currentIndex == index
                  ? EdgeInsets.zero
                  : const EdgeInsets.symmetric(horizontal: 28, vertical: 28),
              child: e,
            ),
          )
          .toList(),
    );
  }

  void _slideToNext() {
    if (_currentIndex == widget.children.length - 1) {
      _effectiveController.animateToPage(
        0,
        duration: _slideDuration,
        curve: _slideCurve,
      );
    } else {
      _effectiveController.nextPage(
        duration: _slideDuration,
        curve: _slideCurve,
      );
    }
  }
}

class CarouselSliderIndicator extends StatelessWidget {
  const CarouselSliderIndicator({
    super.key,
    required this.length,
    required this.currentIndex,
    this.slideDuration,
    this.slideCurve,
  });

  final int length;
  final int currentIndex;

  /// The sliding duration of the indicators.
  ///
  /// Defaults to [CarouselSlider.defaultSlideDuration].
  final Duration? slideDuration;

  /// The sliding curve of the indicators.
  ///
  /// Defaults to [CarouselSlider.defaultSlideCurve].
  final Curve? slideCurve;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (var i = 0; i < length; i++)
          AnimatedContainer(
            duration: slideDuration ?? CarouselSlider.defaultSlideDuration,
            curve: slideCurve ?? CarouselSlider.defaultSlideCurve,
            decoration: BoxDecoration(
              color: currentIndex == i
                  ? AppColors.purplePrimary
                  : AppColors.greyLighter,
              borderRadius: BorderRadius.circular(4),
            ),
            width: currentIndex == i ? 24 : 8,
            height: 8,
          )
      ].separated((_) => const SizedBox(width: 8)),
    );
  }
}
