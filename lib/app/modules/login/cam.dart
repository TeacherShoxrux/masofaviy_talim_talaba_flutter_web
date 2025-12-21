import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:ui_web' as ui_web;
class Cam extends StatefulWidget {
  const Cam({super.key});

  @override
  State<Cam> createState() => _CamState();
}

class _CamState extends State<Cam> {
  html.VideoElement? _video;

  html.MediaStream? _stream;
  bool _isRegistered = false;

  void initCamera()async {
    _video = html.VideoElement()
      ..autoplay = true
      ..muted = true
      ..style.objectFit = 'cover'
      ..style.width = '100%'
      ..style.height = '100%';

       _stream = await html.window.navigator.mediaDevices!
        .getUserMedia({'video': true});

    _video!.srcObject = _stream;
  }
  void registerView() {
    if (_isRegistered) return;

    ui_web.platformViewRegistry.registerViewFactory(
      'camera-view',
          (int viewId) => _video!,
    );

    _isRegistered = true;
  }
  void _disposeCamera() {
    if (_stream != null) {
      for (final track in _stream!.getTracks()) {
        track.stop();       }
      _stream = null;
    }

    if (_video != null) {
      _video!.srcObject = null;
      _video!.remove();
      _video = null;
    }
  }
  @override
  void initState() {
    super.initState();
    initCamera();
    registerView();
  }
  @override
  void dispose() {
    _disposeCamera();
    super.dispose();
  }
  @override
  void deactivate() {
    _disposeCamera();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
           decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.black,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: HtmlElementView(viewType: 'camera-view'),
      ),
    );
  }

}
