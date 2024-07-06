import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );

    _initializeControllerFuture = _controller?.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    if (!_controller!.value.isInitialized) {
      return;
    }

    try {
      XFile image = await _controller!.takePicture();
      _showImageDialog(image.path);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _startVideoRecording() async {
    if (!_controller!.value.isInitialized) {
      return;
    }

    if (_controller!.value.isRecordingVideo) {
      return;
    }

    try {
      await _controller!.startVideoRecording();
      setState(() {
        isRecording = true;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _stopVideoRecording() async {
    if (!_controller!.value.isRecordingVideo) {
      return;
    }

    try {
      XFile videoFile = await _controller!.stopVideoRecording();
      setState(() {
        isRecording = false;
      });

      // Save the video to the gallery
      await GallerySaver.saveVideo(videoFile.path);

      File(videoFile.path).deleteSync();

      _showVideoDialog(videoFile.path);
    } catch (e) {
      print(e);
    }
  }

  void _showImageDialog(String path) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Image saved in gallery"),
          content: Image.file(File(path)),
        );
      },
    );
  }

  void _showVideoDialog(String path) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Vedio is saved in your gallery'),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_initializeControllerFuture == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Camera"),
        ),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                CameraPreview(_controller!),
                Positioned(
                  bottom: 30,
                  left: 120,
                  child: FloatingActionButton(
                    onPressed: _takePicture,
                    heroTag: 'takePicture',
                    child: Icon(Icons.camera),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  right: 120,
                  child: FloatingActionButton(
                    onPressed: isRecording
                        ? _stopVideoRecording
                        : _startVideoRecording,
                    heroTag: 'recordVideo',
                    child: Icon(isRecording ? Icons.stop : Icons.videocam),
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
