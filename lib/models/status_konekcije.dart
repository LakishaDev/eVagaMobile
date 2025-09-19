import 'package:flutter/material.dart';

enum StatusKonekcije {
  povezan,
  povezujeSe,
  nijePovezan,
  odvezujeSe,
  greska,
}

// mapa koja enum povezuje sa ikonama i tekstom
final Map<StatusKonekcije, Map<String, dynamic>>
statusMapa = {
  StatusKonekcije.povezan: {
    'icon': Icons.check_circle,
    'color': Colors.green,
    'label': 'Povezano',
    'poruka': "Uspesno povezivanje sa uredjajem!",
  },
  StatusKonekcije.povezujeSe: {
    'icon': Icons.wifi_find_rounded,
    'color': Colors.lightBlueAccent,
    'label': 'Povezivanje...',
    'poruka': "Povezivanje sa uredjajem zapoceto.",
  },
  StatusKonekcije.odvezujeSe: {
    'icon': Icons.wifi_off,
    'color': Colors.amber,
    'label': 'Povezano',
    'poruka': "Uredjaj se odvezuje.",
  },
  StatusKonekcije.nijePovezan: {
    'icon': Icons.wifi_rounded,
    'color': Colors.orange,
    'label': 'Poveži se',
    'poruka': "Uredjaj je uspesno odvezan!",
  },
  StatusKonekcije.greska: {
    'icon': Icons.error,
    'color': Colors.red,
    'label': 'Greška',
    'poruka': "Pojavila se greska, restartujte aplikaciju!",
  },
};
