import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddressLocation extends StatefulWidget {
  const AddressLocation({Key? key}) : super(key: key);
  static const String route = '/postMan/address_location';
  @override
  _AddressLocationState createState() => _AddressLocationState();
}

class _AddressLocationState extends State<AddressLocation> {
  LatLng _initialcameraposition = LatLng(6.500533840690815, 80.12186606879841);
  //GoogleMapController _controller;
  late GoogleMapController _controller;
  Location _location = Location();
  Set<Marker> _markers = Set();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: _initialcameraposition, zoom: 15),
              mapType: MapType.normal,

              //onMapCreated: _onMapCreated,

              onTap: (LatLng latLng) {
                _markers.add(Marker(
                    markerId: MarkerId('mark'),
                    //onTap: tapped(),
                    //icon: BitmapDescriptor.defaultMarker(),
                    position: latLng));
                setState(() {});
                print(latLng.toString());
              },
              markers: Set<Marker>.of(markers.values),
              myLocationEnabled: true,
            ),
          ],
        ),
      ),
    );
  }

  void tapped() async {
    print("tapped");
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 15),
        ),
      );
      print(l);
    });
  }

  //void _tapped(LatLng latlang) {}
}
