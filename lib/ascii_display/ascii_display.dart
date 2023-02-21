import 'dart:async';

import 'ascii_surfaces.dart';

class AsciiDisplay {
  final int width, height, secondsUpdate;
  List<List<String>> get _output {
    List<List<String>> primer =
        List.generate(height, (index) => List.generate(width, (index) => " "));
    ;
    staticSurfaces.forEach((surf) {
      var patch = surf.draw();
      for (var i = 0; i < patch.length; i++) {
        var row = patch[i];
        for (var j = 0; j < row.length; j++) {
          if (patch[i][j] != " ") {
            primer[i + surf.y][j + surf.x] = patch[i][j];
          }
        }
      }
    });
    animatedSurfaces.forEach((surf) {
      var patch = surf.draw();
      for (var i = 0; i < patch.length; i++) {
        var row = patch[i];
        for (var j = 0; j < row.length; j++) {
          if (patch[i][j] != " ") {
            primer[i + surf.y][j + surf.x] = patch[i][j];
          }
        }
      }
    });
    return primer;
  }

  late Timer _timer;

  AsciiDisplay(this.width, this.height, this.secondsUpdate);

  void _display() {
    _output.forEach((row) {
      print(row.join());
    });
  }

  void _clear() => print("\x1B[2J\x1B[0;0H");

  run() {
    _timer =
        Timer.periodic(Duration(milliseconds: secondsUpdate), _handleTimer);
    _handleTimer(_timer);
  }

  _handleTimer(Timer t) {
    _clear();
    _display();
  }

  List<StaticSurface> staticSurfaces = [];
  List<AnimdatedSurface> animatedSurfaces = [];

  addSurface(AsciiSurface surface) {
    if (surface is StaticSurface) {
      staticSurfaces.add(surface);
    }
    if (surface is AnimdatedSurface) {
      animatedSurfaces.add(surface);
    }
  }
}
