import 'dart:math';

import 'package:ascii_clock/ascii_display/ascii_display.dart';
import 'package:ascii_clock/ascii_display/ascii_surfaces.dart';

main() {
  var display = AsciiDisplay(58, 20, 100);
  display.addSurface(
      StaticSurface.initFromFile('./templates/sun.txt', 32, 2, 5, 3));

  display.addSurface(
      StaticSurface.initFromFile('./templates/hotel.txt', 17, 2, 33, 16));
  display.addSurface(AnimdatedSurface(40, 8, 16, 10, (int step) {
    return List.generate(
        16 * 10, (index) => Random().nextInt(6) == 1 ? "`" : " ").join();
  }, stepCount: 5));

  display.addSurface(StaticSurface.initFromFile(
      './templates/cloud_with_moon.txt', 39, 3, 10, 17));

  display.addSurface(AnimdatedSurface(25, 4, 1, 8, (int step) {
    var date = DateTime.now();
    String result = "";
    result += date.hour.toString().padLeft(2, "0");
    result += step == 0 ? ":" : " ";
    result += date.minute.toString().padLeft(2, "0");
    result += step == 0 ? ":" : " ";
    result += date.second.toString().padLeft(2, "0");
    return result;
  }));
  display.addSurface(AnimdatedSurface(3, 2, 1, 1, (int step) {
    ;
    if (step == 0) return "|";
    if (step == 1) return "\\";
    if (step == 2) return "-";
    if (step == 3) return "/";
    if (step == 4) return "|";
    if (step == 5) return "\\";
    if (step == 6) return "-";
    if (step == 7) return "/";
    return " ";
  }, stepCount: 7));

  display.addSurface(AnimdatedSurface(22, 15, 8, 2, (int step) {
    String preresult = "";
    if (step == 5) {
      preresult = "  ~~~~~~";
    }
    if (step == 4) {
      preresult = " ~~~~~~ ";
    }
    if (step == 3) {
      preresult = "~~~~~~  ";
    }
    if (step == 2) {
      preresult = "~~~~~~  ";
    }
    if (step == 1) {
      preresult = " ~~~~~~ ";
    }
    if (step == 0) {
      preresult = "  ~~~~~~";
    }
    return preresult + preresult.split("").reversed.join();
  }, stepCount: 5));

  display.run();
}
