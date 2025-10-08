import 'package:evaga/models/status_konekcije.dart';
import 'package:evaga/screens/config.dart';
import 'package:evaga/widgets/emitovanje_tezine.dart';
import 'package:evaga/widgets/trenutna_tezina.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PocetnaEkran extends StatefulWidget {
  const PocetnaEkran({super.key});

  @override
  State<PocetnaEkran> createState() => _PocetnaEkranState();
}

class _PocetnaEkranState extends State<PocetnaEkran>
    with SingleTickerProviderStateMixin {
  final GlobalKey<EmitovanjeTezineState>
  emitovanjeTezineKey = GlobalKey<EmitovanjeTezineState>();
  StatusKonekcije statusKonekcije =
      StatusKonekcije.nijePovezan;
  bool postavkeStat = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    // ..repeat(reverse: true);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void handleStatusChanged(StatusKonekcije noviStatus) {
    setState(() {
      statusKonekcije = noviStatus;
    });
    print("Status konekcije: $noviStatus");
  }

  void _setUiMode(Orientation orientation) {
    if (orientation == Orientation.landscape) {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.immersiveSticky,
      );
    } else {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.edgeToEdge,
      );
    }
  }

  void otvoriPostavke() async {
    setState(() {
      postavkeStat = true;
    });

    // ukloni prethodne listener-e pre dodavanja
    _controller.removeStatusListener(_onAnimacijaZavrsila);

    _controller.forward(from: 0);

    _controller.addStatusListener(_onAnimacijaZavrsila);
  }

  void _onAnimacijaZavrsila(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        postavkeStat = false;
      });

      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => ConfigScreen()),
      );

      // ukloni listener da ne bi ponovo reagovao
      _controller.removeStatusListener(
        _onAnimacijaZavrsila,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final statusKon = statusMapa[statusKonekcije]!;

    ElevatedButton dugme = ElevatedButton.icon(
      onPressed: () {
        emitovanjeTezineKey.currentState?.pokreniPracenje();
      },
      label: Text(statusKon['label']),
      icon: Icon(statusKon['icon'], size: 30),
    );

    Animation<double> animation = CurvedAnimation(
      parent: _controller,
      curve: Curves
          .easeInOut, // ili Curves.bounceIn, Curves.elasticOut itd.
    );

    Widget postavkeIcon = postavkeStat
        ? AnimatedBuilder(
            animation: animation,
            child: Icon(Icons.settings_rounded, size: 30),
            builder: (context, child) {
              return Transform.rotate(
                angle:
                    _controller.value *
                    2 *
                    3.14159, // 0 → 2π radijana
                child: child,
              );
            },
          )
        : Icon(Icons.balance_rounded, size: 30);

    // Setujemo SystemUiMode na osnovu trenutne orijentacije
    _setUiMode(orientation);

    return Scaffold(
      appBar: orientation == Orientation.portrait
          ? AppBar(
              title: const Text("eVagaMobile"),
              centerTitle: false,
              leading: GestureDetector(
                onDoubleTap: otvoriPostavke,
                child: postavkeIcon,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                  ),
                  child: dugme,
                ),
              ],
            )
          : null,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Trenutna tezina",
            style: orientation == Orientation.portrait
                ? Theme.of(context).textTheme.bodyMedium
                : Theme.of(context).textTheme.bodyMedium!
                      .copyWith(fontSize: 30),
          ),
          const SizedBox(height: 20),
          TrenutnaTezina(
            emitovanjeKey: emitovanjeTezineKey,
            onStatusChanged: handleStatusChanged,
          ),
        ],
      ),
    );
  }
}
