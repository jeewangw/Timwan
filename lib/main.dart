import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var title = 'Trash Clean Up Coordination App';

    return MaterialApp(
      title: title,
      home: Scaffold(
      //  appBar: AppBar(
       //   centerTitle: true,
       //   title: Text(title, style:TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
      //  ),
    body: Stack(
  children: [
    Container(
    margin: const EdgeInsets.all(0.0),
    color: Colors.green[300],
    width: 400.0,
    height: 380.0,
     ),
     Align(
      alignment: Alignment(-0.7, 0),
      child: Container(
      margin: const EdgeInsets.all(10.0),
      color: Colors.brown[200],
      width: 280.0,
      height: 280.0,
       ),
     ),
     Align(
      alignment: Alignment(1, -0.7),
      child: Container(
    margin: const EdgeInsets.all(10.0),
    color: Colors.blue[300],
    width: 250.0,
    height: 240.0,
     ),
     ),
     Align(
      alignment: Alignment(0,-0.3),
      child: Text( "Timwan", style: TextStyle(fontSize: 47,color: Colors.white,    shadows: <Shadow>[
      Shadow(
        offset: Offset(5.0, 5.0),
        blurRadius: 3.0,
        color: Color.fromARGB(255, 0, 0, 0),
      ),
      Shadow(
        offset: Offset(5.0, 5.0),
        blurRadius: 8.0,
        color: Color.fromARGB(125, 0, 0, 255),
      ),
    ], ),
     ),
     ),
     Align(
      alignment: Alignment(0,-0.1),
      child: Text( "Super Trash CleanUp App", style: TextStyle(fontSize: 17,color: Colors.white, 
      shadows: <Shadow>[
      Shadow(
        offset: Offset(0, 0),
        blurRadius: 3.0,
        color: Color.fromARGB(255, 0, 0, 0),
      ),
      Shadow(
        offset: Offset(5.0, 5.0),
        blurRadius: 8.0,
        color: Color.fromARGB(125, 0, 0, 255),
      ),
    ], ),
     ),
     ),
      Align(
      alignment: Alignment(0.1, 0.8),
      child: Container(
      margin: const EdgeInsets.all(0.0),
      color: Colors.grey[300],
      width: 300.0,
      height: 290.0,
      alignment: Alignment(-0.7, -0.8),
      child: Stack(
        children:[
         Align(
         alignment: Alignment(-0.7, -0.8),
          child: Text ("Login", style: TextStyle(color: Colors.blue[900]),),
          ), 
             Align(
         alignment: Alignment(-0.2, -0.8),
          child: Text ("Register"),
          ),
            Align(
      alignment: Alignment(0, 0.8),
      child: Container(
    margin: const EdgeInsets.all(10.0),
    color: Colors.blue[50],
    width: 250.0,
    height: 220.0,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
    TextField(
  obscureText: true,
  decoration: InputDecoration(
    border: OutlineInputBorder(),
    labelText: 'Password',
  ),
),
const SizedBox(height: 30),
        RaisedButton(
          onPressed: () {},
          child: const Text(
            'Login',
            style: TextStyle(fontSize: 10, color: Colors.blue)
          ),
        ),

      ],
    )
     ),
     ),
          ]

      ) ,
     ),
     ),
    
  ],
)
    )
    );
  }
}

