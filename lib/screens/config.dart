import 'package:evaga/config/postavke_uredjaja.dart';
import 'package:evaga/models/tip_uredjaja.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfigScreen extends StatelessWidget {
  const ConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final config = context.watch<PostavkeUredjaja>();
    final ipController = TextEditingController(
      text: config.ip,
    );
    final portController = TextEditingController(
      text: config.port.toString(),
    );

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              controller: ipController,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: "IP Adresa",
              ),
              onTapOutside: (value) =>
                  config.setIp(ipController.text),
              // onChanged: (value) => config.setIp(value),
            ),
            TextField(
              controller: portController,
              decoration: InputDecoration(
                labelText: "Port",
              ),
              keyboardType: TextInputType.number,
              onTapOutside: (value) => config.setPort(
                int.parse(portController.text),
              ),
              // onChanged: (value) => config.setPort(
              //   int.tryParse(value) ?? 8080,
              // ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.primary,
                borderRadius: BorderRadius.circular(15),
              ),
              child: DropdownButton<TipUredjaja>(
                value: config.tip,
                items: TipUredjaja.values.map((tip) {
                  return DropdownMenuItem(
                    value: tip,
                    child: Text(tip.label),
                  );
                }).toList(),
                onChanged: (tip) {
                  if (tip != null) config.setTip(tip);
                },
                dropdownColor: Theme.of(
                  context,
                ).colorScheme.primary,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Theme.of(
                    context,
                  ).colorScheme.surface,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    config.setIp(ipController.text);
                    config.setPort(
                      int.parse(portController.text),
                    );
                    await config.save();
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Konfiguracija sačuvana ✅",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context)
                                .colorScheme
                                .surfaceContainerLowest,
                          ),
                        ),
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.surfaceContainer,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.secondary,
                  ),
                  child: Text(
                    "Sačuvaj",
                    style: TextStyle(
                      color: Theme.of(
                        context,
                      ).colorScheme.onBackground,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await config.reset();
                    ipController.text = config.ip;
                    portController.text = config.port
                        .toString();
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Vraćeno na default ⚪",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context)
                                .colorScheme
                                .surfaceContainerLowest,
                          ),
                        ),
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.surfaceContainer,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.primary,
                  ),
                  child: Text(
                    "Vrati na default",
                    style: TextStyle(
                      color: Theme.of(
                        context,
                      ).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
