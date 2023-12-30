import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchData(String id) async {
  final response =
      await http.get(Uri.parse('https://enka.network/api/uid/$id'));

  if (response.statusCode == 200) {
    Map<String, dynamic> userMap = jsonDecode(response.body);
    return userMap;
  } else {
    throw Exception('Failed to load List');
  }
}

class AvatarInfoList {
  int avatarId;
  Map<String, PropMap> propMap;
  Map<String, double> fightPropMap;
  int skillDepotId;
  List<int> inherentProudSkillList;
  Map<String, int> skillLevelMap;
  List<EquipList> equipList;
  FetterInfo fetterInfo;
  List<int>? talentIdList;

  AvatarInfoList({
    required this.avatarId,
    required this.propMap,
    required this.fightPropMap,
    required this.skillDepotId,
    required this.inherentProudSkillList,
    required this.skillLevelMap,
    required this.equipList,
    required this.fetterInfo,
    this.talentIdList,
  });

  factory AvatarInfoList.fromJson(Map<String, dynamic> json) => AvatarInfoList(
        avatarId: json["avatarId"],
        propMap: Map.from(json["propMap"])
            .map((k, v) => MapEntry<String, PropMap>(k, PropMap.fromJson(v))),
        fightPropMap: Map.from(json["fightPropMap"])
            .map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
        skillDepotId: json["skillDepotId"],
        inherentProudSkillList:
            List<int>.from(json["inherentProudSkillList"].map((x) => x)),
        skillLevelMap: Map.from(json["skillLevelMap"])
            .map((k, v) => MapEntry<String, int>(k, v)),
        equipList: List<EquipList>.from(
            json["equipList"].map((x) => EquipList.fromJson(x))),
        fetterInfo: FetterInfo.fromJson(json["fetterInfo"]),
        talentIdList: json["talentIdList"] == null
            ? []
            : List<int>.from(json["talentIdList"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "avatarId": avatarId,
        "propMap": Map.from(propMap)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "fightPropMap": Map.from(fightPropMap)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "skillDepotId": skillDepotId,
        "inherentProudSkillList":
            List<dynamic>.from(inherentProudSkillList.map((x) => x)),
        "skillLevelMap": Map.from(skillLevelMap)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "equipList": List<dynamic>.from(equipList.map((x) => x.toJson())),
        "fetterInfo": fetterInfo.toJson(),
        "talentIdList": talentIdList == null
            ? []
            : List<dynamic>.from(talentIdList!.map((x) => x)),
      };
}

class EquipList {
  int itemId;
  Reliquary? reliquary;
  Flat flat;
  Weapon? weapon;

  EquipList({
    required this.itemId,
    this.reliquary,
    required this.flat,
    this.weapon,
  });

  factory EquipList.fromJson(Map<String, dynamic> json) => EquipList(
        itemId: json["itemId"],
        reliquary: json["reliquary"] == null
            ? null
            : Reliquary.fromJson(json["reliquary"]),
        flat: Flat.fromJson(json["flat"]),
        weapon: json["weapon"] == null ? null : Weapon.fromJson(json["weapon"]),
      );

  Map<String, dynamic> toJson() => {
        "itemId": itemId,
        "reliquary": reliquary?.toJson(),
        "flat": flat.toJson(),
        "weapon": weapon?.toJson(),
      };
}

class Flat {
  String nameTextMapHash;
  int rankLevel;
  ItemType itemType;
  String icon;
  EquipType? equipType;
  String? setNameTextMapHash;
  List<Stat>? reliquarySubstats;
  ReliquaryMainstat? reliquaryMainstat;
  List<Stat>? weaponStats;

  Flat({
    required this.nameTextMapHash,
    required this.rankLevel,
    required this.itemType,
    required this.icon,
    this.equipType,
    this.setNameTextMapHash,
    this.reliquarySubstats,
    this.reliquaryMainstat,
    this.weaponStats,
  });

  factory Flat.fromJson(Map<String, dynamic> json) => Flat(
        nameTextMapHash: json["nameTextMapHash"],
        rankLevel: json["rankLevel"],
        itemType: itemTypeValues.map[json["itemType"]]!,
        icon: json["icon"],
        equipType: equipTypeValues.map[json["equipType"]]!,
        setNameTextMapHash: json["setNameTextMapHash"],
        reliquarySubstats: json["reliquarySubstats"] == null
            ? []
            : List<Stat>.from(
                json["reliquarySubstats"]!.map((x) => Stat.fromJson(x))),
        reliquaryMainstat: json["reliquaryMainstat"] == null
            ? null
            : ReliquaryMainstat.fromJson(json["reliquaryMainstat"]),
        weaponStats: json["weaponStats"] == null
            ? []
            : List<Stat>.from(
                json["weaponStats"]!.map((x) => Stat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "nameTextMapHash": nameTextMapHash,
        "rankLevel": rankLevel,
        "itemType": itemTypeValues.reverse[itemType],
        "icon": icon,
        "equipType": equipTypeValues.reverse[equipType],
        "setNameTextMapHash": setNameTextMapHash,
        "reliquarySubstats": reliquarySubstats == null
            ? []
            : List<dynamic>.from(reliquarySubstats!.map((x) => x.toJson())),
        "reliquaryMainstat": reliquaryMainstat?.toJson(),
        "weaponStats": weaponStats == null
            ? []
            : List<dynamic>.from(weaponStats!.map((x) => x.toJson())),
      };
}

enum EquipType {
  EQUIP_BRACER,
  EQUIP_DRESS,
  EQUIP_NECKLACE,
  EQUIP_RING,
  EQUIP_SHOES
}

final equipTypeValues = EnumValues({
  "EQUIP_BRACER": EquipType.EQUIP_BRACER,
  "EQUIP_DRESS": EquipType.EQUIP_DRESS,
  "EQUIP_NECKLACE": EquipType.EQUIP_NECKLACE,
  "EQUIP_RING": EquipType.EQUIP_RING,
  "EQUIP_SHOES": EquipType.EQUIP_SHOES
});

enum ItemType { ITEM_RELIQUARY, ITEM_WEAPON }

final itemTypeValues = EnumValues({
  "ITEM_RELIQUARY": ItemType.ITEM_RELIQUARY,
  "ITEM_WEAPON": ItemType.ITEM_WEAPON
});

class ReliquaryMainstat {
  String mainPropId;
  double statValue;

  ReliquaryMainstat({
    required this.mainPropId,
    required this.statValue,
  });

  factory ReliquaryMainstat.fromJson(Map<String, dynamic> json) =>
      ReliquaryMainstat(
        mainPropId: json["mainPropId"],
        statValue: json["statValue"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "mainPropId": mainPropId,
        "statValue": statValue,
      };
}

class Stat {
  AppendPropId appendPropId;
  double statValue;

  Stat({
    required this.appendPropId,
    required this.statValue,
  });

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
        appendPropId: appendPropIdValues.map[json["appendPropId"]]!,
        statValue: json["statValue"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "appendPropId": appendPropIdValues.reverse[appendPropId],
        "statValue": statValue,
      };
}

enum AppendPropId {
  FIGHT_PROP_ATTACK,
  FIGHT_PROP_ATTACK_PERCENT,
  FIGHT_PROP_BASE_ATTACK,
  FIGHT_PROP_CHARGE_EFFICIENCY,
  FIGHT_PROP_CRITICAL,
  FIGHT_PROP_CRITICAL_HURT,
  FIGHT_PROP_DEFENSE,
  FIGHT_PROP_DEFENSE_PERCENT,
  FIGHT_PROP_ELEMENT_MASTERY,
  FIGHT_PROP_HP,
  FIGHT_PROP_HP_PERCENT
}

final appendPropIdValues = EnumValues({
  "FIGHT_PROP_ATTACK": AppendPropId.FIGHT_PROP_ATTACK,
  "FIGHT_PROP_ATTACK_PERCENT": AppendPropId.FIGHT_PROP_ATTACK_PERCENT,
  "FIGHT_PROP_BASE_ATTACK": AppendPropId.FIGHT_PROP_BASE_ATTACK,
  "FIGHT_PROP_CHARGE_EFFICIENCY": AppendPropId.FIGHT_PROP_CHARGE_EFFICIENCY,
  "FIGHT_PROP_CRITICAL": AppendPropId.FIGHT_PROP_CRITICAL,
  "FIGHT_PROP_CRITICAL_HURT": AppendPropId.FIGHT_PROP_CRITICAL_HURT,
  "FIGHT_PROP_DEFENSE": AppendPropId.FIGHT_PROP_DEFENSE,
  "FIGHT_PROP_DEFENSE_PERCENT": AppendPropId.FIGHT_PROP_DEFENSE_PERCENT,
  "FIGHT_PROP_ELEMENT_MASTERY": AppendPropId.FIGHT_PROP_ELEMENT_MASTERY,
  "FIGHT_PROP_HP": AppendPropId.FIGHT_PROP_HP,
  "FIGHT_PROP_HP_PERCENT": AppendPropId.FIGHT_PROP_HP_PERCENT
});

class Reliquary {
  int level;
  int mainPropId;
  List<int> appendPropIdList;

  Reliquary({
    required this.level,
    required this.mainPropId,
    required this.appendPropIdList,
  });

  factory Reliquary.fromJson(Map<String, dynamic> json) => Reliquary(
        level: json["level"],
        mainPropId: json["mainPropId"],
        appendPropIdList:
            List<int>.from(json["appendPropIdList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "level": level,
        "mainPropId": mainPropId,
        "appendPropIdList": List<dynamic>.from(appendPropIdList.map((x) => x)),
      };
}

class Weapon {
  int level;
  int promoteLevel;
  Map<String, int> affixMap;

  Weapon({
    required this.level,
    required this.promoteLevel,
    required this.affixMap,
  });

  factory Weapon.fromJson(Map<String, dynamic> json) => Weapon(
        level: json["level"],
        promoteLevel: json["promoteLevel"],
        affixMap: Map.from(json["affixMap"])
            .map((k, v) => MapEntry<String, int>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "level": level,
        "promoteLevel": promoteLevel,
        "affixMap":
            Map.from(affixMap).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}

class FetterInfo {
  int expLevel;

  FetterInfo({
    required this.expLevel,
  });

  factory FetterInfo.fromJson(Map<String, dynamic> json) => FetterInfo(
        expLevel: json["expLevel"],
      );

  Map<String, dynamic> toJson() => {
        "expLevel": expLevel,
      };
}

class PropMap {
  int type;
  String ival;
  String? val;

  PropMap({
    required this.type,
    required this.ival,
    this.val,
  });

  factory PropMap.fromJson(Map<String, dynamic> json) => PropMap(
        type: json["type"],
        ival: json["ival"],
        val: json["val"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "ival": ival,
        "val": val,
      };
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
