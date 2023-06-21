import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../helpers/confirmation_dialog.dart';
import '../../models/estacionamento_model.dart';
import '../../services/estacionamentos_service.dart';

final TextEditingController _phoneController = TextEditingController();
String _isActiveValue = 'Sim';
String _precoTypeOption = 'Por Hora';

class EditarEstacionamento extends StatefulWidget {
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

  const EditarEstacionamento(
      {Key? key,
      required this.nome,
      required this.cnpj,
      required this.endereco,
      required this.qtdVagas,
      required this.preco,
      required this.telefone,
      required this.cep,
      required this.diaDoVencimento,
      required this.isActive,
      required this.id})
      : super(key: key);

  @override
  State<EditarEstacionamento> createState() => _EditarEstacionamentoState();
}

class _EditarEstacionamentoState extends State<EditarEstacionamento> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController cnpjController = TextEditingController();
  TextEditingController enderecoController = TextEditingController();
  TextEditingController qtdVagasController = TextEditingController();
  TextEditingController precoController = TextEditingController();
  TextEditingController cepController = TextEditingController();
  TextEditingController diaVencimentoController = TextEditingController();
  TextEditingController boolController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var cnpjFormatter = MaskTextInputFormatter(
      mask: '##.###.###/####-##', type: MaskAutoCompletionType.lazy);

  @override
  void initState() {
    String cnpj = widget.cnpj.toString();
    String cnpjFormatado =
        "${cnpj.substring(0, 2)}.${cnpj.substring(2, 5)}.${cnpj.substring(5, 8)}/${cnpj.substring(8, 13)}-${cnpj.substring(13)}";
    String telefone = widget.telefone.toString();
    String telefoneFormatado =
        "(${telefone.substring(0, 2)}) ${telefone.substring(2, 7)}-${telefone.substring(7)}";
    nomeController.text = widget.nome;
    cnpjController.text = cnpjFormatado;
    enderecoController.text = widget.endereco;
    qtdVagasController.text = widget.qtdVagas.toString();
    precoController.text = widget.preco.replaceAll(RegExp(r'[^0-9.]'), '');
    _phoneController.text = telefoneFormatado;
    cepController.text = widget.cep.toString();
    diaVencimentoController.text = widget.diaDoVencimento.toString();
    _isActiveValue = widget.isActive == true ? 'Sim' : 'Não';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(15, 66, 107, 1),
        iconTheme: const IconThemeData(color: Color.fromRGBO(255, 223, 181, 1), size: 28),
        title: Text('Editar o Estacionamento ${widget.nome}',
            style: const TextStyle(
                color: Color.fromRGBO(255, 223, 181, 1), fontSize: 24)),
      ),
      body: Container(
        color: const Color.fromRGBO(11, 22, 65, 1),
        padding: const EdgeInsets.only(top: 40.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: MediaQuery.of(context).size.width * .7,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: const Color.fromRGBO(255, 223, 181, 1)),
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      FormContainer(
                          width: 300,
                          label: 'Nome do estacionamento:',
                          child: TextField(
                            controller: nomeController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          )),
                      FormContainer(
                        width: 300,
                        label: 'CNPJ:',
                        child: TextField(
                          controller: cnpjController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            cnpjFormatter
                          ],
                        ),
                      ),
                      FormContainer(
                        width: 300,
                        label: 'Endereço:',
                        child: TextField(
                          controller: enderecoController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    runSpacing: 10,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: Wrap(
                          spacing: 20,
                          children: [
                            FormContainer(
                              width: 150,
                              label: 'Qtd. Vagas:',
                              child: TextField(
                                controller: qtdVagasController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                              ),
                            ),
                            FormContainer(
                              width: 100,
                              label: 'Preço:',
                              child: TextField(
                                controller: precoController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  prefixText: 'R\$ ',
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                              ),
                            ),
                            const FormContainer(width: 130, label: '', child: PrecoDropDownButton())
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 24.0),
                        child: FormContainer(
                            width: 170,
                            label: 'Telefone:',
                            child: PhoneField()),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: FormContainer(
                            width: 170,
                            label: 'CEP:',
                            child: TextField(
                              controller: cepController,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          spacing: 20,
                          runSpacing: 10,
                          children: [
                            FormContainer(
                              width: 150,
                              label: 'Dia do vencimento:',
                              child: TextFormField(
                                controller: diaVencimentoController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                validator: (value) {
                                  if (value != null && value.isNotEmpty) {
                                    final number = int.tryParse(value);
                                    if (number! < 1 || number > 31) {
                                      return 'escolha de 1 a 31';
                                    }
                                  }
                                },
                              ),
                            ),
                            const FormContainer(
                                width: 150,
                                label: 'Ativo:',
                                child: DropDownActive())
                          ],
                        ),
                      )
                    ],
                  ),
                  Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(120, 40),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                backgroundColor: Colors.blue),
                            onPressed: (() {
                              if (_formKey.currentState!.validate()) {
                                Preco preco = Preco(
                                  hora: (_precoTypeOption.contains('Hora')) ? double.parse(precoController.text) : null,
                                  minuto: (_precoTypeOption.contains('Minuto')) ? double.parse(precoController.text) : null,
                                  fixo: (_precoTypeOption.contains('Fixo')) ? double.parse(precoController.text) : null,
                                );
                                final cnpj = cnpjController.text
                                    .replaceAll(RegExp(r'[./-]'), '');
                                final telefone = _phoneController.text
                                    .replaceAll(RegExp(r'[()\s-]'), '');
                                Estacionamento estacionamento = Estacionamento(
                                  sId: widget.id,
                                  nome: nomeController.text,
                                  cnpj: int.parse(cnpj),
                                  endereco: enderecoController.text,
                                  qtdVagas: int.parse(qtdVagasController.text),
                                  preco: preco,
                                  telefone: int.parse(telefone),
                                  cep: int.parse(cepController.text),
                                  diaDoVencimento:
                                      int.parse(diaVencimentoController.text),
                                  isActive:
                                      _isActiveValue == 'Sim' ? true : false,
                                );
                                EstacionamentoService()
                                    .update(estacionamento)
                                    .then((value) => {
                                          confirmationDialog(
                                              title: 'Sucesso',
                                              content: value,
                                              function: (() {
                                                Navigator.pushReplacementNamed(
                                                    context, 'home');
                                              }))
                                        });
                              }
                            }),
                            child: const Text(
                              'Atualizar',
                              style: TextStyle(color: Colors.white),
                            )),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FormContainer extends StatelessWidget {
  final double width;
  final Widget child;
  final String label;

  const FormContainer({
    Key? key,
    required this.width,
    required this.label,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            label,
            style: const TextStyle(
                fontSize: 18,
                color: Color.fromRGBO(11, 22, 65, 1),
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
            width: width,
            padding: const EdgeInsets.only(left: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                width: 1.0,
                color: Colors.grey,
              ),
            ),
            child: child)
      ],
    );
  }
}

class DropDownActive extends StatefulWidget {
  const DropDownActive({Key? key}) : super(key: key);

  @override
  State<DropDownActive> createState() => _DropDownActiveState();
}

class _DropDownActiveState extends State<DropDownActive> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        hoverColor: Colors.transparent,
      ),
      child: DropdownButton<String>(
        value: _isActiveValue,
        onChanged: (String? newValue) {
          setState(() {
            _isActiveValue = newValue!;
          });
        },
        items: <String>['Sim', 'Não']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          );
        }).toList(),
        underline: Container(),
        focusColor: Colors.transparent,
        isExpanded: true,
      ),
    );
  }
}

class PhoneField extends StatefulWidget {
  const PhoneField({Key? key}) : super(key: key);

  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  var maskFormatter = MaskTextInputFormatter(
      mask: '(##) #####-####', type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly, maskFormatter],
    );
  }
}

class ResponsiveContainer extends StatelessWidget {
  final Widget child;

  const ResponsiveContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.grey.withOpacity(.2)),
      padding: const EdgeInsets.all(24.0),
      child: child,
    );
  }
}

class PrecoDropDownButton extends StatefulWidget {
  const PrecoDropDownButton({Key? key}) : super(key: key);

  @override
  State<PrecoDropDownButton> createState() => _PrecoDropDownButtonState();
}

class _PrecoDropDownButtonState extends State<PrecoDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        hoverColor: Colors.transparent,
      ),
      child: DropdownButton<String>(
        value: _precoTypeOption,
        hint: const Text('Selecione uma opção'),
        onChanged: (String? newValue) {
          setState(() {
            _precoTypeOption = newValue!;
          });
        },
        items: <String>[
          'Por Hora',
          'Por Minuto',
          'Fixo',
        ].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: const TextStyle(fontWeight: FontWeight.bold),),
          );
        }).toList(),
        underline: Container(),
        focusColor: Colors.transparent,
        isExpanded: true,
      ),
    );
  }
}
