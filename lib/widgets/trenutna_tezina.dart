import 'package:evaga/models/status_konekcije.dart';
import 'package:evaga/widgets/emitovanje_tezine.dart';
import 'package:flutter/material.dart';

class TrenutnaTezina extends StatelessWidget {
  const TrenutnaTezina({
    super.key,
    required this.emitovanjeKey,
    required this.onStatusChanged,
  });

  final GlobalKey<EmitovanjeTezineState> emitovanjeKey;
  final ValueChanged<StatusKonekcije> onStatusChanged;

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
              color: Theme.of(context).colorScheme.tertiary,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EmitovanjeTezine(
                  key: emitovanjeKey,
                  onStatusChanged: onStatusChanged,
                ),
                const SizedBox(width: 10),
                Text(
                  "kg",
                  style: TextStyle(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
