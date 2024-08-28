import 'dart:async';

import 'package:emf_analyzer/models/magnitudeProvider.dart';
import 'package:emf_analyzer/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Visuals extends StatefulWidget {
  const Visuals({Key? key}) : super(key: key);

  @override
  _VisualsState createState() => _VisualsState();
}

class _VisualsState extends State<Visuals> {
  late ChartSeriesController _chartSeriesController;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: Text('Visuals'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              // color: Colors.grey.shade800,
              margin: EdgeInsets.all(5),
              child: Card(
                  color: Colors.grey.shade800,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Consumer<MagnitudeProvider>(
                    builder: (context, model, child) => SfCartesianChart(
                        title: ChartTitle(text: 'x,y,z with Time'),
                        legend: Legend(
                          isVisible: true,
                          title: LegendTitle(text: 'Legend'),
                        ),
                        series: <LineSeries<LiveData, int>>[
                          //x
                          LineSeries<LiveData, int>(
                            legendItemText: 'x',
                            onRendererCreated:
                                (ChartSeriesController controller) {
                              _chartSeriesController = controller;
                            },
                            dataSource: model.values,
                            color: Colors.red,
                            xValueMapper: (LiveData value, _) => value.time,
                            yValueMapper: (LiveData value, _) => value.x,
                          ),

                          //y
                          LineSeries<LiveData, int>(
                            legendItemText: 'y',
                            onRendererCreated:
                                (ChartSeriesController controller) {
                              _chartSeriesController = controller;
                            },
                            dataSource: model.values,
                            color: Colors.blue,
                            xValueMapper: (LiveData value, _) => value.time,
                            yValueMapper: (LiveData value, _) => value.y,
                          ),

                          //z
                          LineSeries<LiveData, int>(
                            legendItemText: 'z',
                            onRendererCreated:
                                (ChartSeriesController controller) {
                              _chartSeriesController = controller;
                            },
                            dataSource: model.values,
                            color: Colors.green,
                            xValueMapper: (LiveData value, _) => value.time,
                            yValueMapper: (LiveData value, _) => value.z,
                          ),
                        ],
                        primaryXAxis: NumericAxis(
                            isVisible: true,
                            majorGridLines: const MajorGridLines(width: 0),
                            edgeLabelPlacement: EdgeLabelPlacement.shift,
                            interval: 3,
                            title: AxisTitle(text: 'Time(s)')),
                        primaryYAxis: NumericAxis(
                            axisLine: const AxisLine(width: 0),
                            majorTickLines: const MajorTickLines(size: 0),
                            title: AxisTitle(text: 'uTesla'))),
                  )),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: Card(
                color: Colors.grey.shade800,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Consumer<MagnitudeProvider>(
                  builder: (context, model, child) => SfCartesianChart(
                      title: ChartTitle(text: "Magnetic Field Strength(A/m)"),
                      legend: Legend(
                          isVisible: true, title: LegendTitle(text: "Legend")),
                      series: <LineSeries<LiveData, int>>[
                        //Magnetic Strength
                        LineSeries<LiveData, int>(
                          legendItemText: "Magnetic Field Strength",
                          onRendererCreated:
                              (ChartSeriesController controller) {
                            _chartSeriesController = controller;
                          },
                          dataSource: model.values,
                          xValueMapper: (LiveData value, _) => value.time,
                          yValueMapper: (LiveData value, _) =>
                              value.magnetic_field_strength,
                        ),
                        LineSeries<LiveData, int>(
                          legendItemText: "Safety Threshold",
                          onRendererCreated:
                              (ChartSeriesController controller) {
                            _chartSeriesController = controller;
                          },
                          dataSource: model.changeValues(),
                          xValueMapper: (LiveData value, _) => value.time,
                          yValueMapper: (LiveData value, _) => 1,
                        )
                      ],
                      primaryXAxis: NumericAxis(
                          isVisible: true,
                          majorGridLines: const MajorGridLines(width: 0),
                          edgeLabelPlacement: EdgeLabelPlacement.shift,
                          interval: 3,
                          title: AxisTitle(text: 'Time(s)')),
                      primaryYAxis: NumericAxis(
                          axisLine: const AxisLine(width: 0),
                          majorTickLines: const MajorTickLines(size: 0),
                          title: AxisTitle(text: 'A/m'))),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: Card(
                color: Colors.grey.shade800,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Consumer<MagnitudeProvider>(
                  builder: (context, model, child) => SfCartesianChart(
                      title: ChartTitle(text: "Exposure Limits"),
                      legend: Legend(
                          isVisible: true, title: LegendTitle(text: "Legend")),
                      series: <LineSeries<LiveData, int>>[
                        //Power Density
                        LineSeries<LiveData, int>(
                          legendItemText: "Power Density",
                          onRendererCreated:
                              (ChartSeriesController controller) {
                            _chartSeriesController = controller;
                          },
                          dataSource: model.values,
                          xValueMapper: (LiveData value, _) => value.time,
                          yValueMapper: (LiveData value, _) =>
                              value.power_density,
                        ),
                        // LineSeries<LiveData, int>(
                        //   legendItemText: "Safety Threshold",
                        //   onRendererCreated:
                        //       (ChartSeriesController controller) {
                        //     _chartSeriesController = controller;
                        //   },
                        //   xValueMapper: (LiveData value, _) => value.time,
                        //   yValueMapper: (LiveData value, _) => 5,
                        // )
                      ],
                      primaryXAxis: NumericAxis(
                          isVisible: true,
                          majorGridLines: const MajorGridLines(width: 0),
                          edgeLabelPlacement: EdgeLabelPlacement.shift,
                          interval: 3,
                          title: AxisTitle(text: 'Time(s)')),
                      primaryYAxis: NumericAxis(
                          axisLine: const AxisLine(width: 0),
                          majorTickLines: const MajorTickLines(size: 0),
                          title: AxisTitle(text: 'W/m^2'))),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: Card(
                color: Colors.grey.shade800,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Consumer<MagnitudeProvider>(
                  builder: (context, model, child) => SfCartesianChart(
                      title: ChartTitle(text: "Electric Field Strength(V/m)"),
                      legend: Legend(
                          isVisible: true, title: LegendTitle(text: "Legend")),
                      series: <LineSeries<LiveData, int>>[
                        //Electric Strength
                        LineSeries<LiveData, int>(
                          legendItemText: "Electric Field Strength",
                          onRendererCreated:
                              (ChartSeriesController controller) {
                            _chartSeriesController = controller;
                          },
                          dataSource: model.values,
                          xValueMapper: (LiveData value, _) => value.time,
                          yValueMapper: (LiveData value, _) =>
                              value.electric_field_strength,
                        ),
                        // LineSeries<LiveData, int>(
                        //   legendItemText: "Safety Threshold",
                        //   onRendererCreated:
                        //       (ChartSeriesController controller) {
                        //     _chartSeriesController = controller;
                        //   },
                        //   xValueMapper: (LiveData value, _) => value.time,
                        //   yValueMapper: (LiveData value, _) => 5,
                        // )
                      ],
                      primaryXAxis: NumericAxis(
                          isVisible: true,
                          majorGridLines: const MajorGridLines(width: 0),
                          edgeLabelPlacement: EdgeLabelPlacement.shift,
                          interval: 3,
                          title: AxisTitle(text: 'Time(s)')),
                      primaryYAxis: NumericAxis(
                          axisLine: const AxisLine(width: 0),
                          majorTickLines: const MajorTickLines(size: 0),
                          title: AxisTitle(text: 'V/m'))),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              height: 40,
              width: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade800),
              child: Center(
                  child: Text(
                      'Note: For the general public: The ICNIRP recommends a limit of 200 µT for continuous exposure at 50/60 Hz.For occupational exposure: The limit is higher, at 1,000 µT. ')),
            )
          ]),
        ),
      ),
    );
  }
}
