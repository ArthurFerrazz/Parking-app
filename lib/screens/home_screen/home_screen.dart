import 'package:flutter/material.dart';
import 'package:teste/helpers/alert_dialog.dart';
import 'package:teste/models/estacionamento_model.dart';
import 'package:teste/services/estacionamentos_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  EstacionamentoService estacionamentoService = EstacionamentoService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PERFIL ADMINISTRADOR'),
        actions: [
          IconButton(
            onPressed: (() {}),
            icon: const Icon(Icons.add),
            iconSize: 40,
            tooltip: 'Adicionar Estacionamento',
          )
        ],
        backgroundColor: Colors.red,
      ),
      drawer: const Drawer(),
      body: FutureBuilder<List<Estacionamento>>(
        future: EstacionamentoService().getAll(),
        builder: (context, snapshot) {
          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Nenhum estacionamento registrado'),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String id = snapshot.data![index].sId!;
                      String nome = snapshot.data![index].nome!;
                      String cnpj = snapshot.data![index].cnpj!;
                      String endereco = snapshot.data![index].endereco!;
                      int qtdVagas = snapshot.data![index].qtdVagas!;
                      int precoHora = snapshot.data![index].precoHora!;
                      return MeuCard(
                          id: id,
                          nome: nome,
                          cnpj: cnpj,
                          endereco: endereco,
                          qtdVagas: qtdVagas,
                          precoHora: precoHora);
                    })),
          );
        },
      ),
    );
  }
}

class MeuCard extends StatelessWidget {
  final String id;
  final String nome;
  final String cnpj;
  final String endereco;
  final int qtdVagas;
  final int precoHora;
  final String? imageUrl;

  const MeuCard({
    super.key,
    required this.nome,
    required this.cnpj,
    required this.endereco,
    required this.qtdVagas,
    required this.precoHora,
    this.imageUrl, required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.yellow,
      child: Container(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    nome,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ),
                Text.rich(
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                    TextSpan(text: 'CNPJ: ', children: <TextSpan>[
                      TextSpan(
                          text: cnpj,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal))
                    ])),
                Text.rich(
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                    TextSpan(text: 'Endereço: ', children: <TextSpan>[
                      TextSpan(
                          text: endereco,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal))
                    ])),
                Text(
                  '$qtdVagas vagas',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  'R\$$precoHora,00/h',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            SizedBox(
              width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    color: Colors.white,
                    style: IconButton.styleFrom(
                      fixedSize: const Size(50, 50),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.remove_red_eye_outlined),
                  ),
                  IconButton(
                    color: Colors.white,
                    style: IconButton.styleFrom(
                      fixedSize: const Size(50, 50),
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                    ),
                    onPressed: () {

                    },
                    icon: const Icon(Icons.mode_edit_outline_outlined),
                  ),
                  IconButton(
                    color: Colors.white,
                    style: IconButton.styleFrom(
                      fixedSize: const Size(50, 50),
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                    ),
                    onPressed: () {
                      alertDialog(function: (() {
                        EstacionamentoService().delete(id);
                      }));
                    },
                    icon: const Icon(Icons.delete_outline),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
