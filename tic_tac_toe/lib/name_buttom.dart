import 'dart:ui';

import 'package:flutter/material.dart';
//Create a class for the game buttons.
class GameButton{
  final id;
  String text;
  Color bg;
  bool enabled;

  GameButton
      ({this.id, this.text="",this.bg=Colors.grey, this.enabled = true, });
}