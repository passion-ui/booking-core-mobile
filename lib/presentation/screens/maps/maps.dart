import 'dart:async';

import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  final GPSEntity? item;

  const Maps({super.key, this.item});

  @override
  State<Maps> createState() {
    return _MapsState();
  }
}

class _MapsState extends State<Maps> {
  CameraPosition _initPosition = const CameraPosition(
    target: LatLng(37.3325932, -121.9129757),
    zoom: 12,
  );
  final _controller = Completer<GoogleMapController>();
  Map<MarkerId, Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _initPosition = CameraPosition(
        target: LatLng(widget.item!.latitude, widget.item!.longitude),
        zoom: widget.item!.zoom,
      );
      _onSetMarker(
        latitude: widget.item!.latitude,
        longitude: widget.item!.longitude,
        title: widget.item!.title,
      );
    }
  }

  @override
  void dispose() {
    _controller.future.then((value) => value.dispose());
    super.dispose();
  }

  ///On Apply
  void _onApply() {
    if (_markers.values.isNotEmpty) {
      final position = _markers.values.first.position;
      final item = GPSEntity(
        title: '',
        latitude: position.latitude,
        longitude: position.longitude,
      );
      Navigator.pop(context, item);
    }
  }

  ///On set marker
  void _onSetMarker({
    required double latitude,
    required double longitude,
    required String title,
    double? zoom,
  }) async {
    Map<MarkerId, Marker> markers = {};
    final markerId = MarkerId('$latitude/$longitude');
    final position = LatLng(latitude, longitude);
    final Marker marker = Marker(
      markerId: markerId,
      position: position,
      infoWindow: InfoWindow(title: title),
    );

    markers[markerId] = marker;
    setState(() {
      _markers = markers;
    });
    await Future.delayed(const Duration(milliseconds: 250));
    final controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: position,
          tilt: 30.0,
          zoom: zoom ?? 12.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget>? actions;
    bool editable = widget.item == null || widget.item?.editable == true;

    if (editable || true) {
      actions = [
        Row(
          children: [
            Expanded(
              child: FilledButton(
                onPressed: _onApply,
                child: Text(
                  Translate.of(context).translate('apply'),
                ),
              ),
            ),
          ],
        )
      ];
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('location'),
        ),
      ),
      body: SafeArea(
        child: GoogleMap(
          onMapCreated: (controller) {
            _controller.complete(controller);
          },
          initialCameraPosition: _initPosition,
          markers: Set<Marker>.of(_markers.values),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          onTap: (item) {
            if (editable) {
              _onSetMarker(
                latitude: item.latitude,
                longitude: item.longitude,
                title: '${item.latitude}/${item.longitude}',
              );
            }
          },
        ),
      ),
      persistentFooterButtons: actions,
    );
  }
}
