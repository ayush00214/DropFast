import 'dart:developer';
import 'dart:io';
import 'package:drop_fast/routes.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({super.key});

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  bool _isProcessing = false; // prevent multiple navigation

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // QR Scanner
          _buildQrView(context),

          // Top instructions
          Positioned(
            top: 60,
            left: 20,
            right: 20,
            child: Column(
              children: const [
                Text(
                  "Scan QR Code",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Place the QR code inside the frame to scan",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Flash & Flip buttons
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildControlButton(
                  icon: Icons.flash_on,
                  label: 'Flash',
                  onPressed: () async {
                    await controller?.toggleFlash();
                    setState(() {});
                  },
                  future: controller?.getFlashStatus(),
                ),
                _buildControlButton(
                  icon: Icons.cameraswitch,
                  label: 'Flip',
                  onPressed: () async {
                    await controller?.flipCamera();
                    setState(() {});
                  },
                  future: controller?.getCameraInfo(),
                  isCamera: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Future? future,
    bool isCamera = false,
  }) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white24,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
            );
          }

          String text = label;

          if (isCamera && snapshot.data != null) {
            text = _getCameraName(snapshot.data);
          } else if (!isCamera && snapshot.data != null) {
            text = 'Flash: ${snapshot.data}';
          }

          // Wrap in Flexible to avoid RenderFlex overflow
          return Flexible(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }

  String _getCameraName(CameraFacing? camera) {
    switch (camera) {
      case CameraFacing.front:
        return 'Front Camera';
      case CameraFacing.back:
        return 'Back Camera';
      default:
        return 'Unknown';
    }
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 300.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.tealAccent,
        borderRadius: 16,
        borderLength: 40,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) async {
      if (_isProcessing) return; // prevent double navigation
      setState(() {
        result = scanData;
        _isProcessing = true;
      });

      // navigate to UploadSuccessScreen
      if (mounted) {
        Navigator.pushReplacementNamed(
          context,
          AppRoute.uploadsuccesspage,
          arguments: result?.code,
        );
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Camera permission denied')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
