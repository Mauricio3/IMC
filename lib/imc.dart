import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Imc extends StatefulWidget {
  @override
  _ImcState createState() => _ImcState();
}

class _ImcState extends State<Imc> {
  final TextEditingController _alturaController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();
  final key = GlobalKey<ScaffoldState>();
  var _resultado = "";
  var _situacao = "";

  _onItemTapped(int index) {
    if(index == 0) {
      _alturaController.clear();
      _pesoController.clear();
      setState(() {
        _resultado = "";
        _situacao = "";
      });
    } else if(_alturaController.text.isEmpty || _pesoController.text.isEmpty) {
      key.currentState.showSnackBar(SnackBar(
          content: Text("Campos peso e altura são obrigatorios."),
      ));
    } else {
      setState(() {
        try {
          var altura = double.parse(_alturaController.text);
          var peso = double.parse(_pesoController.text);
          var imc = peso / (altura * altura);
          _resultado = "Seu IMC é: ${imc.toStringAsFixed(2)}";

          if(imc < 17) {
            _situacao = "Muito abaixo do peso";
          } else if(imc > 17 && imc <= 18.49) {
            _situacao = "Abaixo do peso";
          } else if(imc > 18.49 && imc <= 24.99) {
            _situacao = "Peso normal";
          } else if(imc > 24.99 && imc <= 29.99) {
            _situacao = "Acima do peso";
          } else if(imc > 29.99 && imc <= 34.99) {
            _situacao = "Obesidade I";
          } else if(imc > 34.99 && imc <= 39.99) {
            _situacao = "Obesidade II (severa)";
          } else {
            _situacao = "Obesidade Mórbida III (mórbida)";
          }

        } catch(e) {
          key.currentState.showSnackBar(SnackBar(
              content: Text("Informe os valores de altura e peso corretamente")
          ));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text("Cálculo do Imc"),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
              "assets/balanca.jpg", width: 80),
          TextField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            controller: _alturaController,
            decoration: InputDecoration(
              hintText: "Altura",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0)
              ),
              icon: Icon(Icons.accessibility),
            ),
          ),
          TextField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            controller: _pesoController,
            decoration: InputDecoration(
              hintText: "Peso",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              icon: Icon(Icons.person),
            ),
          ),
          Text("$_resultado", style: TextStyle(fontSize: 30),),
          Text("$_situacao", style: TextStyle(fontSize: 30),),
        ]
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.indigo,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.clear,
                color: Colors.white,
                size: 20,
              ),
              title: Text("Limpar", style: TextStyle(color: Colors.white),),
              ),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 20
              ),
              title: Text("Calcular", style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}
