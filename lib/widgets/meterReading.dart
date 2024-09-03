import 'package:emf_analyzer/models/magnitudeProvider.dart';
import 'package:emf_analyzer/utils/colors.dart';
import 'package:emf_analyzer/widgets/textWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MeterReading extends StatefulWidget {
  const MeterReading({Key? key}) : super(key: key);

  @override
  _MeterReadingState createState() => _MeterReadingState();
}

class _MeterReadingState extends State<MeterReading> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Consumer<MagnitudeProvider>(
          builder: (context, model, child) => SfRadialGauge(axes: <RadialAxis>[
            RadialAxis(
                minimum: 0,
                maximum: 1200,
                labelOffset: 20,
                tickOffset: 20,
                ranges: <GaugeRange>[
                  GaugeRange(
                    startValue: 0,
                    endValue: 100,
                    color: AppColors.green,
                    label: 'SAFE',
                    startWidth: 25,
                    endWidth: 25,
                    labelStyle: GaugeTextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  GaugeRange(
                    startValue: 100,
                    endValue: 200,
                    color: AppColors.orange,
                    label: 'Moderate',
                    startWidth: 25,
                    endWidth: 25,
                    labelStyle: GaugeTextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  GaugeRange(
                    startValue: 200,
                    endValue: 1000,
                    color: Color.fromARGB(255, 232, 33, 18),
                    label: 'DANGER',
                    startWidth: 25,
                    endWidth: 25,
                    labelStyle: GaugeTextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  GaugeRange(
                    startValue: 1000,
                    endValue: 1200,
                    color: Colors.purple,
                    label: 'Off-Limits',
                    startWidth: 25,
                    endWidth: 25,
                    labelStyle: GaugeTextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
                pointers: <GaugePointer>[
                  NeedlePointer(value: model.magnitude)
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      widget: Container(
                          child: Text(model.magnitude.toStringAsFixed(2),
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold))),
                      angle: 90,
                      positionFactor: 0.5)
                ])
          ]),
        ),
      ],
    );
  }
}
