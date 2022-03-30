import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final TextEditingController _controllerAlcool = TextEditingController();
  final TextEditingController _controllerGasolina = TextEditingController();
  String _textoResultado = '';

  void _calcular(){
    double? precoAlcool = double.tryParse(_controllerAlcool.text);
    double? precoGasolina = double.tryParse(_controllerGasolina.text);

    if(precoAlcool == null || precoGasolina == null){
      showAlertDialog(context, "Operação inválida", "Por favor, use o ponto(.) para valores com casas decimais e em números maiores que zero!");
    }else if (_controllerAlcool.text.isEmpty || _controllerGasolina.text.isEmpty){
      showAlertDialog(context, "Operação inválida", "Por favor, informe valores nos campos!");
    }else{
      if((precoAlcool / precoGasolina) >= 0.7){
        setState(() {
          _textoResultado = "Melhor abastecer com gasolina";
        });
      }else{
        setState(() {
          _textoResultado = "Melhor abastecer com álcool";
        });
      }
      _limparCampos();
    }
  }

  void _limparCampos(){
    _controllerAlcool.text = '';
    _controllerGasolina.text = '';
  }

  showAlertDialog(BuildContext context, String titulo, String conteudo){
    Widget okButton = TextButton(
      onPressed: (){
        Navigator.of(context).pop();
      }, 
      child: const Text("Ok")
    );

    AlertDialog alerta = AlertDialog(
      title: Text(titulo),
      content: Text(conteudo),
      actions: [
        okButton
      ],
    );

    showDialog(
      context: context, 
      builder: (BuildContext context){
        return alerta;
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Álcool ou Gasolina"),
        backgroundColor: const Color.fromARGB(255, 0, 3, 189),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget> [
            const Padding(
              padding: EdgeInsets.only(bottom: 32),
              child: Image(image: AssetImage("assets/logo.png")),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 32),
              child: Text(
                "Saiba qual a melhor opção para o abastecimento do seu carro",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Preço Álcool",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 0, 3, 189), width: 2.0),
                  ),
                  floatingLabelStyle: TextStyle(color: Color.fromARGB(255, 0, 3, 189)),
                ),
                controller: _controllerAlcool,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Preço Gasolina",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 0, 3, 189), width: 2.0),
                  ),
                  floatingLabelStyle: TextStyle(color: Color.fromARGB(255, 0, 3, 189)),
                ),
                controller: _controllerGasolina,
              ),
            ),
            ElevatedButton(
              onPressed: _calcular, 
              child: const Text("Calcular"),
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 0, 3, 189),
                padding: const EdgeInsets.all(20)
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                _textoResultado,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}