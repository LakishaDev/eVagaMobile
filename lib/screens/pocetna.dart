import 'package:evaga/widgets/trenutna_tezina.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PocetnaEkran extends StatelessWidget {
  const PocetnaEkran({super.key});

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
                  onPressed: () {},
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
          TrenutnaTezina(),
        ],
      ),
    );
  }
}
