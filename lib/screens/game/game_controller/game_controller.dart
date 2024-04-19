

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/local/locol.dart';
import '../../game_record_histori/game_history.dart';
class GameController extends GetxController {
  List<int> squares = [];
  List<int> record = [];
  int emptyIndex = 15;
  RxInt timer = 0.obs;
  RxInt moves = 0.obs;

  bool isTrue = true;


  @override
  void onInit() {
    super.onInit();
    squares = List.generate(16, (index) => index);
    shuffle();
  }



  void shuffle() {
    squares.shuffle();
    emptyIndex = squares.indexOf(0);
    update();
  }
 sonlar (List son){
  son.sort();
}
  bool isGameFinished() {
    for (int i = 0; i < squares.length - 1; i++) {
      // if (squares[i] != i + 1) {
      //   return false;
      // }
      squares = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,0];
    }
    return true;
  }

  void moveSquare(BuildContext context,int index) {
    if ((index == emptyIndex - 1 && index % 4 != 3) ||
        (index == emptyIndex + 1 && index % 4 != 0) ||
        index == emptyIndex - 4 ||
        index == emptyIndex + 4) {
      moves++;

      squares[emptyIndex] = squares[index];
      squares[index] = 0;
      emptyIndex = index;
      update();
      if (isGameFinished()) {

        Get.snackbar(
          'Congratulations!',
          'You solved the puzzle!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        LocalDatabaseHelper().saveGameData(moves.value, timer.value);

        Get.dialog(
            AlertDialog(
              title: const Center(
                child: Text('Congratulations!',style: TextStyle(
                    color: Colors.green),),
              ),
              content: const Row(
                children: [
                  Spacer(),
                  Text('You solved the puzzle!',style: TextStyle(
                      color: Colors.blue),),
                  Spacer(),
                ],
              ),
              actions: [
               Row(
                 children: [
                   TextButton(
                     onPressed: () {
                       isTrue = true;
                       timerLogic();
                       shuffle();
                       Get.back();
                       moves.value= 0;
                     },
                     child: const Text('Play Again',style: TextStyle(
                         color: Colors.blue),),
                   ),
                   Spacer(),
                   TextButton(
                     onPressed: () {
                       Navigator.pushReplacement(context , MaterialPageRoute(builder: (context) {
                         return GameHistory();
                       }));
                     },
                     child: const Text('Tarix',style: TextStyle(
                         color: Colors.blue),),
                   ),
                 ],
               )
              ],
            ),
        );
        timer.value = 0 ;
        isTrue = false;
        moves.value= 0;


  }

    }
  }

  Future<void> timerLogic() async {
    while (isTrue) {
      await Future.delayed(const Duration(seconds: 1));
      timer++;
      print("kirdi");
    }
  }

  getMinutelyText(int datetime) {
    int min = datetime ~/ 60;
    int sec = datetime % 60;

    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";

    return "$minute : $second";
  }

}