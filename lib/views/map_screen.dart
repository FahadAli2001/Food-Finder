import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:foodfinder/const/images.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapScreen extends StatefulWidget {
  final String keyword;
  const MapScreen({super.key, required this.keyword});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final List<Marker> _markers = <Marker>[];
   
  List<dynamic> _restaurants = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUserCurrentLocation(widget.keyword).then((value) async {
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 14,
      );
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      _markers.add(Marker(
        markerId: const MarkerId("1"),
        position: LatLng(value.latitude, value.longitude),
        icon: BitmapDescriptor.defaultMarker,
      ));
      _fetchNearbyRestaurants(widget.keyword,value.latitude,value.longitude);
      log(widget.keyword);
      setState(() {});
      
    });
  }

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(33.738045, 73.084488),
    zoom: 14,
  );

  Future<Position> getUserCurrentLocation(String keyword) async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      log(error.toString());
    });

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> _fetchNearbyRestaurants(String word,lat,lon) async {
    
  String apikey = 'AIzaSyAl8_GZb77k5io7_DCkAFYJHgGqDnzeH2k'; 
   

  final url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${lat},${lon}&radius=3000&type=restaurant&keyword=$word&key=$apikey';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final results = data['results']; 
    
    setState(() {
      _restaurants.clear(); 
      _restaurants.addAll(results);  
    });
    log(_restaurants[0].toString());
    
  } else {
    print('Error fetching nearby restaurants: ${response.statusCode}');
  }
}


 

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            width: size.width,
            height: size.height,
          ),
          GoogleMap(
            initialCameraPosition: kGooglePlex,
            mapType: MapType.normal,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            trafficEnabled: false,
            rotateGesturesEnabled: true,
            buildingsEnabled: true,
            markers: Set<Marker>.of(_markers),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Positioned(
              top: 55,
              left: 20,
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(blackBackBtn))),
          Positioned(
            top: size.height * 0.55,
            child: Container(
              width: size.width,
              height: size.height * 0.45,
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35))),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Nearby Restaurants",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                 _restaurants.isEmpty?Center(
                  child: Text('No Restaurants',
                  style: TextStyle(
                    color: Colors.white60
                  ),),
                 ):   Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: _restaurants.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: SizedBox(
                              width: size.width,
                              child: ListTile(
                                leading: Image.network(_restaurants[index]['icon']),
                                title: Text(_restaurants[index]['name'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),),
                                subtitle:Text(_restaurants[index]['vicinity'],
                                style: TextStyle(
                                  color: Colors.white,
                                ),),
                              )),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
