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
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: Text('Visuals'),
        backgroundColor: Color.fromARGB(255, 35, 105, 93),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              color: AppColors.primaryColor,
              margin: EdgeInsets.all(5),
              child: Card(
                  color: Color.fromARGB(255, 35, 105, 93),
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
                            dataSource: model.getOrderedValues(),
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
                            dataSource: model.getOrderedValues(),
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
                            dataSource: model.getOrderedValues(),
                            color: Colors.green,
                            xValueMapper: (LiveData value, _) => value.time,
                            yValueMapper: (LiveData value, _) => value.z,
                          ),
                        ],
                        primaryXAxis: NumericAxis(
                            isVisible: true,
                            majorGridLines: const MajorGridLines(width: 0),
                            edgeLabelPlacement: EdgeLabelPlacement.shift,
                            // interval: 3,
                            minimum: model.totalPoints > model.maxDataPoints? (model.totalPoints - model.maxDataPoints).toDouble():0,
                            maximum: model.totalPoints.toDouble(),
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
                color: Color.fromARGB(255, 35, 105, 93),
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
                          legendItemText: model.magnetic_field_strength.toString(),
                          onRendererCreated:
                              (ChartSeriesController controller) {
                            _chartSeriesController = controller;
                          },
                          dataSource: model.getOrderedValues(),
                          xValueMapper: (LiveData value, _) => value.time,
                          yValueMapper: (LiveData value, _) =>
                              value.magnetic_field_strength,
                        ),
                       
                      ],
                      primaryXAxis: NumericAxis(
                          isVisible: true,
                          majorGridLines: const MajorGridLines(width: 0),
                          edgeLabelPlacement: EdgeLabelPlacement.shift,
                          minimum: model.totalPoints > model.maxDataPoints? (model.totalPoints - model.maxDataPoints).toDouble():0,
                          maximum: model.totalPoints.toDouble(),
                          // interval: 3,
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
                color: Color.fromARGB(255, 35, 105, 93),
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
                          legendItemText: model.power_density.toString(),
                          onRendererCreated:
                              (ChartSeriesController controller) {
                            _chartSeriesController = controller;
                          },
                          dataSource: model.getOrderedValues(),
                          xValueMapper: (LiveData value, _) => value.time,
                          yValueMapper: (LiveData value, _) =>
                              value.power_density,
                        ),
                       
                      ],
                      primaryXAxis: NumericAxis(
                          isVisible: true,
                          majorGridLines: const MajorGridLines(width: 0),
                          edgeLabelPlacement: EdgeLabelPlacement.shift,
                          // 
                          minimum: model.totalPoints > model.maxDataPoints? (model.totalPoints - model.maxDataPoints).toDouble():0,
                          maximum: model.totalPoints.toDouble(),
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
                color: Color.fromARGB(255, 35, 105, 93),
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
                          legendItemText: model.electric_field_strength.toString(),
                          onRendererCreated:
                              (ChartSeriesController controller) {
                            _chartSeriesController = controller;
                          },
                          dataSource: model.getOrderedValues(),
                          xValueMapper: (LiveData value, _) => value.time,
                          yValueMapper: (LiveData value, _) =>
                              value.electric_field_strength,
                        ),
                        
                      ],
                      primaryXAxis: NumericAxis(
                          isVisible: true,
                          majorGridLines: const MajorGridLines(width: 0),
                          edgeLabelPlacement: EdgeLabelPlacement.shift,
                          // interval: 3,
                          minimum: model.totalPoints > model.maxDataPoints? (model.totalPoints - model.maxDataPoints).toDouble():0,
                          maximum: model.totalPoints.toDouble(),
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
              padding: EdgeInsets.all(10),
              
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 35, 105, 93)),
              child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("• For the general public: The ICNIRP recommends a limit of 200 µT for continuous exposure at 50/60 Hz",
                      style: TextStyle(color: Colors.white), 
                      ),
                      SizedBox(height: 5,),
                      Text( '• For occupational exposure: The limit is higher, at 1,000 µT.',
                    style: TextStyle(color: Colors.white)),
                    SizedBox(height: 5),
                  Text(
                    '• These limits are set to protect against known adverse health effects.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '• Note: Exposure to EMF below these levels is not known to cause health problems.',
                    style: TextStyle(color: Colors.white),
                  ),

                    ],
                  )),
            )
          ]),
        ),
      ),
    );
  }
}
