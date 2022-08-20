import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class JsonData {
  late QueryElectRoomInfo query_elec_roominfo;

  JsonData(this.query_elec_roominfo);

  JsonData.fromJson(Map jsonData) {
    query_elec_roominfo =
        QueryElectRoomInfo.fromJson(jsonData['query_elec_roominfo']);
  }

  toJson() =>
      <String, dynamic>{}
        ..putIfAbsent(
            "query_elec_roominfo", () => query_elec_roominfo.toJson());
}

class QueryElectRoomInfo {
  late String errmsg;
  late String account;
  late String aid;
  late Area area;
  late Building building;
  late Floor floor;
  late Room room;

  QueryElectRoomInfo(this.errmsg, this.account, this.aid, this.area,
      this.building, this.floor, this.room);

  QueryElectRoomInfo.fromJson(Map query_elec_roominfo) {
    errmsg = query_elec_roominfo['errmsg'];
    account = query_elec_roominfo['account'];
    aid = query_elec_roominfo['aid'];
    area = Area.fromJson(query_elec_roominfo['area']);
    building = Building.fromJson(query_elec_roominfo['building']);
    floor = Floor.fromJson(query_elec_roominfo['floor']);
    room = Room.fromJson(query_elec_roominfo['room']);
  }

  toJson() =>
      <String, dynamic>{}..putIfAbsent("account", () => account)..putIfAbsent(
          "aid", () => aid)..putIfAbsent(
          "area", () => area.toJson())..putIfAbsent(
          "building", () => building.toJson())..putIfAbsent(
          "errmsg", () => errmsg)..putIfAbsent(
          "floor", () => floor.toJson())..putIfAbsent(
          "room", () => room.toJson());
}

class Area {
  late String area;
  late String areaname;

  Area(this.area, this.areaname);

  Area.fromJson(Map area) {
    this.area = area['area'];
    areaname = area['areaname'];
  }

  toJson() => <String, dynamic>{}..putIfAbsent("area", () => area)..putIfAbsent(
      "areaname", () => areaname);
}

class Building {
  late String building;
  late String buildingid;

  Building(this.building, this.buildingid);

  Building.fromJson(Map building) {
    this.building = building['building'];
    buildingid = building['buildingid'];
  }

  toJson() =>
      <String, dynamic>{}..putIfAbsent("building", () => building)..putIfAbsent(
          "buildingid", () => buildingid);
}

class Floor {
  late String floor;
  late String floorid;

  Floor(this.floor, this.floorid);

  Floor.fromJson(Map floor) {
    this.floor = floor['floor'];
    floorid = floor['floorid'];
  }

  toJson() =>
      <String, dynamic>{}..putIfAbsent("floor", () => floor)..putIfAbsent(
          "floorid", () => floorid);
}

class Room {
  late String room;
  late String roomid;

  Room(this.room, this.roomid);

  Room.fromJson(Map room) {
    this.room = room['room'];
    roomid = room['roomid'];
  }

  toJson() => <String, dynamic>{}..putIfAbsent("room", () => room)..putIfAbsent(
      "roomid", () => roomid);
}

class Constant {
  static final Constant _instance = Constant._internal();

  factory Constant() => _instance;

  static Constant getInstance() => _instance;

  final Map _buildingMap = {};
  final Map _buildingMap2 = {};

  String getBuildingId(String building) {
    String result;
    if (_buildingMap.containsKey(building)) {
      result = _buildingMap[building];
    } else if (_buildingMap2.containsKey(building)) {
      result = _buildingMap2[building];
    } else {
      result = "-1";
    }
    return result;
  }

  List getAllBuildingName() {
    List result = [];
    _buildingMap.forEach((key, value) {
      result.add(key);
    });
    _buildingMap2.forEach((key, value) {
      result.add(key);
    });
    return result;
  }

  Constant._internal() {
    _buildingMap["16栋A区"] = "471";
    _buildingMap["16栋B区"] = "472";
    _buildingMap["17栋"] = "451";
    _buildingMap["弘毅轩1栋A区"] = "141";
    _buildingMap["弘毅轩1栋B区"] = "148";
    _buildingMap["弘毅轩2栋A区1-6楼"] = "197";
    _buildingMap["弘毅轩2栋B区"] = "201";
    _buildingMap["弘毅轩2栋C区"] = "205";
    _buildingMap["弘毅轩2栋D区"] = "206";
    _buildingMap["弘毅轩3栋A区"] = "155";
    _buildingMap["弘毅轩3栋B区"] = "183";
    _buildingMap["弘毅轩4栋A区"] = "162";
    _buildingMap["弘毅轩4栋B区"] = "169";
    _buildingMap["留学生公寓"] = "450";
    _buildingMap["敏行轩1栋A区"] = "176";
    _buildingMap["敏行轩1栋B区"] = "184";
    _buildingMap["行健轩1栋A区"] = "85";
    _buildingMap["行健轩1栋B区"] = "92";
    _buildingMap["行健轩2栋A区"] = "99";
    _buildingMap["行健轩2栋B区"] = "106";
    _buildingMap["行健轩3栋A区"] = "113";
    _buildingMap["行健轩3栋B区"] = "120";
    _buildingMap["行健轩4栋A区"] = "127";
    _buildingMap["行健轩4栋B区"] = "134";
    _buildingMap["行健轩5栋A区"] = "57";
    _buildingMap["行健轩5栋B区"] = "64";
    _buildingMap["行健轩6栋A区"] = "71";
    _buildingMap["行健轩6栋B区"] = "78";
    _buildingMap["至诚轩1栋A区"] = "1";
    _buildingMap["至诚轩1栋B区"] = "8";
    _buildingMap["至诚轩2栋A区"] = "15";
    _buildingMap["至诚轩2栋B区"] = "22";
    _buildingMap["至诚轩3栋A区"] = "29";
    _buildingMap["至诚轩3栋B区"] = "36";
    _buildingMap["至诚轩4栋A区"] = "43";
    _buildingMap["至诚轩4栋B区"] = "50";
    _buildingMap2["西苑1栋"] = "1";
    _buildingMap2["西苑2栋"] = "9";
    _buildingMap2["西苑3栋"] = "17";
    _buildingMap2["西苑4栋"] = "25";
    _buildingMap2["西苑5栋"] = "33";
    _buildingMap2["西苑6栋"] = "41";
    _buildingMap2["西苑7栋"] = "49";
    _buildingMap2["西苑8栋"] = "57";
    _buildingMap2["西苑9栋"] = "65";
    _buildingMap2["西苑10栋"] = "74";
    _buildingMap2["西苑11栋"] = "75";
    _buildingMap2["东苑4栋"] = "171";
    _buildingMap2["东苑5栋"] = "130";
    _buildingMap2["东苑6栋"] = "131";
    _buildingMap2["东苑9栋"] = "162";
    _buildingMap2["东苑14栋"] = "132";
    _buildingMap2["东苑15栋"] = "133";
    _buildingMap2["南苑3栋"] = "94";
    _buildingMap2["南苑4栋"] = "95";
    _buildingMap2["南苑5栋"] = "96";
    _buildingMap2["南苑7栋"] = "97";
    _buildingMap2["南苑8栋"] = "98";
  }
}

var map = {
  "query_elec_roominfo": {
    "retcode": "0",
    "errmsg": " 房间剩余电量35.40",
    "aid": "0030000000002501",
    "account": "1",
    "meterflag": "amt",
    "bal": "",
    "price": "0",
    "pkgflag": "none",
    "area": {"area": "云塘校区", "areaname": "云塘校区"},
    "building": {"buildingid": "106", "building": "行健轩2栋B区"},
    "floor": {"floorid": "", "floor": ""},
    "room": {"roomid": "B306", "room": "B306"},
    "pkgtab": []
  }
};


