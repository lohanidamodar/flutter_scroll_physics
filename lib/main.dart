import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() async => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints){
          return Material(
            color: Colors.black38,
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 400.0,
                  maxHeight: constraints.maxHeight
                ),
                child: ListView.builder(
                  physics: CustomScrollPhysics(),
                  itemExtent: 250.0,
                  itemBuilder: (context, index){
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Material(
                        elevation: 4.0,
                        borderRadius: BorderRadius.circular(5.0),
                        color: index%2==0?Colors.cyan:Colors.deepOrange,
                        child: Center(
                          child: Text(index.toString())
                        ),
                      )
                    );
                  }
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CustomSimulator extends Simulation {
  final double initialPosition;
  final double velocity;

  CustomSimulator({this.initialPosition, this.velocity});

  @override
  double dx(double time) {
    return velocity;
  }

  @override
  bool isDone(double time) {
    return false;
  }

  @override
  double x(double time) {
    var max = math.max(math.min(initialPosition,0.0), initialPosition+velocity*time);
    return max;
  }

}

class CustomScrollPhysics extends ScrollPhysics {

  @override
  ScrollPhysics applyTo(ScrollPhysics ancestor){
    return CustomScrollPhysics();
  }

  @override
  Simulation createBallisticSimulation(
    ScrollMetrics position, double velocity){
      return CustomSimulator(
        initialPosition: position.pixels,
        velocity: velocity
      );
    }

}