import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class CustomColor {
  static const Color normal = Color(0xFF3AB54A);
  static const Color overweight = Color(0xFFFFEF01);
  static const Color obese = Color(0xFFEF6422);

  static const Color raspberry = Color(0xFFFE0167);
  static const Color cetacean  = Color(0xFF0C1234);
  static const Color yankees = Color(0xFF13193B);
  static const Color unselected = Color(0xFFB7B9C8);
  static const Color selected = Color(0xFFFEFDFF);
  static const Color text = Color(0xFFFCFFFE);

  static Color getBmiColor (double bmiNumber){
    if(bmiNumber >= 2.75) { return CustomColor.overweight;}
    else if(bmiNumber >= 23.0) {return CustomColor.obese;}
    else if(bmiNumber >= 23.0) {return CustomColor.normal;}
    else {return CustomColor.selected;}
  }
}

double onCalculateBMI(double height, int weight) {
  double bmiResult = (weight / pow((height/100), 2));
  String roundDouble = bmiResult.toStringAsExponential(2);
  return double.parse(roundDouble);
}

String onCategorizedBMI(double bmiResult) {
  if (bmiResult >= 40.0) {return 'Obese (Class III)';}
  else if(bmiResult >= 35.0) {return 'Obese (Class II)';}
  else if(bmiResult >= 30.0) {return 'Obese (Class I)';}
  else if(bmiResult >= 25.0) {return 'Overweight (Pre-Obese)';}
  else if(bmiResult >= 18.5) {return 'Normal';}
  else if(bmiResult >= 17.0) {return 'Underweight (Mild Thinness)';}
  else if(bmiResult >= 16.0) {return 'Underweight (Moderate Thinness)';}
  else {return 'Underweight (Severe Thinness)';} 
}

String onCategorizeHealthRisk(double bmiResult) {
  if(bmiResult >= 27.5) {
    return 'High risk of developing, heart disease, high blood pleasure, stroke, diabetes mellitus. Metabolic Syndrom ';
  } 
  else if(bmiResult >= 23.0) { 
    return 'Moderate risk of developing, heart disease, high blood pleasure, stroke, diabetes mellitus.';
  }
  else if( bmiResult >= 18.5) {
    return 'Low Risk (healthy range)';
  }
  else { 
    return 'Possible nutritional deficiency and osteoprosis';
  }
}

Color onCategorizeHealthRiskColor(double bmiResult){
  if(bmiResult >= 27.5) { return CustomColor.overweight;}
  else if(bmiResult >= 23.0) {return CustomColor.obese;}
  else if( bmiResult >= 18.5) {return CustomColor.normal;}
  else {return CustomColor.selected;}
}

class BMIResult {
  String category;
  String risk;
  Color color;

  BMIResult(this.category, this.risk, this.color);

  getBmiResult(double number) => {
    BMIResult(
      onCategorizedBMI(number),
      onCategorizeHealthRisk(number),
      onCategorizeHealthRiskColor(number)
    )
  };

}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'BMI Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _gender = 'male';
  double _height = 160.00;
  int _weight = 63;
  int _age = 20;

  double buttonHeight = 20.00;

  void _ageCounter(bool increase) => {
    setState((() => increase ? 
      _weight < 90 ? _age++ : _age :
        _weight > 18 ? _age-- : _age))
  };

  void _weightCounter(bool increase) => {
    setState((() => increase ? 
      _weight < 200 ? _weight++ : _weight :
        _weight > 40 ? _weight-- : _weight))
  };
  void _genderChange(String selectedGender) => {
    if(_gender != selectedGender){
      setState(() => {
        _gender = selectedGender
      })
    }
  };
  void _heightChange(double value) => {
    setState(() => {
      _height = value
    })
  };

  void _goToSecondPage () => {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MySecondPage(
          bmiResult: onCalculateBMI(_height, _weight),
        )
      )
    )
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.sort_rounded),
        title: Text(widget.title),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[CustomColor.raspberry, CustomColor.yankees]),
          ),
        ),
      ),
      body: Container(
        color:CustomColor.cetacean,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                children: [
                  Expanded(
                    flex:1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: InkWell(
                            splashColor: CustomColor.unselected,
                            onTap: () => _genderChange("male"),
                            child: Card(   
                              color: CustomColor.yankees,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:  <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Icon(
                                      Icons.male, 
                                      size: 72, 
                                      color: _gender == 'male' ? CustomColor.selected : CustomColor.unselected
                                      ),
                                  ),
                                  Text("MALE", 
                                  style: TextStyle(
                                    color: _gender == 'male' ? CustomColor.selected : CustomColor.unselected,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  )
                                ]
                              ),
                            ),
                          )
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => _genderChange("female"),
                            child: Card( 
                              color: CustomColor.yankees,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:  <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Icon(
                                      Icons.female, 
                                      size: 72, 
                                      color: _gender == 'female' ? CustomColor.selected : CustomColor.unselected
                                      ),
                                  ),
                                  Text("FEMALE", 
                                  style: TextStyle(
                                    color: _gender == 'female' ? CustomColor.selected : CustomColor.unselected,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  )
                                ]
                              ),
                            ),
                          )
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex:1,
                    child: Card( 
                        color: CustomColor.yankees,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,                            
                              children:  <Widget>[
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    "HEIGHT",
                                    style: TextStyle(
                                      color: CustomColor.unselected,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '${_height.round()}', 
                                      style: const TextStyle(
                                        color:CustomColor.text,
                                        fontSize: 48
                                      ),
                                    ),
                                     const Padding(
                                      padding:  EdgeInsets.only(bottom: 8),
                                      child:  Text(
                                        "CM",
                                        style: TextStyle(
                                        color:CustomColor.unselected,
                                        fontSize: 14
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top:12),
                                  child: Slider (
                                    min:130.00,
                                    max:200.00,
                                    thumbColor: CustomColor.raspberry,
                                    activeColor: CustomColor.selected,
                                    inactiveColor: CustomColor.unselected,
                                    value: _height, 
                                    onChanged: _heightChange,
                                  )
                                )
                              ]
                            ),
                          )
                        ),
                  ),
                  Expanded(
                    flex:1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                        child: Card( 
                          color: CustomColor.yankees,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  <Widget>[
                                const Padding(
                                    padding: EdgeInsets.only(bottom: 8),
                                    child: Text(
                                      "WEIGHT",
                                      style: TextStyle(
                                        color: CustomColor.unselected,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text(
                                  '$_weight', 
                                  style: const TextStyle(
                                    color:CustomColor.text,
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  <Widget>[
                                    GestureDetector(
                                      onTap:() => _weightCounter(false),
                                      child: SizedBox(
                                        height: 56,
                                        width: 56,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(28)
                                          ),
                                          color: CustomColor.unselected,
                                          child: const Center(
                                            child: Icon(
                                              Icons.remove,
                                              color: CustomColor.text,
                                            ),
                                          )
                                        ),
                                      ),
                                    ),
                                  GestureDetector(
                                    onTap:() => _weightCounter(true),
                                    child: SizedBox(
                                      height: 56,
                                      width: 56,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(28)
                                        ),
                                        color: CustomColor.unselected,
                                        child: const Center(
                                          child: Icon(
                                            Icons.add,
                                            color: CustomColor.text,
                                          ),
                                        )
                                      ),
                                    ),
                                  ),
                                  
                                ],
                              )
                            ]
                          ),
                      ),
                    ),
                      Expanded(
                      child: Card( 
                        color: CustomColor.yankees,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                              children:  <Widget>[
                                const Padding(
                                    padding: EdgeInsets.only(bottom: 8),
                                    child: Text(
                                      "AGE",
                                      style: TextStyle(
                                        color: CustomColor.unselected,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text(
                                  '$_age', 
                                  style: const TextStyle(
                                    color:CustomColor.text,
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  <Widget>[
                                    GestureDetector(
                                      onTap:() => _ageCounter(false),
                                      child: SizedBox(
                                        height: 56,
                                        width: 56,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(28)
                                          ),
                                          color: CustomColor.unselected,
                                          child: const Center(
                                            child: Icon(
                                              Icons.remove,
                                              color: CustomColor.text,
                                            ),
                                          )
                                        ),
                                      ),
                                    ),
                                  GestureDetector(
                                    onTap:() => _ageCounter(true),
                                    child: SizedBox(
                                      height: 56,
                                      width: 56,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(28)
                                        ),
                                        color: CustomColor.unselected,
                                        child: const Center(
                                          child: Icon(
                                            Icons.add,
                                            color: CustomColor.text,
                                          ),
                                        )
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ]
                          ),
                      ),
                    ),
                      ],
                    ),
                  )
                ],
              )
              )
            ),
            SizedBox(
                height: 80.00,
                width: double.infinity,
                child: TextButton(
                  onPressed: _goToSecondPage,
                  style: TextButton.styleFrom(
                    backgroundColor: CustomColor.raspberry,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child:  Text(
                    "CALCULATE YOUR BMI",
                    style: TextStyle(
                      color: CustomColor.text,
                      fontSize: 22
                      ),
                    ),
                    ),
                  ),
                )
            ]
          ),
      )
    );
  }
}

class MySecondPage extends StatefulWidget {
  const MySecondPage({Key? key, required this.bmiResult}): super(key:key);

  final double bmiResult;
  
  @override
  State<MySecondPage> createState() =>_MySecondPageState();
}

class _MySecondPageState extends State<MySecondPage> {


 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){Navigator.pop(context);},
          child: const Icon(Icons.arrow_back),
        ),
        title: const Text("BMI CALCULATOR"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[CustomColor.raspberry, CustomColor.yankees]),
          ),
        ),
      ),
      body: Container(
        color:CustomColor.cetacean,
        child: Column(
          children: [
            Expanded(
              child:Container(
                padding: const EdgeInsets.all(16.0),
                color: CustomColor.cetacean,
                child: Expanded(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex:1,
                        child:Row(
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            Text (
                              "Your Result",
                              style:TextStyle(
                                color: CustomColor.text,
                                fontSize: 48,
                                fontWeight: FontWeight.bold
                              )
                            )
                          ],
                        )
                      ),
                      Expanded(
                        flex:3,
                        child: Card(
                          color: CustomColor.yankees,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget> [
                                Text(
                                  onCategorizedBMI(widget.bmiResult).toUpperCase(),
                                    style: TextStyle(
                                      color: onCategorizeHealthRiskColor(widget.bmiResult),
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold
                                    )
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 48.0),
                                  child: Text(
                                    '${widget.bmiResult}',
                                    style: const TextStyle(
                                      color: CustomColor.text,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 72,
                                    )
                                  )
                                ),
                               Center(
                                 child: Text(
                                  onCategorizeHealthRisk(widget.bmiResult),
                                    style: const TextStyle(
                                      color: CustomColor.unselected,
                                    )
                                ),
                               ),
                              ]
                            )
                          ),
                        )
                      )
                    ]
                  )
                )
              )
            ),
           SizedBox(
                height: 80.00,
                width: double.infinity,
                child: TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: CustomColor.raspberry,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child:  Text(
                    "RE-CALCULATE",
                    style: TextStyle(
                      color: CustomColor.text,
                      fontSize: 22
                      ),
                    ),
                    ),
                  ),
                )
          ],
        )
      )
    );
}
}
