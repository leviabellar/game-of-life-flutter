import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: InteractiveViewer.builder(
                boundaryMargin: const EdgeInsets.all(double.infinity),
                builder: (context, viewport) {
                  final List<Widget> cells = [];
                  final height = viewport.point3.y - viewport.point0.y;
                  final width = viewport.point1.x - viewport.point0.x;
                  for (var i = 0; i < (height / 30).ceil(); i++) {
                    for (var j = 0; j < (width / 30).ceil(); j++) {
                      cells.add(
                        Positioned(
                          left: ((viewport.point0.x/30).floor() + j) * 30.0, // -5 + 0 = -30
                          top: ((viewport.point0.y/30).floor() + i) * 30.0,
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: ColoredBox(
                              color: Colors.white,
                              child: Center(
                                child: Text('${((viewport.point0.x/30).floor() + j)}', style: const TextStyle(fontSize: 8),),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  }
                  return SizedBox(
                    height: 1,
                    width: 1,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: cells,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 100,
              child: ColoredBox(
                color: Colors.black,
                child: Center(
                  child: Text('This is a black box'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
