import 'dart:async';

import 'package:evaga/config/postavke_uredjaja.dart';
import 'package:evaga/models/status_konekcije.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';

class EmitovanjeTezine extends StatefulWidget {
  const EmitovanjeTezine({
    super.key,
    required this.onStatusChanged,
  });

  final ValueChanged<StatusKonekcije> onStatusChanged;

  @override
  State<EmitovanjeTezine> createState() =>
      EmitovanjeTezineState();
}

class EmitovanjeTezineState
    extends State<EmitovanjeTezine> {
  late StreamSubscription _subscription;
  late IOWebSocketChannel channel;
  String weightText = '---';
  bool prekidacKonekcije = false;
  late PostavkeUredjaja config;
  String _stariIp = '';
  int _stariPort = 0;

  void posaljiPoruku(StatusKonekcije statusKonekcije) {
    final statusKon = statusMapa[statusKonekcije]!;

    widget.onStatusChanged(statusKonekcije);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Row(
          children: [
            Icon(
              statusKon['icon'],
              color: statusKon['color'],
            ),
            SizedBox(width: 8),
            Text(statusKon['poruka']),
          ],
        ),
        backgroundColor: Color.fromRGBO(26, 52, 61, 1),
      ),
    );
  }

  void pokreniPracenje() async {
    final ip = config.ip; // iz PostavkeUredjaja
    final port = config.port;
    // ako je ranije bilo slušanje, otkaži ga

    if (prekidacKonekcije) {
      posaljiPoruku(StatusKonekcije.odvezujeSe);

      await _subscription.cancel();
      await channel.sink.close();

      posaljiPoruku(StatusKonekcije.nijePovezan);
      prekidacKonekcije = false;
      weightText = "---";
      return;
    }

    posaljiPoruku(StatusKonekcije.povezujeSe);

    try {
      //'ws://10.0.0.155:8080',
      channel = IOWebSocketChannel.connect(
        'ws://$ip:$port',
      );

      weightText = "UCITAVANJE...";

      posaljiPoruku(StatusKonekcije.povezan);
      prekidacKonekcije = true;

      _subscription = channel.stream.listen(
        (message) {
          setState(() {
            weightText = parseScaleData(message);
          });
        },
        onError: (error) {
          posaljiPoruku(StatusKonekcije.greska);
        },
        onDone: () {
          posaljiPoruku(StatusKonekcije.nijePovezan);
          weightText = "---";
        },
      );
    } catch (e) {
      posaljiPoruku(StatusKonekcije.greska);
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    channel.sink.close();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Uzimamo konfiguraciju iz Provider-a
    config = context.watch<PostavkeUredjaja>();

    // // Ako se IP ili port promenio, restartuj konekciju
    // if (_stariIp != config.ip ||
    //     _stariPort != config.port) {
    //   _stariIp = config.ip;
    //   _stariPort = config.port;
    //   pokreniPracenje();
    // }
  }

  String removeLeadingZeros(String s) {
    int i = 0;
    while (i < s.length && s[i] == '0') {
      i++;
    }
    // Ako je sve bilo nule → vrati "0"
    return i == s.length ? "0" : s.substring(i);
  }

  String parseScaleData(String data) {
    // if (data.length != 15) return 'Invalid data';

    // Overload / underload
    if (data.substring(9, 11) == 'OL') {
      return 'PREOPTERECENJE';
    }
    if (data.substring(9, 11) == 'LO') {
      return 'VAGA U MINUSU';
    }

    // Normal weighing
    // String type = data[1]; // G ili N
    String weightPart = data
        .substring(2, 9)
        .trim(); // uklanja blank
    // String unit = data.substring(9, 11); // kg
    return removeLeadingZeros(weightPart);
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return Text(
      weightText,
      textAlign: TextAlign.center,
      style: orientation == Orientation.portrait
          ? Theme.of(
              context,
            ).textTheme.displayLarge!.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSecondary,
            )
          : Theme.of(
              context,
            ).textTheme.displayLarge!.copyWith(
              fontSize: 150,
              color: Theme.of(
                context,
              ).colorScheme.onSecondary,
            ),
    );
  }
}
