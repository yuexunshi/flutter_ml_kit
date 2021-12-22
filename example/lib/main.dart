import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ml_kit/flutter_ml_kit.dart';

List<CameraDescription> cameras = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('appbarTitle'),
      ),
      body: Column(children: <Widget>[
        ElevatedButton(
          onPressed: () async {
            final barcode = await Navigator.of(context).push<Barcode>(
              MaterialPageRoute(
                builder: (c) {
                  return const ScanPage();
                },
              ),
            );
            debugPrint('=======Home.build:${barcode?.value.displayValue}');
            if (barcode == null) {
              return;
            }
          },
          child: Text('Scan product'),
        ),
      ]),
    );
  }
}

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BarcodeScannerView(
        cameras: cameras,
        onResult: (Barcode value) {
          Navigator.of(context).pop<Barcode>(value);
        },
      ),
    );
    ;
  }
}
