import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'dart:typed_data';
import 'package:easy_mail_app_frontend/model/addressesModel.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:easy_mail_app_frontend/controller/postManController.dart';

class PlaceMarkerBody extends StatefulWidget {
  const PlaceMarkerBody();
  static const String route = '/postMan/marker';
  @override
  State<StatefulWidget> createState() => PlaceMarkerBodyState();
}

typedef Marker MarkerUpdateAction(Marker marker);

class PlaceMarkerBodyState extends State<PlaceMarkerBody> {
  void initstate() {
    //getLocations();
  }

  PlaceMarkerBodyState();
  static final LatLng center = const LatLng(
      6.500533840690815, 80.12186606879841); //!enter lat lng of the branch

  GoogleMapController? controller;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId? selectedMarker;
  String selectedaddressID = "";
  int _markerIdCounter = 0;
  PostManController postManController = new PostManController();
  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
    getLocations();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onMarkerTapped(MarkerId markerId, String addressID) {
    final Marker? tappedMarker = markers[markerId];
    print("tapped $addressID");
    if (tappedMarker != null) {
      setState(() {
        final MarkerId? previousMarkerId = selectedMarker;

        if (previousMarkerId != null && markers.containsKey(previousMarkerId)) {
          final Marker resetOld = markers[previousMarkerId]!
              .copyWith(iconParam: BitmapDescriptor.defaultMarker);
          markers[previousMarkerId] = resetOld;
        }
        selectedMarker = markerId;
        selectedaddressID = addressID;
        final Marker newMarker = tappedMarker.copyWith(
          iconParam: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
        );
        markers[markerId] = newMarker;
      });
    }
  }

  void _onMarkerDragEnd(
      MarkerId markerId, LatLng newPosition, String addressID) async {
    final Marker? tappedMarker = markers[markerId];
    print("dragging $addressID");
    if (tappedMarker != null) {
      await showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                actions: <Widget>[
                  TextButton(
                    child: const Text('Go back'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
                content: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 66),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Old position: ${tappedMarker.position}'),
                        Text('New position: $newPosition'),
                        Text('press the button to change the address'),
                        IconButton(
                            tooltip: "Save new position",
                            icon: Icon(Icons.check_circle),
                            color: Colors.black,
                            hoverColor: Colors.white,
                            onPressed: () {
                              saveNewLocation(addressID, newPosition);
                              Navigator.of(context).pop();
                            }),
                      ],
                    )));
          });
    }
  }

  void _add() {
    final int markerCount = markers.length;

    if (markerCount == postManController.addresses.length) {
      return;
    }

    final String markerIdVal =
        postManController.addresses[_markerIdCounter].description;
    final String addressID =
        postManController.addresses[_markerIdCounter].addressId;
    _markerIdCounter++;
    final MarkerId markerId = MarkerId(markerIdVal);

    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
          double.parse(postManController.addresses[_markerIdCounter - 1].lat),
          double.parse(postManController.addresses[_markerIdCounter - 1].lng)),
      infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
      onTap: () {
        _onMarkerTapped(markerId, addressID);
      },
      onDragEnd: (LatLng position) {
        _onMarkerDragEnd(markerId, position, addressID);
      },
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  void _createNewAddress() async {
    final int markerCount = markers.length;

    if (markerCount == postManController.addresses.length + 1) {
      return;
    }

    final String markerIdVal = "default";
    final String addressID = "default";
    _markerIdCounter++;
    final MarkerId markerId = MarkerId(markerIdVal);
    await showDialog<List>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              actions: <Widget>[
                TextButton(
                  child: const Text('Go back'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('submit'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
              content: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 66),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(),
                      TextField(),
                      Text('press the button to change the address'),
                    ],
                  )));
        });

    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
          double.parse(postManController.addresses[_markerIdCounter - 1].lat) +
              0.0000025,
          double.parse(postManController.addresses[_markerIdCounter - 1].lng) +
              0.0000025),
      infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
      onTap: () {
        _onMarkerTapped(markerId, addressID);
      },
      onDragEnd: (LatLng position) {
        _onMarkerDragEnd(markerId, position, addressID);
      },
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  void _remove(MarkerId markerId, String addressID) {
    setState(() {
      if (markers.containsKey(markerId)) {
        markers.remove(markerId);
      }
    });
    print("removing $addressID");
    //remove the location
  }

  // void _changePosition(MarkerId markerId) {
  //   final Marker marker = markers[markerId]!;
  //   final LatLng current = marker.position;
  //   final Offset offset = Offset(
  //     center.latitude - current.latitude,
  //     center.longitude - current.longitude,
  //   );
  //   setState(() {
  //     markers[markerId] = marker.copyWith(
  //       positionParam: LatLng(
  //         center.latitude + offset.dy,
  //         center.longitude + offset.dx,
  //       ),
  //     );
  //   });
  // }

  // void _changeAnchor(MarkerId markerId) {
  //   final Marker marker = markers[markerId]!;
  //   final Offset currentAnchor = marker.anchor;
  //   final Offset newAnchor = Offset(1.0 - currentAnchor.dy, currentAnchor.dx);
  //   setState(() {
  //     markers[markerId] = marker.copyWith(
  //       anchorParam: newAnchor,
  //     );
  //   });
  // }

  Future<void> _changeInfoAnchor(MarkerId markerId) async {
    final Marker marker = markers[markerId]!;
    final Offset currentAnchor = marker.infoWindow.anchor;
    final Offset newAnchor = Offset(1.0 - currentAnchor.dy, currentAnchor.dx);
    setState(() {
      markers[markerId] = marker.copyWith(
        infoWindowParam: marker.infoWindow.copyWith(
          anchorParam: newAnchor,
        ),
      );
    });
  }

  Future<void> _toggleDraggable(MarkerId markerId) async {
    final Marker marker = markers[markerId]!;
    setState(() {
      markers[markerId] = marker.copyWith(
        draggableParam: !marker.draggable,
      );
    });
  }

  // Future<void> _toggleFlat(MarkerId markerId) async {
  //   final Marker marker = markers[markerId]!;
  //   setState(() {
  //     markers[markerId] = marker.copyWith(
  //       flatParam: !marker.flat,
  //     );
  //   });
  // }

  Future<void> _changeInfo(MarkerId markerId) async {
    final Marker marker = markers[markerId]!;
    final String newSnippet = marker.infoWindow.snippet! + '*';
    setState(() {
      markers[markerId] = marker.copyWith(
        infoWindowParam: marker.infoWindow.copyWith(
          snippetParam: newSnippet,
        ),
      );
    });
  }

  Future<void> _changeAlpha(MarkerId markerId) async {
    final Marker marker = markers[markerId]!;
    final double current = marker.alpha;
    setState(() {
      markers[markerId] = marker.copyWith(
        alphaParam: current < 0.1 ? 1.0 : current * 0.75,
      );
    });
  }

  // Future<void> _changeRotation(MarkerId markerId) async {
  //   final Marker marker = markers[markerId]!;
  //   final double current = marker.rotation;
  //   setState(() {
  //     markers[markerId] = marker.copyWith(
  //       rotationParam: current == 330.0 ? 0.0 : current + 30.0,
  //     );
  //   });
  // }

  // Future<void> _toggleVisible(MarkerId markerId) async {
  //   final Marker marker = markers[markerId]!;
  //   setState(() {
  //     markers[markerId] = marker.copyWith(
  //       visibleParam: !marker.visible,
  //     );
  //   });
  // }

  // Future<void> _changeZIndex(MarkerId markerId) async {
  //   final Marker marker = markers[markerId]!;
  //   final double current = marker.zIndex;
  //   setState(() {
  //     markers[markerId] = marker.copyWith(
  //       zIndexParam: current == 12.0 ? 0.0 : current + 1.0,
  //     );
  //   });
  // }

  void _setMarkerIcon(MarkerId markerId, BitmapDescriptor assetIcon) {
    final Marker marker = markers[markerId]!;
    setState(() {
      markers[markerId] = marker.copyWith(
        iconParam: assetIcon,
      );
    });
  }

  Future<BitmapDescriptor> _getAssetIcon(BuildContext context) async {
    final Completer<BitmapDescriptor> bitmapIcon =
        Completer<BitmapDescriptor>();
    final ImageConfiguration config = createLocalImageConfiguration(context);

    const AssetImage('assets/red_square.png')
        .resolve(config)
        .addListener(ImageStreamListener((ImageInfo image, bool sync) async {
      final ByteData? bytes =
          await image.image.toByteData(format: ImageByteFormat.png);
      if (bytes == null) {
        bitmapIcon.completeError(Exception('Unable to encode icon'));
        return;
      }
      final BitmapDescriptor bitmap =
          BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
      bitmapIcon.complete(bitmap);
    }));

    return await bitmapIcon.future;
  }

  @override
  Widget build(BuildContext context) {
    final MarkerId? selectedId = selectedMarker;
    final String? selectedAddress = selectedaddressID;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Center(
          child: SizedBox(
            width: 300.0,
            height: 400.0,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: const CameraPosition(
                target: LatLng(6.500533840690815, 80.12186606879841),
                zoom: 11.0,
              ),
              markers: Set<Marker>.of(markers.values),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        TextButton(
                          child: const Text('add Address'),
                          onPressed: _add,
                        ),
                        TextButton(
                          child: const Text('Remove address'),
                          onPressed: selectedId == null
                              ? null
                              : () => _remove(selectedId, selectedaddressID),
                        ),
                        TextButton(
                          child: const Text('change Name'),
                          onPressed: selectedId == null
                              ? null
                              : () => _changeInfo(selectedId),
                        ),
                        TextButton(
                          child: const Text('change info anchor'),
                          onPressed: selectedId == null
                              ? null
                              : () => _changeInfoAnchor(selectedId),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        TextButton(
                          child: const Text('change alpha'),
                          onPressed: selectedId == null
                              ? null
                              : () => _changeAlpha(selectedId),
                        ),
                        TextButton(
                          child: const Text('add new address'),
                          onPressed: selectedId == null
                              ? null
                              : () => _createNewAddress(),
                        ),
                        // TextButton(
                        //   child: const Text('change anchor'),
                        //   onPressed: selectedId == null
                        //       ? null
                        //       : () => _changeAnchor(selectedId),
                        // ),
                        TextButton(
                          child: const Text('Drag Location'),
                          onPressed: selectedId == null
                              ? null
                              : () => _toggleDraggable(selectedId),
                        ),
                        // TextButton(
                        //   child: const Text('toggle flat'),
                        //   onPressed: selectedId == null
                        //       ? null
                        //       : () => _toggleFlat(selectedId),
                        // ),
                        // TextButton(
                        //   child: const Text('change position'),
                        //   onPressed: selectedId == null
                        //       ? null
                        //       : () => _changePosition(selectedId),
                        // ),
                        // TextButton(
                        //   child: const Text('change rotation'),
                        //   onPressed: selectedId == null
                        //       ? null
                        //       : () => _changeRotation(selectedId),
                        // ),
                        // TextButton(
                        //   child: const Text('toggle visible'),
                        //   onPressed: selectedId == null
                        //       ? null
                        //       : () => _toggleVisible(selectedId),
                        // ),
                        // TextButton(
                        //   child: const Text('change zIndex'),
                        //   onPressed: selectedId == null
                        //       ? null
                        //       : () => _changeZIndex(selectedId),
                        // ),
                        // TextButton(
                        //   child: const Text('set marker icon'),
                        //   onPressed: selectedId == null
                        //       ? null
                        //       : () {
                        //           _getAssetIcon(context).then(
                        //             (BitmapDescriptor icon) {
                        //               _setMarkerIcon(selectedId, icon);
                        //             },
                        //           );
                        //         },
                        // ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future getLocations() async {
    //print("calling the frontend function");
    await postManController.getLocations();
    for (var i = 0; i <= postManController.addresses.length; i++) {
      _add();
    }
  }

  Future saveNewLocation(String addressID, LatLng newPosition) async {
    //print(newPosition.latitude.toString());
    //print(newPosition.longitude.toString());
    var msg = await postManController.editLocation(addressID, newPosition);
    print(msg);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$msg')));
  }

  Future addNewAddress(String details, LatLng position) async {
    //var msg = await postManController.addLocation(address);
  }
}