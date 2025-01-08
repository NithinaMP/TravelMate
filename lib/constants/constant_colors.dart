import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const LinearGradient textGradient = LinearGradient(colors: [
  Color(0xffAB4E10),
  Color(0xffCBB480),
]);
const LinearGradient loginGradient = LinearGradient(
    colors: [
      Color(0xffC2540A),
      Color(0xff632B05),
      Color(0xff000000),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [
      0,
      0.0098,
      0.85,
    ]);
const LinearGradient reverseGradient = LinearGradient(
    colors: [
      Color(0xffC2540A),
      Color(0xff632B05),
      Color(0xff000000),
    ],
    begin: Alignment.topRight,
    end: Alignment.bottomRight,
    stops: [
      0,
      0.0098,
      0.85,
    ]);
const cstText = Colors.white;
const cstOrange1 = Color(0xff632B05);
const cstOrange2 = Color(0xffBF641A);
const LinearGradient containerGradient = LinearGradient(
  colors: [
    Color(0xff592F0C),
    Color(0xffBF641A),
  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);
const LinearGradient containerRGradient = LinearGradient(
  colors: [
    Color(0xffB35E18),
    // Color(0xff592F0C),
    Colors.black
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
const LinearGradient admingradient=LinearGradient(colors: [
  Color(0xff351C08),
  Color(0xff100801),
  // Color(0xff140900),
],
begin: Alignment.bottomLeft,
end: Alignment.bottomRight
);
const LinearGradient admingradientone=LinearGradient(colors: [
  Color(0xff351C08),
  Color(0xff100801),
  Color(0xff000000),
  // Color(0xff140900),
],
    begin: Alignment.center,
    end: Alignment.bottomCenter,

);

const cstRed=Color(0xff8F0000);