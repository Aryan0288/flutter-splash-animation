import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// SinglePlayGif is a premium utility widget that frame-by-frame decodes
/// a GIF asset and plays it exactly once, stopping and freezing on the final frame
/// to provide seamless celebration poppers and layout effects.
class SinglePlayGif extends StatefulWidget {
  final String assetPath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;
  final VoidCallback? onLoaded;

  const SinglePlayGif({
    Key? key,
    required this.assetPath,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.errorBuilder,
    this.onLoaded,
  }) : super(key: key);

  @override
  State<SinglePlayGif> createState() => _SinglePlayGifState();
}

class _SinglePlayGifState extends State<SinglePlayGif> {
  List<ui.FrameInfo> _frames = [];
  int _currentFrameIndex = 0;
  bool _loaded = false;
  bool _hasError = false;
  Object? _error;
  StackTrace? _stackTrace;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadGif();
  }

  Future<void> _loadGif() async {
    try {
      final ByteData data = await rootBundle.load(widget.assetPath);
      final Uint8List bytes = data.buffer.asUint8List();
      final ui.Codec codec = await ui.instantiateImageCodec(bytes);

      final List<ui.FrameInfo> frames = [];
      for (int i = 0; i < codec.frameCount; i++) {
        final ui.FrameInfo frameInfo = await codec.getNextFrame();
        frames.add(frameInfo);
      }

      if (mounted && frames.isNotEmpty) {
        setState(() {
          _frames = frames;
          _loaded = true;
        });
        if (widget.onLoaded != null) {
          widget.onLoaded!();
        }
        _playNextFrame();
      }
    } catch (e, stack) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _error = e;
          _stackTrace = stack;
        });
      }
    }
  }

  void _playNextFrame() {
    if (!mounted || _frames.isEmpty) return;

    final currentFrame = _frames[_currentFrameIndex];

    _timer = Timer(currentFrame.duration, () {
      if (!mounted) return;
      if (_currentFrameIndex < _frames.length - 1) {
        setState(() {
          _currentFrameIndex++;
        });
        _playNextFrame();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError && widget.errorBuilder != null) {
      return widget.errorBuilder!(context, _error!, _stackTrace);
    }

    if (!_loaded || _frames.isEmpty) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: Image.asset(
          widget.assetPath,
          fit: widget.fit,
        ),
      );
    }

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: RawImage(
        image: _frames[_currentFrameIndex].image,
        fit: widget.fit,
      ),
    );
  }
}
