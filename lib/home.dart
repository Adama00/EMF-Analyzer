import 'package:emf_analyzer/models/magnitudeProvider.dart';
import 'package:emf_analyzer/pages/visuals.dart';
import 'package:emf_analyzer/utils/colors.dart';
import 'package:emf_analyzer/widgets/mainReading.dart';
import 'package:emf_analyzer/widgets/meterReading.dart';
import 'package:emf_analyzer/widgets/xyzReading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MeterReading(),
              XYZReading(),
              
              MainReading(),
              Container(
                width: 200,
                height: 50,
                margin: EdgeInsets.only(bottom: 10),
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                      side: BorderSide(color: Colors.white),
                    )),
                    backgroundColor: WidgetStateProperty.all(AppColors.primaryColor),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Visuals()));
                  },
                  child: Text('Visualize', style: TextStyle(color: Colors.white),),
                ),
              ),
              Consumer<MagnitudeProvider>(
                builder: (context, model, child) => Container(
                  width: 200,
                  height: 50,
                  margin: EdgeInsets.only(bottom: 10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side: BorderSide(color: Colors.white),
                      )),
                      backgroundColor: WidgetStateProperty.all(AppColors.primaryColor),
                    ),
                    onPressed: () {
                      if (model.isReading) {
                        model.stopUpdates();
                      } else {
                        model.changeValues();
                      }
                    },
                    child: Text(model.isReading ? 'Stop' : 'Start', style: TextStyle(color: Colors.white) ,),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}