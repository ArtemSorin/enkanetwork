import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchDataInfo(int id) async {
  final response =
      await http.get(Uri.parse('https://enka.network/api/uid/$id?info'));

  if (response.statusCode == 200) {
    Map<String, dynamic> userMap = jsonDecode(response.body);
    return userMap;
  } else {
    throw Exception('Failed to load List');
  }
}

class PlayerInfo {
  String nickname;
  int level;
  String signature;
  int worldLevel;
  int nameCardId;
  int finishAchievementNum;
  int towerFloorIndex;
  int towerLevelIndex;
  List<ShowAvatarInfoList> showAvatarInfoList;
  List<int> showNameCardIdList;
  ProfilePicture profilePicture;

  PlayerInfo({
    required this.nickname,
    required this.level,
    required this.signature,
    required this.worldLevel,
    required this.nameCardId,
    required this.finishAchievementNum,
    required this.towerFloorIndex,
    required this.towerLevelIndex,
    required this.showAvatarInfoList,
    required this.showNameCardIdList,
    required this.profilePicture,
  });

  factory PlayerInfo.fromJson(Map<String, dynamic> json) => PlayerInfo(
        nickname: json["nickname"],
        level: json["level"],
        signature: json["signature"],
        worldLevel: json["worldLevel"],
        nameCardId: json["nameCardId"],
        finishAchievementNum: json["finishAchievementNum"],
        towerFloorIndex: json["towerFloorIndex"],
        towerLevelIndex: json["towerLevelIndex"],
        showAvatarInfoList: List<ShowAvatarInfoList>.from(
            json["showAvatarInfoList"]
                .map((x) => ShowAvatarInfoList.fromJson(x))),
        showNameCardIdList:
            List<int>.from(json["showNameCardIdList"].map((x) => x)),
        profilePicture: ProfilePicture.fromJson(json["profilePicture"]),
      );

  Map<String, dynamic> toJson() => {
        "nickname": nickname,
        "level": level,
        "signature": signature,
        "worldLevel": worldLevel,
        "nameCardId": nameCardId,
        "finishAchievementNum": finishAchievementNum,
        "towerFloorIndex": towerFloorIndex,
        "towerLevelIndex": towerLevelIndex,
        "showAvatarInfoList":
            List<dynamic>.from(showAvatarInfoList.map((x) => x.toJson())),
        "showNameCardIdList":
            List<dynamic>.from(showNameCardIdList.map((x) => x)),
        "profilePicture": profilePicture.toJson(),
      };
}

class ProfilePicture {
  int avatarId;

  ProfilePicture({
    required this.avatarId,
  });

  factory ProfilePicture.fromJson(Map<String, dynamic> json) => ProfilePicture(
        avatarId: json["avatarId"],
      );

  Map<String, dynamic> toJson() => {
        "avatarId": avatarId,
      };
}

class ShowAvatarInfoList {
  int avatarId;
  int level;

  ShowAvatarInfoList({
    required this.avatarId,
    required this.level,
  });

  factory ShowAvatarInfoList.fromJson(Map<String, dynamic> json) =>
      ShowAvatarInfoList(
        avatarId: json["avatarId"],
        level: json["level"],
      );

  Map<String, dynamic> toJson() => {
        "avatarId": avatarId,
        "level": level,
      };
}
