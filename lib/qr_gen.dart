import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:userqrgenerator/texttoprovideriamge.dart';

class QRCodeGenerator extends StatefulWidget {
  final String name;

  const QRCodeGenerator({Key? key, required this.name}) : super(key: key);

  @override
  _QRCodeGeneratorState createState() => _QRCodeGeneratorState();
}

class _QRCodeGeneratorState extends State<QRCodeGenerator> {
  String imagePath = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             PrettyQr(
              // image: TextToImageProvider(text: '     abcpay ', textStyle: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold), height: 70, width: 100),
             image: const AssetImage("assets/abclogo.png"),
              typeNumber: 10,
              size: 300,
              data: 'https://forms.gle/PKbovLZKumo3HtqTA',
              errorCorrectLevel: QrErrorCorrectLevel.M,
              roundEdges: true,
            ),
            // const SizedBox(height: 20),
            // Text(
            //   widget.name,
            //   style: const TextStyle(fontSize: 24),
            // ),
          ],
        ),
      ),
    );
  }
}
