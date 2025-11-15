import 'package:flutter/material.dart';
import '../utilities/app_input_field_widget.dart';

enum HeightType { cm, meter, feetInch}
enum WeightType { kg, lb}

class BMICalculator extends StatefulWidget {

  const BMICalculator({super.key});

  @override
  State<BMICalculator> createState() => _BMICalculatorState();

}

class _BMICalculatorState extends State<BMICalculator> {

  HeightType? heightType = HeightType.cm;
  WeightType? weightType = WeightType.kg;


  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _cmHeightController = TextEditingController();
  final TextEditingController _feetHeightController = TextEditingController();
  final TextEditingController _inchHeightController = TextEditingController();
  final TextEditingController _meterHeightController = TextEditingController();


  String _bmiResult = '';

  String? category;

  Color? categoryColor;


  double? cmToMeter() {

    final  cm = double.tryParse(_cmHeightController.text.trim());

    if (cm == null || cm < 0) return null;

    return cm / 100.0;

  }

  double? feetToMeter() {

    final feet = double.tryParse(_feetHeightController.text.trim());
    final inch = double.tryParse(_inchHeightController.text.trim());

    if (feet == null || feet < 0 || inch == null || inch < 0){

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid data')));

      // Stops the function if null or 0
      return null;

    }

    if(inch >= 12) {

      double temp = feet + (inch ~/12);

      double temp2 = inch % 12;

     setState(() {
       _feetHeightController.text = temp.toInt().toString();
       _inchHeightController.text = temp2.toInt().toString();
     });

    }

    final totalInch = (feet * 12) + inch;

    if (totalInch <= 0){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid data')));
      return null;
    }

    return totalInch * 0.0254;

  }

  double? poundToKg () {

    final kg = double.tryParse(_weightController.text.trim());

    if (kg == null || kg <= 0){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid data')));
      return null;
    }

    return kg * 0.453592;

  }

  void _calculateBMI() {

    final weight = weightType == WeightType.kg ? double.tryParse(_weightController.text.trim()) : poundToKg();
    
    if (weight == null || weight <= 0){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid data')));
      return;
    }

    final meter = heightType == HeightType.cm ? cmToMeter() :
                  heightType == HeightType.meter ? double.tryParse(_meterHeightController.text) : feetToMeter();

    if (meter == null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid data')));
      return;
    }

    final bmi = weight/(meter * meter);

    final cat = categoryResult(bmi);

    final catColor = categoryResultColor(bmi);

    setState(() {
      _bmiResult = bmi.toStringAsFixed(1);
      category = cat;
      categoryColor = catColor;
    });

    FocusScope.of(context).unfocus();

  }

  String categoryResult (double bmi) {

    if (bmi < 18.5){
      return 'Underweight 😵';
    } else if (bmi < 24.9){
      return 'Normal 😃';
    } else if (bmi < 29.9){
      return 'Overweight 😓';
    } else {
      return 'Obese 😣';
    }

  }

  Color categoryResultColor (double bmi) {

    if (bmi < 18.5){
      return Colors.blue;
    } else if (bmi < 25){
      return Colors.green;
    } else if (bmi < 30){
      return Colors.orange;
    } else {
      return Colors.redAccent;
    }

  }

  void clear() {

    setState(() {

      _weightController.clear();
      _cmHeightController.clear();
      _feetHeightController.clear();
      _inchHeightController.clear();
      _meterHeightController.clear();
      _bmiResult = '';
      category = null;

    });
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    _weightController.dispose();
    _cmHeightController.dispose();
    _feetHeightController.dispose();
    _inchHeightController.dispose();
    _meterHeightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('BMI Calculator'),
        centerTitle: true,
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        )
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
        
            crossAxisAlignment: CrossAxisAlignment.start,
        
            children: [
        
              const Text('Select Weight Type'),
        
              const SizedBox(height: 8),
        
              SizedBox(
                width: double.infinity,
                child: SegmentedButton<WeightType>(
        
                  segments: [
        
                    ButtonSegment(
                        value: WeightType.kg,
                        label: const Text('KG'),
                    ),
        
                    ButtonSegment(
                      value: WeightType.lb,
                      label: const Text('LB')
                    )
        
                  ],
        
                  selected: {weightType!},
        
                  onSelectionChanged: (value) {
                    setState(() {
                      weightType = value.first;
                    });
                  },
        
                )
              ),
        
              const SizedBox(height: 8),
        
              const Text('Weight Unit'),
        
              const SizedBox(height: 8),
        
              AppInputField(
                label: weightType == WeightType.kg ? 'Enter your weight (in kg) ' : 'Enter your weight (in lb) ',
                controller: _weightController,
                keyboardType: TextInputType.number,
              ),
        
              const SizedBox(height: 8),
        
              const Text('Select Heigh Type'),
        
              const SizedBox(height: 8),
        
              SizedBox(
                width: double.infinity,
                child: SegmentedButton<HeightType>(

                  style: SegmentedButton.styleFrom(
                    side: const BorderSide(color: Colors.green, width: 2),
                  ),
        
                    segments: [

                      ButtonSegment<HeightType>(
                          value: HeightType.cm,
                          label: const Text('CM'),
                      ),

                      ButtonSegment<HeightType>(
                        value: HeightType.meter,
                        label: const Text('Meter'),
                      ),

                      ButtonSegment<HeightType>(
                        value: HeightType.feetInch,
                        label: const Text('Feet/Inch'),
                      )
                    ],
                    selected: {heightType!},
                    onSelectionChanged: (value) {
                      setState(() {
                        heightType = value.first;
                      });
                    }
        
                ),
              ),
        
              const SizedBox(height: 8),
        
              const Text('Height Unit'),
        
              const SizedBox(height: 8),
        
              if (heightType == HeightType.cm)...[
        
                AppInputField(
                  label: 'Enter your height (in cm) ',
                  controller: _cmHeightController,
                  keyboardType: TextInputType.number,
                ),
        
              ] else if (heightType == HeightType.meter)...[
        
                AppInputField(
                  label: 'Enter your height (in meter) ',
                  controller: _meterHeightController,
                  keyboardType: TextInputType.number,
                  ),
        
              ] else ... [
        
                Row(
                  children: [
        
                    Expanded(
                      child: AppInputField(
                        label: 'Height (in feet) ',
                        controller: _feetHeightController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
        
                    const SizedBox(width: 8),
        
                    Expanded(
                      child: AppInputField(
                        label: 'Height (in inch) ',
                        controller: _inchHeightController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
        
                  ]
        
                ),
        
              ],
        
              const SizedBox(height: 8),
        
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: _calculateBMI,
                    child: const Text('Calculate BMI')
                ),
              ),
        
              const SizedBox(height: 8),
        
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: clear,
                    child: const Text('Clear')
                ),
              ),
        
              const SizedBox(height: 8),
        
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('BMI Result: ', style: const TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold)),
                  if(_bmiResult.isNotEmpty) Text(_bmiResult, style: TextStyle(color: categoryColor, fontSize: 20, fontWeight: FontWeight.bold))
                ],
              ),
        
              const SizedBox(height: 8),
        
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('BMI Category: ', style: const TextStyle( color: Colors.green,fontSize: 20, fontWeight: FontWeight.bold)),
                  if (category != null) Text('$category', style: TextStyle( color: categoryColor,fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
        
            ],
          ),
        ),
      ),

    );

  }

}
