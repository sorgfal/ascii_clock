

import 'dart:io';

class StaticSurface implements AsciiSurface {
  final x, y, width, height;
  final List<String> lines;

  StaticSurface(this.x, this.y, this.width, this.height, {this.lines});
  List<List<String>> draw() {
    if (lines != null) {
      return lines.map((e) => e.split('')).toList();
    }
  }

  static StaticSurface initFromFile(
      String filepath, int x, int y, int width, int height) {
    String data = File(filepath).readAsStringSync();
    List<String> lines = data.split('\n');
    for (var line in lines) {
      if (line.length < width) {
        line += List.generate(width - line.length, (i) => "=").join();
      }
    }

    return StaticSurface(x, y, width, height, lines: lines);
  }
}

class AnimdatedSurface implements AsciiSurface {
  final int stepCount;
  final x, y, width, height;
  final AnimdatedSurfaceBuilder builder;

  int _counter = 0;

  AnimdatedSurface(this.x, this.y, this.width, this.height, this.builder,
      {this.stepCount = 1});
  List<List<String>> draw() {
    String symbols = _build();
    List<List<String>> result = [];
    for (var i = 0; i < height; i++) {
      result.add(symbols.split('').sublist(i * width, (i + 1) * width));
    }
    return result;
  }

  String _build() {
    _counter = _counter >= stepCount ? 0 : _counter + 1;
    return builder(_counter);
  }
}

typedef AnimdatedSurfaceBuilder = String Function(int step);

abstract class AsciiSurface {
  List<List<String>> draw();
}

String prepareString(String s) {
  return s.replaceAll("\n", '').replaceAll('\r', "").replaceAll('\t', "");
}
