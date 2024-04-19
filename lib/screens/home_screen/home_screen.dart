import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../game/view/game_puzzle.dart';
import '../game_record_histori/game_history.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (context){
                return GameScreen();
              }));
            }, child: const Text("Start",)),
             SizedBox(height: 20.h,),
            TextButton(
                onPressed: () async {

                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return GameHistory();
                  }));
                },
                child: Text("Tarix")),
          ],
        ),
      ),
    );
  }
}

