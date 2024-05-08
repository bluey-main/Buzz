import 'package:flutter/material.dart';

Color ColorChange (int index, Color color1, Color color2){
  if(index % 2 == 0){
    return color1;
  }else{
    return color2;
  }

}