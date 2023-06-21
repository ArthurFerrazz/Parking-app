import 'package:flutter/material.dart';
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
  late Future<List<Estacionamento>> futureEstacionamentos;

  @override
  void initState() {
    futureEstacionamentos = EstacionamentoService().getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(11, 22, 65, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(15, 66, 107, 1),
        iconTheme: const IconThemeData(color: Color.fromRGBO(255, 223, 181, 1)),
        title: const Text(
          'PERFIL ADMINISTRADOR',
          style:
              TextStyle(color: Color.fromRGBO(255, 223, 181, 1), fontSize: 24),
        ),
        actions: [
          IconButton(
            onPressed: (() {
              Navigator.pushNamed(context, 'add_estacionamento');
            }),
            icon: const Icon(Icons.add),
            tooltip: 'Adicionar Estacionamento',
          )
        ],
      ),
      body: Row(
        children: [
          Drawer(
            backgroundColor: const Color.fromRGBO(6, 12, 35, 1),
            child: Column(
              children: [
                DrawerHeader(
                  child: Text(
                    'E-stacione',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                ListTile(
                  onTap: (() {}),
                  contentPadding: const EdgeInsets.all(16),
                  hoverColor: const Color.fromRGBO(255, 237, 214, 1).withOpacity(.4),
                  leading: const Icon(Icons.home, color: Color.fromRGBO(255, 237, 214, 1)),
                  title: Text('Home', style: Theme.of(context).textTheme.labelLarge,),
                ),
                ListTile(
                  onTap: (() {}),
                  hoverColor: const Color.fromRGBO(255, 237, 214, 1).withOpacity(.4),
                  contentPadding: const EdgeInsets.all(16),
                  leading: const Icon(Icons.person, color: Color.fromRGBO(255, 237, 214, 1)),
                  title: Text('Usuários', style: Theme.of(context).textTheme.labelLarge,),
                ),
                ListTile(
                  onTap: (() {}),
                  contentPadding: const EdgeInsets.all(16),
                  hoverColor: const Color.fromRGBO(255, 237, 214, 1).withOpacity(.4),
                  leading: const Icon(Icons.close_rounded, color: Color.fromRGBO(255, 237, 214, 1)),
                  title: Text('Cancelados', style: Theme.of(context).textTheme.labelLarge,),
                ),
                const Spacer(),
                ListTile(
                  onTap: (() {}),
                  contentPadding: const EdgeInsets.all(16),
                  hoverColor: const Color.fromRGBO(255, 237, 214, 1).withOpacity(.4),
                  leading: const Icon(Icons.logout, color: Color.fromRGBO(255, 237, 214, 1),),
                  title: Text('Sair', style: Theme.of(context).textTheme.labelLarge,),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Estacionamento>>(
              future: futureEstacionamentos,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                    child: Text('Servidor Offline', style: TextStyle(color: Color.fromRGBO(255, 223, 181, 1), fontSize: 24),),
                  );
                } else if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('Nenhum estacionamento registrado', style: TextStyle(color: Color.fromRGBO(255, 223, 181, 1), fontSize: 24),),
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
                        int cnpj = snapshot.data![index].cnpj!;
                        String endereco = snapshot.data![index].endereco!;
                        int qtdVagas = snapshot.data![index].qtdVagas!;
                        String preco = snapshot.data![index].preco!.value();
                        int telefone = snapshot.data![index].telefone!;
                        int cep = snapshot.data![index].cep!;
                        int diaDoVencimento =
                            snapshot.data![index].diaDoVencimento!;
                        bool isActive = snapshot.data![index].isActive!;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MeuCard(
                            id: id,
                            nome: nome,
                            cnpj: cnpj,
                            endereco: endereco,
                            qtdVagas: qtdVagas,
                            preco: preco,
                            telefone: telefone,
                            cep: cep,
                            diaDoVencimento: diaDoVencimento,
                            isActive: isActive,
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MeuCard extends StatelessWidget {
  final String id;
  final String nome;
  final int cnpj;
  final String endereco;
  final int qtdVagas;
  final String preco;
  final int telefone;
  final int cep;
  final int diaDoVencimento;
  final bool isActive;
  final String? imageUrl;

  const MeuCard({
    super.key,
    required this.nome,
    required this.cnpj,
    required this.endereco,
    required this.qtdVagas,
    required this.preco,
    this.imageUrl,
    required this.id,
    required this.telefone,
    required this.cep,
    required this.diaDoVencimento,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromRGBO(255, 223, 181, 1),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
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
                              text: cnpj.toString(),
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
                      preco,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(
                  width: 150,
                  height: 150,
                  child: Column(
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
                        icon: const Icon(
                          Icons.remove_red_eye_outlined,
                          size: 24,
                        ),
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
                          Navigator.pushNamed(context, 'editar_estacionamento',
                              arguments: {
                                "id": id,
                                "nome": nome,
                                "cnpj": cnpj,
                                "endereco": endereco,
                                "qtdVagas": qtdVagas,
                                "preco": preco,
                                "telefone": telefone,
                                "cep": cep,
                                "diaDoVencimento": diaDoVencimento,
                                "isActive": isActive
                              });
                        },
                        icon: const Icon(
                          Icons.mode_edit_outline_outlined,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          isActive == true ? const ApprovedContainer() : const ExpiredContainer()
        ],
      ),
    );
  }
}

class DrawerButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function() function;

  const DrawerButton(
      {Key? key,
      required this.icon,
      required this.text,
      required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: function,
      icon: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(icon),
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.labelLarge,
          )
        ],
      ),
    );
  }
}

class ApprovedContainer extends StatelessWidget {
  const ApprovedContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 50,
      decoration: const BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12))
      ),
      child: const RotatedBox(
        quarterTurns: 3,
        child: Center(
          child: Text(
            'ATIVO',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}

class PendingContainer extends StatelessWidget {
  const PendingContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 50,
      decoration: BoxDecoration(
          color: Colors.yellow.withOpacity(.6),
          borderRadius: const BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12))
      ),
      child: const RotatedBox(
        quarterTurns: 3,
        child: Center(
          child: Text(
            'PENDENTE',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}

class ExpiredContainer extends StatelessWidget {
  const ExpiredContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 50,
      decoration: BoxDecoration(
          color: Theme.of(context)
              .colorScheme
              .error
              .withOpacity(0.8),
          borderRadius: const BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12))
      ),
      child: const RotatedBox(
        quarterTurns: 3,
        child: Center(
          child: Text(
            'CANCELADO',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}



