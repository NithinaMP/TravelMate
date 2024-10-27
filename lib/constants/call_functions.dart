import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelmate/user/destinationScreen.dart';

callNext(var context,var className){
  Navigator.push(context, MaterialPageRoute(builder: (context) => className,));
}

callNextReplacement(var context,var className, ) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => className),
  );
}

back(var context, DestinationScreen destinationScreen) {
  Navigator.pop(context);
}

void finish(context) {
  Navigator.pop(context);
}
