import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class EmitovanjeTezine extends StatefulWidget {
  const EmitovanjeTezine({super.key});

  @override
  State<EmitovanjeTezine> createState() =>
      _EmitovanjeTezineState();
}

class _EmitovanjeTezineState
    extends State<EmitovanjeTezine> {
  late IOWebSocketChannel channel;
  String weightText = '---';

  @override
  void initState() {
    super.initState();

    channel = IOWebSocketChannel.connect(
      'ws://10.0.0.155:8080',
    );

    channel.stream.listen((message) {
      setState(() {
        weightText = parseScaleData(message);
      });
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
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
    if (data.substring(9, 11) == 'OL') return 'OVERLOAD';
    if (data.substring(9, 11) == 'LO') return 'UNDERLOAD';

    // Normal weighing
    String type = data[1]; // G ili N
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
          ? Theme.of(context).textTheme.displayLarge
          : Theme.of(context).textTheme.displayLarge!
                .copyWith(fontSize: 150),
    );
  }
}
