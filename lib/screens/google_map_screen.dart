
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:my_multivender_ecommerce_app/screens/confirmation_screen.dart';
import 'package:my_multivender_ecommerce_app/screens/main_screen.dart';

class MapScreen extends StatefulWidget {
  final bool? detailScreen;
  const  MapScreen({
    Key? key,
    this.detailScreen,
  }) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  final store = GetStorage();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
      LocationData? _currentPosition;
    LatLng? _latLng;
      bool _locating = false;
      geocoding.Placemark?_placemark;
          
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );



  @override
  void initState() {
  _getUserLocation();
    super.initState();
  }

  Future<LocationData> _getLocationPermission() async{

    Location location = new Location();
   

bool _serviceEnabled;
PermissionStatus _permissionGranted;
LocationData _locationData;

_serviceEnabled = await location.serviceEnabled();
if (!_serviceEnabled) {
  _serviceEnabled = await location.requestService();
  if (!_serviceEnabled) {
    return Future.error('Service not enabled');
  }
}
_permissionGranted = await location.hasPermission();
if (_permissionGranted == PermissionStatus.denied) {
  _permissionGranted = await location.requestPermission();
  if (_permissionGranted != PermissionStatus.granted) {
    return Future.error('Permission Denied');
  }
}

_locationData = await location.getLocation();
    return _locationData;
  }

  _getUserLocation()async{
    _currentPosition = await _getLocationPermission();
    _goToCurrentPosition(LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!));
  }

  getUserAddress()async{
    List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(_latLng!.latitude, _latLng!.longitude);
    setState(() {
      _placemark =  placemarks.first;
    });
  }


  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
       body: 
         SingleChildScrollView(
           child: Column(
             children: [
               Stack(
                 children:[ 
                  Container(
                  height: MediaQuery.of(context).size.height*.75,
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
                   child: Stack (
                     children: [
                       GoogleMap(
                        myLocationButtonEnabled: true,
                        compassEnabled: false,
                        myLocationEnabled: true,
                         mapType: MapType.hybrid,
                       initialCameraPosition: _kGooglePlex,
                         onMapCreated: (GoogleMapController controller) {
                           _controller.complete(controller);
                         },
                         onCameraMove: (CameraPosition position){
                          setState(() {
                            _locating =true;
                            _latLng = position.target;
                          });
                         },
                         onCameraIdle: () {
                           setState(() {
                             _locating = false;
                           });
         
                           getUserAddress();
                         },
                       ),
                            const Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.black12,
                      child: Icon(Icons.location_on, size:  40, color: Colors.amber,)))
                         , IconButton(onPressed: (){
                           
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>const MainScreen( )));
                         }, icon: Icon( IconlyBold.arrowLeft))
                     ],
                   ),
                 ),

                 
                
                ],
               ),
               Padding(
                 padding: const EdgeInsets.all(20),
                 child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
         
                   children: [
                  _placemark!=null ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_locating ? 'Locating': _placemark!.locality!),
                      const SizedBox(height: 8,),
                      
                     _placemark!.subLocality!=null? Text('${_placemark!.subLocality!},'): Container(),
                    
                     Row(
                       children: [
                         Text( _placemark!.subAdministrativeArea!=null ?'${_placemark!.subAdministrativeArea!},':''),
                       ],
                     ) ,
                    ],
                  ): Container(),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(child: ElevatedButton(onPressed: () {
                        String _subLocal = _placemark!.subLocality!;
                        String _locality =  _placemark!.locality!;
                        String _adminArea = _placemark!.administrativeArea!;
                        String _subAdminArea = _placemark!.subAdministrativeArea!;
                        String _country = _placemark!.country!;
                        String _pin = _placemark!.postalCode!;
                        String address = '$_subLocal$_locality$_adminArea$_subAdminArea$_country$_pin';
                        store.write('address', address);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const ConfirmationScreen( )));
                      }, child: const Text('Confirm Location'),))
                    ],
                  )
                   ],
                 ),
               )
             ],
           ),
         ),
       
      ),
    );
  }

  Future<void> _goToCurrentPosition(LatLng latLng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(latLng.latitude, latLng.longitude),
      // tilt: 59.440717697143555,
      zoom: 14.4746)));
  }
}