import 'package:chat/util.dart';
import 'package:flutter/material.dart';

ColorSwatch getColor(String name) =>
    selectableColorSwatches.firstWhere((pair) => pair.first == name).second;

final selectableColorSwatches = [
  Pair("red", Colors.red),
  Pair("pink", Colors.pink),
  Pair("orange", Colors.orange),
  Pair("yellow", Colors.yellow),
  Pair("green", Colors.green),
  Pair("blue", Colors.blue),
  Pair("purple", Colors.purple),
  Pair("brown", Colors.brown),
  Pair("grey", Colors.grey),
];
