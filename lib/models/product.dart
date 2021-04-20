//import 'package:flutter/material.dart';

class Product {
  int _id;
  String _name;
  String _description;
  double _price;
  Product(this._name, this._description, this._price);
  Product.witId(this._id, this._name, this._description, this._price);

  int get id => _id;
  String get name => _name;
  String get description => _description;
  double get price => _price;

  set name(String value) {
    if (value.length >= 2) {
      _name = value;
    }
  }

  set description(String value) {
    if (value.length >= 10) {
      _description = value;
    }
  }

  set price(double value) {
    if (value > 0) {
      _price = value;
    }
  }

  Map<String, dynamic> tomMap() {
    var map = Map<String, dynamic>();
    map["name"] = _name;
    map["description"] = _description;
    map["price"] = _price;
    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  Product.fromObject(dynamic o) {
    this._id = o["Id"];
    this._description = o["Description"];
    this._name = o["Name"];
    this.price = double.tryParse(o["Price"].toString());
  }
}
