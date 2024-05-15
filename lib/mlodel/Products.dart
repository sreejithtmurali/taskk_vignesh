import 'dart:convert';

Product listFromJson(String str) => Product.fromJson(json.decode(str));
String listToJson(Product data) => json.encode(data.toJson());
class Product {
  Product({
      this.title, 
      this.price, 
      this.image, 
      this.type,});

  Product.fromJson(dynamic json) {
    title = json['title'];
    price = json['price'];
    image = json['image'];
    type = json['type'];
  }
  String? title;
  num? price;
  String? image;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['price'] = price;
    map['image'] = image;
    map['type'] = type;
    return map;
  }

}