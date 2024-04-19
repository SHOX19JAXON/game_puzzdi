// import 'package:flutter/material.dart';
// import 'package:game_puzzdi/utils/size_utils.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_state_manager/src/simple/get_state.dart';
//
// import '../../../main.dart';
// import '../game_controller/game_controller.dart';
// class GameScreen extends StatelessWidget {
//   final GameController controller = Get.put(GameController());
//
//   @override
//   Widget build(BuildContext context) {
//     width = MediaQuery.of(context).size.width;
//     height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(title: Text('15-Puzzle')),
//       body: Column(
//         children: [
//           Container(
//             width: double.infinity,
//             height: 100,
//             color: Colors.red,
//             child: Column(
//               children: [
//               Padding(
//                 padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
//                 child: Row(
//                   children: [
//                     Text("Timer"),
//                     SizedBox(width: 20.w,),
//                     Text("Timer"),
//                   ],
//                 ),
//               ),
//                 SizedBox(height: 20.h,),
//                 Padding(
//                   padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
//                   child: Row(
//                     children: [
//                       Text("Moves"),
//                       SizedBox(width: 20.w,),
//                       Text("Moves"),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 10.h,),
//           Expanded(
//             child: GetBuilder<GameController>(
//               builder: (controller) {
//                 return GridView.builder(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 4,
//                     crossAxisSpacing: 4.0,
//                     mainAxisSpacing: 4.0,
//                   ),
//                   itemCount: controller.squares.length,
//                   itemBuilder: (context, index) {
//                     return GestureDetector(
//                       onTap: () {
//                         controller.moveSquare(index);
//                       },
//                       child: Container(
//                         color: controller.squares[index] == 0
//                             ? Colors.grey
//                             : Colors.blue,
//                         alignment: Alignment.center,
//                         child: Text(
//                           controller.squares[index] != 0
//                               ? '${controller.squares[index]}'
//                               : '',
//                           style: TextStyle(
//                             fontSize: 24.0,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           controller.shuffle();
//         },
//         child: Icon(Icons.shuffle),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:game_puzzdi/utils/size_utils.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';


import '../game_controller/game_controller.dart';

class GameScreen extends StatefulWidget {
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final GameController controller = Get.put(GameController());

  @override
  void initState() {
    controller.timerLogic();
    super.initState();
    print("kirdi aaaaa");
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(

      appBar: AppBar(title: Text('15 Puzzle game'),
      ),
      body: Obx(
        () => Column(
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blue
                ),
                width: double.infinity,
                height: 100.h,

                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         Icon(Icons.timer,color: Colors.white,),SizedBox(width: 10.w,),
                          Text(
                            "Timer: ${controller.getMinutelyText(controller.timer.value)}",
                            style: TextStyle(fontSize: 20,color: Colors.white),
                          ),

                        ],
                      ),

                    ),
                    Spacer(),

                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Icon(Icons.move_down,color:  Colors.white,),SizedBox(width: 10.w,),
                          Text(
                            "Moves: ${controller.moves.value}",
                            style: TextStyle(fontSize: 20,color: Colors.white),
                          )
                        ],
                      ),

                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 80.h),

            Expanded(
              child: GetBuilder<GameController>(
                builder: (controller) {
                  return Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                      ),
                      itemCount: controller.squares.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            controller.record.add(controller.moves.value);
                            controller.moveSquare(context, index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: controller.squares[index] == 0
                                  ? Colors.blue.withOpacity(0.4)
                                  : Colors.blue,
                            ),
                          
                            alignment: Alignment.center,
                            child: Text(
                              controller.squares[index] != 0
                                  ? '${controller.squares[index]}'
                                  : '',
                              style: const TextStyle(
                                fontSize: 24.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            // SizedBox(height: 20,),
            // SizedBox(height: 20,),
            TextButton(onPressed: (){
              // print(minTimer);
              controller.squares = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,0];
              controller.moveSquare(context, 5);
              // controller.sonlar(controller.squares);
            }, child: Text("GOLIB"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.shuffle();
        },
        child: Icon(Icons.shuffle),
      ),
    );
  }
}
