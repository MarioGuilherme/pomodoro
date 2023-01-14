import "package:flutter/material.dart";

import "package:pomodoro/store/pomodoro.store.dart";

import "package:provider/provider.dart";

class EntradaTempo extends StatelessWidget {
  final String titulo;
  final int valor;
  final void Function()? incremento;
  final void Function()? decremento;

  const EntradaTempo({
    required this.titulo,
    required this.valor,
    required this.incremento,
    required this.decremento,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PomodoroStore store = Provider.of<PomodoroStore>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          this.titulo,
          style: const TextStyle(fontSize: 25)
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: this.decremento,
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15),
                primary: store.estaTrabalhando()
                  ? Colors.red
                  : Colors.green
              ),
              child: const Icon(
                Icons.arrow_downward,
                color: Colors.white
              )
            ),
            Text(
              "${this.valor} min",
              style: const TextStyle(fontSize: 18)
            ),
            ElevatedButton(
              onPressed: this.incremento,
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15),
                primary: store.estaTrabalhando()
                  ? Colors.red
                  : Colors.green
              ),
              child: const Icon(
                Icons.arrow_upward,
                color: Colors.white
              )
            )
          ]
        )
      ]
    );
  }
}