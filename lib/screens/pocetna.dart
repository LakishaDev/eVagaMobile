import 'package:evaga/models/status_konekcije.dart';
import 'package:evaga/widgets/emitovanje_tezine.dart';
import 'package:evaga/widgets/trenutna_tezina.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PocetnaEkran extends StatefulWidget {
  const PocetnaEkran({super.key});

  @override
  State<PocetnaEkran> createState() => _PocetnaEkranState();
}

class _PocetnaEkranState extends State<PocetnaEkran> {
  final GlobalKey<EmitovanjeTezineState>
  emitovanjeTezineKey = GlobalKey<EmitovanjeTezineState>();
  StatusKonekcije? status;

  void handleStatusChanged(StatusKonekcije noviStatus) {
    setState(() {
      status = noviStatus;
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

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    ElevatedButton dugme = ElevatedButton.icon(onPressed: () {
      
    }, label: label)

    // Setujemo SystemUiMode na osnovu trenutne orijentacije
    _setUiMode(orientation);

    return Scaffold(
      appBar: orientation == Orientation.portrait
          ? AppBar(
              title: const Text("eVaga"),
              leading: Icon(
                Icons.balance_rounded,
                size: 30,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    emitovanjeTezineKey.currentState
                        ?.pokreniPracenje();
                  },
                  icon: Icon(Icons.add, size: 30),
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
