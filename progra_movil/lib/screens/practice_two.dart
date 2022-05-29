import 'package:flutter/material.dart';
import 'package:progra_movil/widgets/widgets.dart';


class PracticeTwoScreen extends StatefulWidget {

  static const String routerName = 'PracticeTwo';

  @override
  State<PracticeTwoScreen> createState() => _PracticeTwoScreenState();
}

class _PracticeTwoScreenState extends State<PracticeTwoScreen> {

  double temperaturaIntroducida = 0.0;
  double temperaturaConvertida = 0.0;
  bool isCelsius = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Practica 2'),
        backgroundColor: Colors.green[800],
      ),
      drawer: SideMenu(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          alignment: Alignment.topCenter,
          color: Colors.grey[200],
          height: 500,
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(30),
          width: double.infinity,
          child: Column(
            children: [
              Text(
                'Conversor de Temperatura',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Introduce la temperatura',
                  labelText: isCelsius ? 'Introduce la temperatura en Fahrenheit ($temperaturaIntroducida)' : 'Introduce la temperatura en Celsius ($temperaturaIntroducida)'
                ),
                onChanged: (value){
                  setState(() {
                    try {
                      temperaturaIntroducida = double.parse(value);
                    } catch (e) {}
                  });
                },
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  isCelsius ? 'Convertir a Celsius' : 'Convertir a Fahrenheit',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              RadioListTile(
                value: true, 
                groupValue: isCelsius, 
                title: Text('Cº'), 
                onChanged: (bool? val) {
                  setState(() {
                    isCelsius = val!;
                  });
                },
              ),
              RadioListTile(
                value: false, 
                groupValue: isCelsius, 
                title: Text('Fº'), 
                onChanged: (bool? value) {
                  setState(() {
                    isCelsius = value!;
                  });
                },
              ),
              ElevatedButton(
                onPressed: (){
                  setState(() {
                    temperaturaConvertida = isCelsius ? (temperaturaIntroducida - 32) / 1.8 : (temperaturaIntroducida * 1.8) + 32;
                    showDialog(
                      context: context, 
                      builder: (context)=>AlertDialog(
                        title: Text('Resultado de la conversion'),
                        content: Text('$temperaturaConvertida'),
                        actions: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: TextButton(
                              onPressed:(){
                                Navigator.pop(context);
                              }, 
                              child: Text('HACER OTRA CONVERSION'),
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: Colors.green
                              ),
                            ),
                          )
                        ],
                      )
                    );
                  }
              );
                }, 
                child: Text('Hacer Conversion'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green
                ),
              )
            ]
          ),
        ),
      )
    );
  }
}