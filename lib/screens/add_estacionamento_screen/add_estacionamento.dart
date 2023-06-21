import 'package:flutter/material.dart';
import 'package:teste/screens/add_estacionamento_screen/widgets/main_form.dart';

class AdicionarEstacionamento extends StatefulWidget {
  const AdicionarEstacionamento({Key? key}) : super(key: key);

  @override
  State<AdicionarEstacionamento> createState() =>
      _AdicionarEstacionamentoState();
}

class _AdicionarEstacionamentoState extends State<AdicionarEstacionamento> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(15, 66, 107, 1),
        iconTheme: const IconThemeData(
            color: Color.fromRGBO(255, 223, 181, 1), size: 28),
        title: const Text(
          'Cadastro de Estacionamento',
          style:
              TextStyle(color: Color.fromRGBO(255, 223, 181, 1), fontSize: 24),
        ),
      ),
      body: Container(
        color: const Color.fromRGBO(11, 22, 65, 1),
        padding: const EdgeInsets.only(top: 40.0, left: 40.0, right: 40.0),
        child: const Align(
          alignment: Alignment.topCenter,
          child: MainAddParkingForm(),
        ),
      ),
    );
  }
}