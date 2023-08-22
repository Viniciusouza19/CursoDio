import 'package:flutter/material.dart';
import 'package:imc_calculator/src/models/Imc.dart';

class HomeImcPage extends StatelessWidget {
  const HomeImcPage({super.key});

  @override
  Widget build(BuildContext context) 
    ValueNotifier<String> displayImc = ValueNotifier<String>('');
    int heigth = 0;
    int weigth = 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('IMC CALCULATOR'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            width: double.maxFinite,
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 4),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black,
                    offset: Offset(5, 2),
                    blurRadius: 10,
                    spreadRadius: 1,
                    blurStyle: BlurStyle.normal),
              ],
            ),
            alignment: Alignment.center,
            child: ValueListenableBuilder(
                valueListenable: displayImc,
                builder: (_, __, ___) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          displayImc.value
                          ,
                          style: const TextStyle(fontSize: 20),textAlign: TextAlign.center,
                        ),
                      ],
                    )),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  weigth = int.parse(value);
                }
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Peso'),
                  suffix: Text('KG')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  heigth = int.parse(value);
                }
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Altura'),
                  suffix: Text('cm')),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Imc imc = Imc(heigth: heigth, width: weigth);
                displayImc.value = 'IMC: ${imc.calculateImc().toStringAsFixed(2)}\n${imc.bmiClasifier()}';
              },
              child: const Text('Calcular'))
        ],
      ),
    );
  }
}
