import "package:flutter/material.dart";
import "package:flutter_mobx/flutter_mobx.dart";

import "package:pomodoro/components/cronometro.dart";
import "package:pomodoro/components/entrada_tempo.dart";
import "package:pomodoro/store/pomodoro.store.dart";

import "package:provider/provider.dart";

class Pomodoro extends StatelessWidget {
  const Pomodoro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PomodoroStore store = Provider.of<PomodoroStore>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Expanded(child: Cronometro()),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Observer(
              builder: (_) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  EntradaTempo(
                    titulo: "Trabalho",
                    valor: store.tempoTrabalho,
                    incremento: store.iniciado && store.estaTrabalhando()
                      ? null
                      : store.incrementarTempoTrabalho,
                    decremento: store.iniciado && store.estaTrabalhando()
                      ? null
                      : store.decrementarTempoTrabalho
                  ),
                  EntradaTempo(
                    titulo: "Descanso",
                    valor: store.tempoDescanso,
                    incremento: store.iniciado && store.estaDescansando()
                      ? null
                      : store.incrementarTempoDescanso,
                    decremento: store.iniciado && store.estaDescansando()
                      ? null
                      : store.decrementarTempoDescanso
                  )
                ]
              )
            )
          )
        ]
      )
    );
  }
}