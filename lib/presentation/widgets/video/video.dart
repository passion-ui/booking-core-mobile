import 'package:booking/presentation/presentation.dart';
import 'package:flutter/scheduler.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  final String url;
  final String? preview;

  const Video({
    super.key,
    required this.url,
    this.preview,
  });

  @override
  createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late VideoPlayerController _controller;
  bool _usePreview = false;
  bool _showControls = true;
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.url),
    );
    _usePreview = widget.preview != null;
    _controller.initialize();
    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        setState(() {
          _controller.pause();
        });
      }
    });
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _hideControls();
    });
  }

  void _hideControls() {
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
    if (_showControls) {
      _hideControls();
    }
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      _controller.setVolume(_isMuted ? 0 : 1);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAction() {
    if (_usePreview) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(
              Icons.play_arrow,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _usePreview = false;
              });
              _togglePlayPause();
            },
          ),
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            color: Colors.white,
          ),
          onPressed: _togglePlayPause,
        ),
        IconButton(
          icon: Icon(
            _isMuted ? Icons.volume_off : Icons.volume_up,
            color: Colors.white,
          ),
          onPressed: _toggleMute,
        ),
        IconButton(
          icon: Icon(
            Icons.visibility_off_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              _usePreview = true;
            });
            _togglePlayPause();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleControls,
      child: Stack(
        alignment: Alignment.center,
        children: [
          VideoPlayer(_controller),
          if (_usePreview)
            Positioned.fill(
              child: CachedImage(
                url: widget.preview!,
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedOpacity(
                opacity: _showControls ? 1.0 : 0.0,
                duration: Duration(seconds: 1),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.black26,
                  ),
                  child: _buildAction(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
