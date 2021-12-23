import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ml_kit/src/camera_screen.dart';
import 'package:flutter_ml_kit/src/shape.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class BarcodeScannerView extends StatefulWidget {
  final List<CameraDescription> cameras;
  final ValueChanged<Barcode> onResult;

  const BarcodeScannerView(
      {Key? key, required this.cameras, required this.onResult})
      : super(key: key);

  @override
  _BarcodeScannerViewState createState() => _BarcodeScannerViewState();
}

class _BarcodeScannerViewState extends State<BarcodeScannerView> {
  BarcodeScanner barcodeScanner = GoogleMlKit.vision.barcodeScanner();

  bool isBusy = false;
  CustomPaint? customPaint;

  @override
  void dispose() {
    barcodeScanner.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CameraScreen(
          onImage: (inputImage) {
            processImage(inputImage);
          },
          cameras: widget.cameras,
        ),
        Container(
          decoration: const ShapeDecoration(
            shape: ScannerOverlayShape(
              borderColor: Colors.red,
              borderWidth: 3.0,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;
    final barcodes = await barcodeScanner.processImage(inputImage);
    if (barcodes.isNotEmpty) {
      widget.onResult(barcodes.first);
    } else {
      isBusy = false;
    }
  }
}
