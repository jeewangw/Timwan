import 'dart:io';
import 'dart:async';
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
  File _selectedFile;         //  Image
  bool _inProcess = false;
  static double latitude;
  static double longitude;
   Position _currentPosition;

   int show = 0;
   
  static String _currentAddress;

  Widget getImageWidget() {
    if (_selectedFile != null) {
      String currentPos = _currentPosition.toString();
      return Container (
        child: Column (
          children: [ Image.file(       //Image File
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
        longitude = position.longitude;
        latitude = position.latitude;
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
        show = 1;
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

        //FORM 

        _showDialog();

      } else {
        this.setState((){
          _inProcess = false;
        });
      }
  }

   void _showModalSheet() {      //SHOW MODAL SHEET Warning Text
    showModalBottomSheet(context: context, builder: (builder) {
      return Container(       
        child: Text ("No image is uploaded to track"),
        padding: EdgeInsets.all(40.0),
      );
    });
  }

  // Report Form
  void _showDialog() {
    showModalBottomSheet(isDismissible: false,context: context, builder: (builder) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
              ),
    TextField(
  obscureText: false,
  decoration: InputDecoration(
    border: OutlineInputBorder(),
    labelText: 'Description',
  ),
),
const SizedBox(height: 30),
        RaisedButton(
          onPressed: () { 
            Navigator.pop(context);
          },
          child: const Text(
            'Submit',
            style: TextStyle(fontSize: 10, color: Colors.blue)
          ),
        ),

      ],
    );
    });
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
                      color: Colors.blue,
                      child: Text(
                        "Track in Map",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (show == 1) {

                       Navigator.push(
                      context,
                       MaterialPageRoute(builder: (context) => new MapSample()
                        ));
                        }
                        else {
                          _showModalSheet();
                          print ('No Picture is clicked!!');
                        }

                        }
                      ),
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

class MapSample extends StatefulWidget {


  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {

static double latty = _MyHomePageState.latitude;    // Latitude
static double longy = _MyHomePageState.longitude;   // Longitude

List <Marker> allMarkers = [];

@override
void initState(){
  super.initState();
  allMarkers.add(Marker(
    markerId: MarkerId('myMarker'),
    infoWindow: InfoWindow(
      title: 'Photo was taken at this position',
      snippet: 'Trash',
    ),
    
    draggable: false,
    onTap: () {  
      _showModalSheet();                   //Marker On Tap
      print('Marker Tapped');
    },
    position: LatLng(latty,longy)
  ));
}

 void _showModalSheet() {      //SHOW MODAL SHEET
    showModalBottomSheet(context: context, builder: (builder) {
      return Container(       
        child: Image.network('https://i.stack.imgur.com/ilEcY.png'), // Get Trash pic from database
        padding: EdgeInsets.all(40.0),
      );
    });
  }

  Completer<GoogleMapController> _controller = Completer();
  

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(latty, longy),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        markers: Set.from(allMarkers),
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          print ("lattitude is $latty");
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    print ("lattitude is $latty");
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}