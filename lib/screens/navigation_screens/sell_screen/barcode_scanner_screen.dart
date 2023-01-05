
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class BarcodeScanner extends StatelessWidget {

  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');

  late QRViewController _qrViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QRView(
        key: _qrKey,
        onQRViewCreated: (controller){

          _qrViewController = controller;

          _qrViewController.scannedDataStream.listen((event) {
            if(event != null && event.code!.isNotEmpty){
              _qrViewController.stopCamera();
              log(event.code!);
              Navigator.pop(context, event.code);
            }
          });

        },
      ),
    );
  }
}
