import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {


  static const LatLng showLocation =  LatLng(21.613795, 39.149478); //location to show in map

  MapType _currentMapType = MapType.normal;

  void changeMapType() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  final Set<Marker> markers = {};
  late GoogleMapController mapController;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Store"),
        leading: Container(),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition: const CameraPosition(
                target: showLocation,
              zoom:  15.0,
            ),
            mapType: _currentMapType,
            markers: getmarkers(),
            onMapCreated: (controller){
              setState(() {
                mapController = controller ;
              });
            },
          ),
          Container(
            padding: const EdgeInsets.only(top: 24, right: 12),
            alignment: Alignment.topRight,
            child: Column(
              children: <Widget>[
                FloatingActionButton(
                  onPressed: changeMapType,
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.map),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                /*FloatingActionButton(
                  onPressed: _addMarker,
                  child: Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                  backgroundColor: Colors.white,
                )*/
              ],
            ),
          )
        ],
      ),
    );
  }
  Set<Marker> getmarkers() { //markers to place on map
    setState(() {
      markers.add(Marker( //add first marker
        markerId: MarkerId(showLocation.toString()),
        position: showLocation, //position of marker
        infoWindow: const InfoWindow( //popup info
          title: 'GHASLAH',
          snippet: 'Car wash',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));
      //add more locations
    });
    return markers ;
    }

        }

