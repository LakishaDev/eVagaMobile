import 'package:evaga/widgets/emitovanje_tezine.dart';
import 'package:flutter/material.dart';

class TrenutnaTezina extends StatelessWidget {
  const TrenutnaTezina({super.key});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: orientation == Orientation.portrait
                ? 290
                : 600,
          ),
          child: Container(
            height: orientation == Orientation.portrait
                ? 80
                : 200,
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(
                context,
              ).colorScheme.background,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EmitovanjeTezine(),
                const SizedBox(width: 10),
                const Text("kg"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
