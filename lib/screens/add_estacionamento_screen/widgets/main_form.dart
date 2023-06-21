import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:teste/screens/add_estacionamento_screen/widgets/form_container.dart';
import '../../../helpers/confirmation_dialog.dart';
import '../../../models/estacionamento_model.dart';
import '../../../services/estacionamentos_service.dart';

final TextEditingController _phoneController = TextEditingController();
final TextEditingController startHourController = TextEditingController();
final TextEditingController endHourController = TextEditingController();
String _isActiveValue = 'Sim';
String _precoTypeOption = 'Por Hora';
String _startDay = 'Segunda';
String _endDay = 'Sexta';

class MainAddParkingForm extends StatefulWidget {
  const MainAddParkingForm({Key? key}) : super(key: key);

  @override
  State<MainAddParkingForm> createState() => _MainAddParkingFormState();
}

class _MainAddParkingFormState extends State<MainAddParkingForm> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController cnpjController = TextEditingController();
  TextEditingController enderecoController = TextEditingController();
  TextEditingController cepVagasController = TextEditingController();
  TextEditingController qtdVagasController = TextEditingController();
  TextEditingController precoController = TextEditingController();
  TextEditingController cepController = TextEditingController();
  TextEditingController diaVencimentoController = TextEditingController();
  TextEditingController boolController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var cnpjFormatter = MaskTextInputFormatter(
      mask: '##.###.###/####-##', type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .8,
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
                  child: TextFormField(
                    controller: nomeController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Campo vazio';
                      } else if (value != null && value.length > 35) {
                        return 'ultrapassou o limite de caracteres';
                      }
                    },
                  ),
                ),
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
                  child: TextFormField(
                      controller: enderecoController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo vazio';
                        } else if (value.length < 5) {
                          return 'O endereço deve ter no mínimo 5 caracteres';
                        } else if (value.length > 100) {
                          return 'O endereço deve ter no máximo 100 caracteres';
                        }
                      }),
                ),
                const DayDropDownRow(),
              ],
            ),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              runSpacing: 10,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Wrap(
                    spacing: 20,
                    children: [
                      const HorarioRow(),
                      FormContainer(
                        width: 150,
                        label: 'Qtd. Vagas:',
                        child: TextFormField(
                          controller: qtdVagasController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo vazio';
                            }
                            final parsedValue = int.tryParse(value);
                            if (parsedValue == null || parsedValue <= 0) {
                              return 'Numero inválido';
                            }
                          },
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
                      const FormContainer(
                          width: 130, label: '', child: PrecoDropDownButton())
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 32.0),
                  child: FormContainer(
                      width: 170, label: 'Telefone:', child: PhoneField()),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: FormContainer(
                      width: 170,
                      label: 'CEP:',
                      child: TextFormField(
                        controller: cepController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo vazio';
                          }
                          final cepPattern = RegExp(r'^\d{8}$');
                          if (!cepPattern.hasMatch(value)) {
                            return 'CEP inválido';
                          }
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
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
                          width: 150, label: 'Ativo:', child: DropDownActive())
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
                            hora: (_precoTypeOption.contains('Hora'))
                                ? double.parse(precoController.text)
                                : null,
                            minuto: (_precoTypeOption.contains('Minuto'))
                                ? double.parse(precoController.text)
                                : null,
                            fixo: (_precoTypeOption.contains('Fixo'))
                                ? double.parse(precoController.text)
                                : null,
                          );
                          DiaDeFuncionamento diaDeFuncionamento =
                              DiaDeFuncionamento(
                                  inicio: _startDay, fim: _endDay);
                          Horario horario = Horario(
                              horaAbertura: startHourController.text,
                              horaFechamento: endHourController.text);
                          final cnpj = cnpjController.text
                              .replaceAll(RegExp(r'[./-]'), '');
                          final telefone = _phoneController.text
                              .replaceAll(RegExp(r'[()\s-]'), '');
                          Estacionamento estacionamento = Estacionamento(
                            nome: nomeController.text,
                            cnpj: int.parse(cnpj),
                            endereco: enderecoController.text,
                            diaDeFuncionamento: diaDeFuncionamento,
                            horario: horario,
                            qtdVagas: int.parse(qtdVagasController.text),
                            preco: preco,
                            telefone: int.parse(telefone),
                            cep: int.parse(cepController.text),
                            diaDoVencimento:
                                int.parse(diaVencimentoController.text),
                            isActive: _isActiveValue == 'Sim' ? true : false,
                          );
                          EstacionamentoService()
                              .add(estacionamento)
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
                      child: const Text('Salvar',
                          style: TextStyle(color: Colors.white))),
                ),
              ],
            )
          ],
        ),
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
        hoverColor: Colors.grey[300],
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
            child: Text(value,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          );
        }).toList(),
        underline: Container(),
        focusColor: Colors.transparent,
        isExpanded: true,
      ),
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
        hoverColor: Colors.grey[300],
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
            child: Text(value,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          );
        }).toList(),
        underline: Container(),
        focusColor: Colors.transparent,
        isExpanded: true,
      ),
    );
  }
}

class HorarioRow extends StatefulWidget {
  const HorarioRow({Key? key}) : super(key: key);

  @override
  State<HorarioRow> createState() => _HorarioRowState();
}

class _HorarioRowState extends State<HorarioRow> {
  var horarioFormatter =
      MaskTextInputFormatter(mask: '##:##', type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 16.0),
          child: Text(
            'Horário:',
            style: TextStyle(
                fontSize: 18,
                color: Color.fromRGBO(11, 22, 65, 1),
                fontWeight: FontWeight.bold),
          ),
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 16,
          children: [
            Container(
              width: 80,
              padding: const EdgeInsets.only(left: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  width: 1.5,
                  color: Colors.grey,
                ),
              ),
              child: TextFormField(
                controller: startHourController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  horarioFormatter
                ],
              ),
            ),
            const Text(
              'Às',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Container(
              width: 80,
              padding: const EdgeInsets.only(left: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  width: 1.5,
                  color: Colors.grey,
                ),
              ),
              child: TextFormField(
                controller: endHourController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  horarioFormatter
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}

class DayDropDown extends StatefulWidget {
  String day;

  DayDropDown({Key? key, required this.day}) : super(key: key);

  @override
  State<DayDropDown> createState() => _DayDropDownState();
}

class _DayDropDownState extends State<DayDropDown> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        hoverColor: Colors.grey[300],
      ),
      child: DropdownButton<String>(
        value: widget.day,
        onChanged: (String? newValue) {
          setState(() {
            widget.day = newValue!;
          });
        },
        items: <String>[
          'Segunda',
          'Terça',
          'Quarta',
          'Quinta',
          'Sexta',
          'Sábado',
          'Domingo'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          );
        }).toList(),
        underline: Container(),
        focusColor: Colors.transparent,
        isExpanded: true,
      ),
    );
  }
}

class DayDropDownRow extends StatelessWidget {
  const DayDropDownRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 16.0),
          child: Text(
            'Dia de Funcionamento:',
            style: TextStyle(
                fontSize: 18,
                color: Color.fromRGBO(11, 22, 65, 1),
                fontWeight: FontWeight.bold),
          ),
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 16,
          children: [
            Container(
                width: 150,
                padding: const EdgeInsets.only(left: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    width: 1.5,
                    color: Colors.grey,
                  ),
                ),
                child: DayDropDown(
                  day: _startDay,
                )),
            const Text(
              'À',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Container(
              width: 150,
              padding: const EdgeInsets.only(left: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  width: 1.5,
                  color: Colors.grey,
                ),
              ),
              child: DayDropDown(
                day: _endDay,
              ),
            ),
          ],
        )
      ],
    );
  }
}
