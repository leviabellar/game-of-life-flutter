import 'package:flutter/material.dart';

import 'cell_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game of Life',
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
  final Map<String, bool> cellStatus = {};
  final Map<String, bool> newCellStatus = {};
  static const List<List<int>> neighborLocation = [
    [-1, -1], [0, -1], [1, -1],
    [-1,  0],          [1,  0],
    [-1,  1], [0,  1], [1,  1],
  ];

  // This is to update the cell status one step
  void step() {
    // Finally let us update the cellStatus
    cellStatus.clear();
    setState(() {
      cellStatus.addAll(newCellStatus);
    });
    getNextCellsStatus();
  }

  // This is to get the next cell status
  void getNextCellsStatus() {
    // First let us list all the cells that needs update
    final Set<String> cellsToUpdate = {};
    for (final cell in cellStatus.keys) {
      cellsToUpdate.add(cell);
      for(final neighbor in neighborLocation) {
        final x = int.parse(cell.split(',')[0]) + neighbor[0];
        final y = int.parse(cell.split(',')[1]) + neighbor[1];
        cellsToUpdate.add('$x,$y');
      }
    }

    newCellStatus.clear();
    // Then let us decide the new status of each cell
    for (final cell in cellsToUpdate) {
      final x = int.parse(cell.split(',')[0]);
      final y = int.parse(cell.split(',')[1]);
      final aliveNeighbors = neighborLocation.fold(0, (count, neighbor) {
        final nx = x + neighbor[0];
        final ny = y + neighbor[1];
        return count + (cellStatus['$nx,$ny'] ?? false ? 1 : 0);
      });
      final alive = cellStatus[cell] ?? false;
      if (alive) {
        if (aliveNeighbors == 2 || aliveNeighbors == 3) {
          newCellStatus[cell] = true;
        } else {
          newCellStatus.remove(cell);
        }
      } else {
        if (aliveNeighbors == 3) {
          newCellStatus[cell] = true;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: CellBuilder(
                cellStatus: cellStatus,
                updateCellStatus: getNextCellsStatus,
              ),
            ),
            GestureDetector(
              onTap: step,
              child: const MouseRegion(
                cursor: SystemMouseCursors.click,
                child: SizedBox(
                  height: 80,
                  child: ColoredBox(
                    color: Colors.black,
                    child: Center(
                      child: Icon(Icons.skip_next_outlined, color: Colors.white,),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}