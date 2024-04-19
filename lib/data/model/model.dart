
import '../../utils/constants/app_constants.dart';

// class PuzzleModel {
//   PuzzleModel({required this.count, required this.dateTime, this.id});
//
//   int? id;
//   final int count;
//   final int dateTime;
//
//   factory PuzzleModel.fromJson(Map<String, dynamic> json) {
//     return PuzzleModel(
//       id: json["_id"],
//       count: json["count"] as int? ?? 0,
//       dateTime: json["datetime"] as int? ?? 0,
//     );
//   }
//
//   PuzzleModel copyWith({
//     int? id,
//     int? count,
//     int? dateTime,
//   }) {
//     return PuzzleModel(
//       id: id ?? this.id,
//       count: count ?? this.count,
//       dateTime: dateTime ?? this.dateTime,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       AppConstants.count: count,
//       AppConstants.datetime: dateTime,
//     };
//   }
//
//   Map<String, dynamic> toUpdateJson() {
//     return {
//       AppConstants.id: id,
//       AppConstants.count: count,
//       AppConstants.datetime: dateTime,
//     };
//   }
// }

class GameData {
  final int? id;
  final int moves;
  final int timer;

  GameData({this.id, required this.moves, required this.timer});

  factory GameData.fromMap(Map<String, dynamic> map) {
    return GameData(
      id: map['id'],
      moves: map['moves'],
      timer: map['timer'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'moves': moves,
      'timer': timer,
    };
  }
}
