import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gulf_sky_provider/features/presentation/shared_widgets/custom_rounded_button.dart';

import '../../../../core/utils/app_colors.dart';


class MapView extends StatefulWidget {
  final LatLng? initialPosition;
  final Function(LatLng) onBack;
  final bool isEditable;

  const MapView({
    Key? key,
    this.initialPosition,
    required this.onBack,
    this.isEditable = true,
  }) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late CameraPosition initialPosition;

  final Completer<GoogleMapController> mapController = Completer<GoogleMapController>();

  late ValueNotifier<Marker> marker;

  @override
  void initState() {
    initialPosition = CameraPosition(
      target: LatLng(
        widget.initialPosition?.latitude ?? 24.2593848177775,
        widget.initialPosition?.longitude ?? 44.88972298800945,
      ),
      zoom: 8,
    );
    marker = ValueNotifier(Marker(
      markerId: const MarkerId(
        '1',
      ),
      position: LatLng(
        widget.initialPosition?.latitude ?? 24.2593848177775,
        widget.initialPosition?.longitude ?? 44.88972298800945,
      ),
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: marker,
        builder: (context, val, child) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              GoogleMap(
                mapType: MapType.normal,
                zoomControlsEnabled: false,
                initialCameraPosition: initialPosition,
                markers: {
                  marker.value,
                },
                onMapCreated: (GoogleMapController controller) {
                  if (!mapController.isCompleted) {
                    mapController.complete(controller);
                  }
                },
                onTap: !widget.isEditable ? null : (latLng) {
                  marker.value = Marker(
                    markerId: const MarkerId(
                      '1',
                    ),
                    position: latLng,
                  );
                },
              ),
              if (widget.isEditable)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomRoundedButton(
                  label: AppLocalizations.of(context)!.save,
                  onPressed: () {
                    widget.onBack(marker.value.position);
                    GoRouter.of(context).pop();
                  },
                  color: AppColors.orange,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
