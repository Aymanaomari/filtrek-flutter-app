import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

enum GymAmenitiesEnum {
  coffee,
  swimPool,
  massage,
  parking,
  freeWifi,
  garden,
}

class AmenityIcon extends StatelessWidget {
  final GymAmenitiesEnum amenity;
  const AmenityIcon.coffee({Key? key})
      : amenity = GymAmenitiesEnum.coffee,
        super(key: key);
  const AmenityIcon.swimPool({Key? key})
      : amenity = GymAmenitiesEnum.swimPool,
        super(key: key);
  const AmenityIcon.massage({Key? key})
      : amenity = GymAmenitiesEnum.massage,
        super(key: key);
  const AmenityIcon.parking({Key? key})
      : amenity = GymAmenitiesEnum.parking,
        super(key: key);
  const AmenityIcon.freeWifi({Key? key})
      : amenity = GymAmenitiesEnum.freeWifi,
        super(key: key);
  const AmenityIcon.garden({Key? key})
      : amenity = GymAmenitiesEnum.garden,
        super(key: key);
  const AmenityIcon._({required this.amenity, Key? key}) : super(key: key);

  factory AmenityIcon.fromName(String name, {Key? key}) {
    GymAmenitiesEnum amenity;
    switch (name) {
      case 'coffee':
        amenity = GymAmenitiesEnum.coffee;
        break;
      case 'swimPool':
        amenity = GymAmenitiesEnum.swimPool;
        break;
      case 'massage':
        amenity = GymAmenitiesEnum.massage;
        break;
      case 'parking':
        amenity = GymAmenitiesEnum.parking;
        break;
      case 'freeWifi':
        amenity = GymAmenitiesEnum.freeWifi;
        break;
      case 'garden':
        amenity = GymAmenitiesEnum.garden;
        break;
      default:
        amenity = GymAmenitiesEnum.coffee;
    }
    return AmenityIcon._(amenity: amenity, key: key);
  }

  IconData get _icon {
    switch (amenity) {
      case GymAmenitiesEnum.coffee:
        return Icons.coffee_outlined;
      case GymAmenitiesEnum.swimPool:
        return Icons.pool_outlined;
      case GymAmenitiesEnum.massage:
        return Icons.spa_outlined;
      case GymAmenitiesEnum.parking:
        return Icons.local_parking_outlined;
      case GymAmenitiesEnum.freeWifi:
        return Icons.wifi_outlined;
      case GymAmenitiesEnum.garden:
        return Icons.park_outlined;
    }
  }

  String get _label {
    switch (amenity) {
      case GymAmenitiesEnum.coffee:
        return "Coffee";
      case GymAmenitiesEnum.swimPool:
        return "Swim Pool";
      case GymAmenitiesEnum.massage:
        return "Massage";
      case GymAmenitiesEnum.parking:
        return "Parking";
      case GymAmenitiesEnum.freeWifi:
        return "Free Wifi";
      case GymAmenitiesEnum.garden:
        return "Garden";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 68,
          width: 68,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(99),
              color: ColorScheme.of(context).secondary),
          child: Icon(
            _icon,
            color: ColorScheme.of(context).onSecondary,
            size: 32,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _label,
          style: AppTypography.body2
              .copyWith(color: ColorScheme.of(context).tertiary),
        )
      ],
    );
  }
}
