import 'package:flutter/material.dart';

class AnimatedWindowContainer extends StatefulWidget {
  final Widget child;
  final bool isVisible;
  final Duration duration;
  final VoidCallback? onAnimationComplete;

  const AnimatedWindowContainer({
    super.key,
    required this.child,
    required this.isVisible,
    this.duration = const Duration(milliseconds: 250),
    this.onAnimationComplete,
  });

  @override
  State<AnimatedWindowContainer> createState() =>
      _AnimatedWindowContainerState();
}

class _AnimatedWindowContainerState extends State<AnimatedWindowContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: widget.duration, vsync: this);

    // Scale animation - starts from 20% height, grows to 100%
    _scaleAnimation = Tween<double>(
      begin: 0.2,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Fade animation
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Slide animation - dropdown effect from top
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.8),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Start animation if visible
    if (widget.isVisible) {
      _controller.forward();
    }

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        widget.onAnimationComplete?.call();
      }
    });
  }

  @override
  void didUpdateWidget(AnimatedWindowContainer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isVisible != oldWidget.isVisible) {
      if (widget.isVisible) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scaleY: _scaleAnimation.value,
          alignment: Alignment.topCenter,
          child: Transform.translate(
            offset: Offset(0, _slideAnimation.value.dy * 100),
            child: Opacity(opacity: _fadeAnimation.value, child: widget.child),
          ),
        );
      },
    );
  }
}
