import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/local/locol.dart';

class GameHistory extends StatefulWidget {
  const GameHistory({super.key});

  @override
  State<GameHistory> createState() => _GameHistoryState();
}

class _GameHistoryState extends State<GameHistory> {
  late int? minMoves = 0;

  // late String? minTime = "";
  late int? minTime = 0;

  @override
  void initState() {
    super.initState();
    _loadMinMoves();
    _loadMinTimer();
  }

  Future<void> _loadMinMoves() async {
    final List<Map<String, dynamic>> minMovesData =
        await LocalDatabaseHelper().getGameDataWithMinMoves();
    if (minMovesData.isNotEmpty) {
      setState(() {
        minMoves = minMovesData.first['moves'] as int;
      });
    }
  }

  Future<void> _loadMinTimer() async {
    final List<Map<String, dynamic>> minTimerData =
        await LocalDatabaseHelper().getGameDataWithMinTime();
    if (minTimerData.isNotEmpty) {
      setState(() {
        minTime = int.parse(minTimerData.first['timer'].toString());
        minMoves = int.parse(minTimerData.first['moves'].toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Game History"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.green),
              child: Row(
                children: [
                  const Icon(Icons.recommend_rounded, color: Colors.white),
                  Text(
                      "Record Move: ${minMoves ?? 'No game history available'}"),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.green),
              child: Row(
                children: [
                  const Icon(Icons.recommend_rounded, color: Colors.white),
                  Text(
                      "Record Time: ${getMinutelyText(minTime!) ?? 'No game history available'}"),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: LocalDatabaseHelper().getAllGameData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                } else {
                  final List<Map<String, dynamic>>? gameDataList =
                      snapshot.data;
                  if (gameDataList != null && gameDataList.isNotEmpty) {
                    return ListView.builder(
                      itemCount: gameDataList.length,
                      itemBuilder: (context, index) {
                        final gameData = GameData.fromMap(gameDataList[index]);
                        return ListTile(
                          leading: Text("${index + 1}",
                              style:
                                  TextStyle(fontSize: ScreenUtil().setSp(20))),
                          title: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(10),
                                vertical: ScreenUtil().setHeight(5)),
                            height: ScreenUtil().setHeight(50),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  ScreenUtil().setWidth(15)),
                              color: Colors.blue,
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.move_down,
                                    color: Colors.white),
                                SizedBox(width: ScreenUtil().setWidth(10)),
                                Text("Move: ${gameData.moves}"),
                                // Spacer(),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.timer,
                                        color: Colors.white),
                                    SizedBox(width: 8.w),
                                    // Spacer(),
                                    SizedBox(width: ScreenUtil().setWidth(10)),
                                    Text(
                                        "Timer: ${getMinutelyText(gameData.timer)}"),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text("No game history available."),
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

getMinutelyText(int datetime) {
  int min = datetime ~/ 60;
  int sec = datetime % 60;

  String minute = min.toString().length <= 1 ? "0$min" : "$min";
  String second = sec.toString().length <= 1 ? "0$sec" : "$sec";

  return "$minute : $second";
}
