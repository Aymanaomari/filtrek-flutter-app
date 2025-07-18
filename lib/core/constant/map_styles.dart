class MapStyles {
  static const styleOne = ''' [
    {
      "featureType": "all",
      "elementType": "geometry",
      "stylers": [
        {"visibility": "simplified"}
      ]
    },
    {
      "featureType": "landscape",
      "elementType": "geometry",
      "stylers": [
        {"visibility": "on"}
      ]
    },
    {
      "featureType": "landscape",
      "elementType": "geometry.fill",
      "stylers": [
        {"weight": "1.44"},
        {"visibility": "on"},
        {"color": "#969696"}
      ]
    },
    {
      "featureType": "poi",
      "elementType": "geometry",
      "stylers": [
        {"visibility": "on"},
        {"color": "#d1f07f"}
      ]
    },
    {
      "featureType": "poi",
      "elementType": "labels",
      "stylers": [
        {"visibility": "on"}
      ]
    },
    {
      "featureType": "poi",
      "elementType": "labels.text",
      "stylers": [
        {"visibility": "off"},
        {"weight": "0.04"}
      ]
    },
    {
      "featureType": "road.highway.controlled_access",
      "elementType": "geometry",
      "stylers": [
        {"visibility": "on"}
      ]
    },
    {
      "featureType": "road.highway.controlled_access",
      "elementType": "geometry.fill",
      "stylers": [
        {"hue": "#002bff"}
      ]
    },
    {
      "featureType": "road.arterial",
      "elementType": "geometry.fill",
      "stylers": [
        {"hue": "#00ff26"}
      ]
    },
    {
      "featureType": "road.local",
      "elementType": "geometry",
      "stylers": [
        {"visibility": "on"}
      ]
    },
    {
      "featureType": "road.local",
      "elementType": "geometry.fill",
      "stylers": [
        {"color": "#ccdac7"}
      ]
    },
    {
      "featureType": "transit",
      "elementType": "geometry",
      "stylers": [
        {"visibility": "on"}
      ]
    },
    {
      "featureType": "transit.line",
      "elementType": "geometry.fill",
      "stylers": [
        {"hue": "#ff0000"}
      ]
    },
    {
      "featureType": "transit.station.airport",
      "elementType": "geometry.fill",
      "stylers": [
        {"hue": "#b7ff00"}
      ]
    }
  ];''';
}
