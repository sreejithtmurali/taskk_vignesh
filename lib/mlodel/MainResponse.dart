import 'dart:convert';

import 'package:taskk/mlodel/Products.dart';

MainResponse mainResponseFromJson(String str) => MainResponse.fromJson(json.decode(str));
String mainResponseToJson(MainResponse data) => json.encode(data.toJson());
class MainResponse {
  MainResponse({
      this.success, 
      this.list, 
      this.msg,});

  MainResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['list'] != null) {
      list = [];
      json['list'].forEach((v) {
        list?.add(Product.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  bool? success;
  List<Product>? list;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (list != null) {
      map['list'] = list?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }

}