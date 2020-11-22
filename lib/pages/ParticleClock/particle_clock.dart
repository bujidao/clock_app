import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'palette.dart';
import 'scene.dart';

class ParticleClock extends StatefulWidget {

  @override
  _ParticleClockState createState() => _ParticleClockState();
}

class _ParticleClockState extends State<ParticleClock>
    with SingleTickerProviderStateMixin {
  DateTime _dateTime = DateTime.now();
  Timer _timer;
  double seek = 0.0;
  double seekIncrement = 1 / 3600;

  @override
  void initState() {
    super.initState();

    _updateTime();
  }

  @override
  void didUpdateWidget(ParticleClock oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<List<Palette>> _loadPalettes() async {
    String data =
        await DefaultAssetBundle.of(context).loadString("lib/assets/palettes.json");
    var palettes = json.decode(data) as List;
    return palettes.map((p) => Palette.fromJson(p)).toList();
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadPalettes(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            decoration: BoxDecoration(
              color: Color(0xff101010)
            ),
            child: Center(
              child: Text(
                "Could not load palettes.",
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Color(0xffb0b0b0)
                ),
              ),
            ),
          );
        }

        List<Palette> palettes = snapshot.data;

        return LayoutBuilder(
          builder: (context, constraints) {
            return Scene(
              size: constraints.biggest,
              palettes: palettes,
              time: _dateTime,
              brightness: Theme.of(context).brightness,
            );
          },
        );
      },
    );
  }
}
