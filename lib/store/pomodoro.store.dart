import "dart:async";

import "package:mobx/mobx.dart";

part "pomodoro.store.g.dart";

class PomodoroStore = _PomodoroStore with _$PomodoroStore;

enum TipoIntervalo { TRABALHO, DESCANSO }

abstract class _PomodoroStore with Store {
  @observable
  bool iniciado = false;

  @observable
  int minutos = 2;

  @observable
  int segundos = 0;

  @observable
  int tempoTrabalho = 2;

  @observable
  int tempoDescanso = 1;

  @observable
  TipoIntervalo tipoIntervalo = TipoIntervalo.TRABALHO;

  bool estaTrabalhando() => this.tipoIntervalo == TipoIntervalo.TRABALHO;
  bool estaDescansando() => this.tipoIntervalo == TipoIntervalo.DESCANSO;

  Timer? cronometro;

  @action
  void iniciar() {
    this.iniciado = true;
    this.cronometro = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (this.minutos == 0 && this.segundos == 0)
          this._trocarTipoIntervalo();
        else if (this.segundos == 0) {
          this.segundos = 59;
          this.minutos--;
        } else
          this.segundos--;
      }
    );
  }

  @action
  void parar() {
    this.iniciado = false;
    this.cronometro?.cancel();
  }

  @action
  void incrementarTempoTrabalho() {
    this.tempoTrabalho++;
    if (this.estaTrabalhando()) this.reiniciar();
  }

  @action
  void decrementarTempoTrabalho() {
    if (this.tempoTrabalho > 1) {
      this.tempoTrabalho--;
      if (this.estaTrabalhando()) this.reiniciar();
    }
  }

  @action
  void incrementarTempoDescanso() {
    this.tempoDescanso++;
    if (this.estaDescansando()) this.reiniciar();
  }

  @action
  void decrementarTempoDescanso() {
    if (this.tempoDescanso > 1) {
      this.tempoDescanso--;
      if (this.estaDescansando()) this.reiniciar();
    }
  }

  @action
  void reiniciar() {
    this.parar();
    this.minutos = this.estaTrabalhando()
      ? this.tempoTrabalho
      : this.tempoDescanso;
    this.segundos = 0;
  }

  void _trocarTipoIntervalo() {
    if (this.estaTrabalhando()) {
      this.tipoIntervalo = TipoIntervalo.DESCANSO;
      this.minutos = this.tempoDescanso;
    } else {
      this.tipoIntervalo = TipoIntervalo.TRABALHO;
      this.minutos = this.tempoTrabalho;
    }
    this.segundos = 0;
  }
}