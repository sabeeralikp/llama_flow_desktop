import 'package:flutter/material.dart';

// Margin Padding
EdgeInsets edgeAll8 = const EdgeInsets.all(8);
EdgeInsets edgeAll10 = const EdgeInsets.all(10);
EdgeInsets edgeAll16 = const EdgeInsets.all(16);
EdgeInsets edgeAll32 = const EdgeInsets.all(32);

EdgeInsets edgeSymmetricV8 = const EdgeInsets.symmetric(vertical: 8);
EdgeInsets edgeSymmetricV16 = const EdgeInsets.symmetric(vertical: 32);
EdgeInsets edgeSymmetricV64 = const EdgeInsets.symmetric(vertical: 64);

EdgeInsets edgeSymmetricH32 = const EdgeInsets.symmetric(horizontal: 32);
EdgeInsets edgeSymmetricH64 = const EdgeInsets.symmetric(horizontal: 80);
EdgeInsets edgeSymmetricV4H16 =
    const EdgeInsets.symmetric(vertical: 4, horizontal: 16);
EdgeInsets edgeSymmetricV4H32 =
    const EdgeInsets.symmetric(vertical: 4, horizontal: 32);
EdgeInsets edgeSymmetricV160H10 =
    const EdgeInsets.symmetric(vertical: 160, horizontal: 10);

EdgeInsets edgeOnlyT16 = const EdgeInsets.only(top: 16);
EdgeInsets edgeOnlyL20 = const EdgeInsets.only(left: 20);
EdgeInsets edgeOnlyT8L6R6 = const EdgeInsets.only(top: 8, right: 6, left: 6);

// Border Radius
BorderRadius borderRadiusCircular20 = BorderRadius.circular(20);
BorderRadius borderRadiusCircular14 = BorderRadius.circular(14);
BorderRadius borderRadiusCircular8 = BorderRadius.circular(8);
BorderRadius borderRadiusOnlybLeft20bRight20 = const BorderRadius.only(
    bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8));
BorderRadius borderRadiusOnlytLeft20bRight20 = const BorderRadius.only(
    topLeft: Radius.circular(8), topRight: Radius.circular(8));

//Gaps
SizedBox sizedBoxH4 = const SizedBox(height: 4);
SizedBox sizedBoxH8 = const SizedBox(height: 8);
SizedBox sizedBoxH12 = const SizedBox(height: 12);
SizedBox sizedBoxH16 = const SizedBox(height: 16);
SizedBox sizedBoxH24 = const SizedBox(height: 24);
SizedBox sizedBoxH32 = const SizedBox(height: 32);
SizedBox sizedBoxH48 = const SizedBox(height: 48);


SizedBox sizedBoxW4 = const SizedBox(width: 4);
SizedBox sizedBoxW8 = const SizedBox(width: 8);
SizedBox sizedBoxW12 = const SizedBox(width: 12);
SizedBox sizedBoxW16 = const SizedBox(width: 16);
SizedBox sizedBoxW24 = const SizedBox(width: 24);
SizedBox sizedBoxW32 = const SizedBox(width: 32);
