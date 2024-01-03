import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Text Recognition',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isPermissionGranted = false;
  
  late final Future<void> _future;

  @override
  void initState() {
    super.initState();
    _future = _requestCameraPremission();
  }

  Future<void> _requestCameraPremission() async{
    final status = await Permission.camera.request();
    _isPermissionGranted = status == PermissionStatus.granted;
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future, 
      builder: (context, snapshot){
        return Scaffold(
          appBar: AppBar(title: const Text('Text Recognition Sample')),
          body: Center(
            child: Container(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Text(
                _isPermissionGranted ? 'Camera permission garanted' : 'Camera permision denied',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      }
    );
  }
}