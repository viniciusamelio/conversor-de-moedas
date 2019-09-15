import 'package:flutter/material.dart';
import 'main.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final realController = TextEditingController();
  final dollarController = TextEditingController();
  final bitcoinController = TextEditingController();

  double dollar,
         bitcoin;

  void realChanged(String text)
  {
    double real = double.parse(text);
    dollarController.text = (real/dollar).toStringAsFixed(2);
    bitcoinController.text = (real/bitcoin).toStringAsFixed(2);
  }

  void dollarChanged(String text)
  {
    double dollar = double.parse(text);
    realController.text = (dollar * this.dollar).toStringAsFixed(2);
    bitcoinController.text = ((dollar * this.dollar)/bitcoin).toStringAsFixed(2);
  }

  void bitcoinChanged(String text)
  {
    double bitcoin = double.parse(text);
    realController.text = (bitcoin * this.bitcoin).toStringAsFixed(2);
    dollarController.text = ((bitcoin * this.bitcoin)/dollar).toStringAsFixed(2);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Conversor de moeda\$"),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (context,snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                    child: Text("Carregando dados!",textAlign: TextAlign.center,style: TextStyle(color: Colors.orange,fontSize: 25))
                  );

              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Erro ao carregar dados!",textAlign: TextAlign.center,style: TextStyle(color: Colors.orange,fontSize: 25))
                  );
                }else{
                  dollar = snapshot.data["USD"]["buy"];
                  bitcoin = snapshot.data["BTC"]["buy"];
                  return SingleChildScrollView(                          
                          padding: EdgeInsets.only(top:10,left:20,right:20),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              buildInput("Reais","R\$ ",realController,realChanged),
                              buildInput("Dólares","\$ ",dollarController,dollarChanged),
                              buildInput("Bitcoins","BTC ",bitcoinController,bitcoinChanged),
                            ],
                          ),
                          )
                        );
                }                
            }
          },
        ),
    );
  }
}

buildInput(String labelText,String prefix, TextEditingController controller,Function function)
{
  return Padding(
                  padding: EdgeInsets.only(top:10),
                  child: TextField(   
                          controller: controller,
                          keyboardType: TextInputType.numberWithOptions(),                                 
                          decoration: InputDecoration(
                          labelStyle: TextStyle(color:Colors.grey),
                          labelText: labelText,
                          prefix: Text(prefix),
                          ),
                          onChanged: function,
                        )
                );
}