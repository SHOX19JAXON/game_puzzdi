//
// import 'dart:math';
//
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: '15 Puzzle Game',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: FifteenPuzzle(),
//     );
//   }
// }
//
// class FifteenPuzzle extends StatefulWidget {
//   @override
//   _FifteenPuzzleState createState() => _FifteenPuzzleState();
// }
//
//
// class _FifteenPuzzleState extends State<FifteenPuzzle> {
//   List<int> _tiles = [];
//   int _emptyIndex = 15;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeBoard();
//   }
//
//   void _initializeBoard() {
//     _tiles = List.generate(15, (index) => index + 1);
//     _tiles.add(0);
//     _shuffleBoard();
//   }
//
//   void _shuffleBoard() {
//     final random = Random();
//     for (int i = 0; i < 1000; i++) {
//       int randomNumber = random.nextInt(4);
//       if (randomNumber == 0 && _emptyIndex - 4 >= 0) {
//         _swapTiles(_emptyIndex, _emptyIndex - 4);
//         _emptyIndex -= 4;
//       } else if (randomNumber == 1 && _emptyIndex + 4 <= 15) {
//         _swapTiles(_emptyIndex, _emptyIndex + 4);
//         _emptyIndex += 4;
//       } else if (randomNumber == 2 && _emptyIndex % 4 != 0) {
//         _swapTiles(_emptyIndex, _emptyIndex - 1);
//         _emptyIndex -= 1;
//       } else if (randomNumber == 3 && (_emptyIndex + 1) % 4 != 0) {
//         _swapTiles(_emptyIndex, _emptyIndex + 1);
//         _emptyIndex += 1;
//       }
//     }
//   }
//
//   void _swapTiles(int i, int j) {
//     setState(() {
//       int temp = _tiles[i];
//       _tiles[i] = _tiles[j];
//       _tiles[j] = temp;
//     });
//   }
//
//   void _moveTile(int index) {
//     if ((index - _emptyIndex == 1 && (index + 1) % 4 != 0) ||
//         (_emptyIndex - index == 1 && (_emptyIndex + 1) % 4 != 0) ||
//         index - _emptyIndex == 4 ||
//         _emptyIndex - index == 4) {
//       _swapTiles(index, _emptyIndex);
//       _emptyIndex = index;
//       _checkWin();
//     }
//   }
//
//   void _checkWin() {
//     bool win = true;
//     for (int i = 0; i < _tiles.length - 1; i++) {
//       if (_tiles[i] != i + 1) {
//         win = false;
//         break;
//       }
//     }
//     if (win) {
//       showDialog(
//         context: context,
//         builder: (_) => AlertDialog(
//           title: Text('Congratulations!'),
//           content: Text('You solved the puzzle!'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _initializeBoard();
//               },
//               child: Text('Play Again'),
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('15 Puzzle Game'),
//       ),
//       body: GridView.builder(
//         padding: const EdgeInsets.all(16),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 4,
//           mainAxisSpacing: 8,
//           crossAxisSpacing: 8,
//         ),
//         itemCount: 16,
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () => _moveTile(index),
//             child: Container(
//               color: _tiles[index] != 0 ? Colors.blue : Colors.grey[300],
//               child: Center(
//                 child: Text(
//                   _tiles[index] != 0 ? '${_tiles[index]}' : '',
//                   style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }


import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_puzzdi/screens/home_screen/home_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: '15-Puzzle',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomeScreen(),
        );
      },
    );
  }
}





