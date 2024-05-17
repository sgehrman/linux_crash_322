import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Screenshot Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Screenshot(
              controller: screenshotController,
              child: Container(
                clipBehavior: Clip.antiAlias,
                padding: const EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent, width: 5.0),
                  color: Colors.amberAccent,
                  // =============================================
                  // NOTE: BorderRadius makes it crash on Linux, comment out and it won't crash
                  // Flutter 3.22 has serious crashing bugs on linux
                  borderRadius: BorderRadius.circular(15),
                  // =============================================
                ),
                child: Image.asset(
                  'assets/images/flutter.png',
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              child: const Text(
                'Capture',
              ),
              onPressed: () {
                screenshotController
                    .capture(delay: const Duration(milliseconds: 10))
                    .then((capturedImage) async {
                  print(capturedImage?.length);
                }).catchError((onError) {
                  print(onError);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
