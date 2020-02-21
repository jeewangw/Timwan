import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatelessWidget {
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
          onPressed: () { Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            );},
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



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  File _selectedFile;
  bool _inProcess = false;
  Position _currentPosition;
  String _currentAddress;

  Widget getImageWidget() {
    if (_selectedFile != null) {
      String currentPos = _currentPosition.toString();
      return Container (
        child: Column (
          children: [ Image.file(
        _selectedFile,
        width: 250,
        height: 250,
        fit: BoxFit.cover,
      ), Text (_currentAddress),
       Text (currentPos),
          ],),);
    } else {
      return Container(
        child: Column (
          children: [Image.asset(
        "assets/placeholder.jpg",
        width: 250,
        height: 250,
        fit: BoxFit.cover,
      ), Text ('Location of the image taken'),
      ],
      ),
      );
    }
  }


   __getCurrentLocation() {

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try{
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
        _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState((){
        _currentAddress = "${place.locality},${place.postalCode},${place.country}";
      });
    } catch (e) {
      print (e);
    }
  }

  getImage(ImageSource source) async {
      this.setState((){
        _inProcess = true;
      });
      File image = await ImagePicker.pickImage(source: source);
      if(image != null){
        __getCurrentLocation();
        File cropped = await ImageCropper.cropImage(
            sourcePath: image.path,
            aspectRatio: CropAspectRatio(
                ratioX: 1, ratioY: 1),
            compressQuality: 100,
            maxWidth: 700,
            maxHeight: 700,
            compressFormat: ImageCompressFormat.jpg,
            androidUiSettings: AndroidUiSettings(
              toolbarColor: Colors.deepOrange,
              toolbarTitle: "RPS Cropper",
              statusBarColor: Colors.deepOrange.shade900,
              backgroundColor: Colors.white,
            )
        );

        this.setState((){
          _selectedFile = cropped;
          _inProcess = false;
        });
      } else {
        this.setState((){
          _inProcess = false;
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              getImageWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                      color: Colors.green,
                      child: Text(
                        "Camera",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        getImage(ImageSource.camera);
                      }),
                  MaterialButton(
                      color: Colors.deepOrange,
                      child: Text(
                        "Device",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        getImage(ImageSource.gallery);
                      })
                ],
              )
            ],
          ),
          (_inProcess)?Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.95,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ):Center()
        ],
      )
    );
  }
}
