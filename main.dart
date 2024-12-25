import 'package:flutter/material.dart';

void main() {
  runApp(BmrTdeeCalculatorApp());
}

class BmrTdeeCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BmrTdeeCalculator(),
    );
  }
}

class BmrTdeeCalculator extends StatefulWidget {
  @override
  _BmrTdeeCalculatorState createState() => _BmrTdeeCalculatorState();
}

class _BmrTdeeCalculatorState extends State<BmrTdeeCalculator> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  String gender = "male"; // Default gender
  String activityLevel = "1.2"; // Default activity level
  double? bmr;
  double? tdee;

  void calculateBmrTdee() {
    final int age = int.tryParse(ageController.text) ?? 0;
    final double weight = double.tryParse(weightController.text) ?? 0;
    final double height = double.tryParse(heightController.text) ?? 0;

    if (age > 0 && weight > 0 && height > 0) {
      setState(() {
        if (gender == "male") {
          bmr = 66 + (13.7 * weight) + (5 * height) - (6.8 * age);
        } else {
          bmr = 665 + (9.6 * weight) + (1.8 * height) - (4.7 * age);
        }
        tdee = bmr! * double.parse(activityLevel);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('assets/B.png'),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Gender: "),
                  Row(
                    children: [
                      Radio(
                        value: "male",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                          });
                        },
                      ),
                      Text("Male"),
                      Radio(
                        value: "female",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                          });
                        },
                      ),
                      Text("Female"),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter age (years)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter weight (kg)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter height (cm)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: activityLevel,
                items: [
                  DropdownMenuItem(value: "1.2", child: Text("No Exercise")),
                  DropdownMenuItem(
                      value: "1.375",
                      child: Text("Light Exercise (1-3 days/week)")),
                  DropdownMenuItem(
                      value: "1.55",
                      child: Text("Moderate Exercise (4-5 days/week)")),
                  DropdownMenuItem(
                      value: "1.7",
                      child: Text("Heavy Exercise (6-7 days/week)")),
                  DropdownMenuItem(
                      value: "1.9", child: Text("Athlete (2 times/day)")),
                ],
                onChanged: (value) {
                  setState(() {
                    activityLevel = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Activity Level",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: calculateBmrTdee,
                  child: Text("Calculate"),
                ),
              ),
              SizedBox(height: 20),
              if (bmr != null && tdee != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("BMR: ${bmr!.toStringAsFixed(2)} cal",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("TDEE: ${tdee!.toStringAsFixed(2)} cal",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
