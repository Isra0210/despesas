import 'package:flutter/material.dart';
import 'adaptative_textField.dart';
import 'adaptative_button.dart';
import 'adaptative_datePicker.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitFormfinal() {
    final title = _titleController.text;
    final value = double.tryParse(valueController.text) ??
        0.0; //Caso não consiga converter, atribui 0

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return; //evitando dados inválidos
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 10,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: <Widget>[
              Container(
                child: Image.asset(
                  'assets/images/imageDespesas.png',
                  height: 80,
                ),
              ),
              AdaptativeTextField(
                label: 'Título',
                controller: _titleController, //Pegando o valor dos textField
                onSubmitted: (_) => _submitFormfinal(),
              ),
              AdaptativeTextField(
                label: 'Valor (R\$)',
                controller: valueController, //Pegando o valor dos textField
                keyboardType: TextInputType.numberWithOptions(
                    decimal:
                        true), //chamando o teclado numérico com casas decimais exclusivamente para ios
                onSubmitted: (_) =>
                    _submitFormfinal(), //_ como parametro: estamos ignorando o parametro que ira ser passado na função
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AdaptativeDatePicker(
                    selectedDate: _selectedDate,
                    onDateChanged: (newDate) {
                      setState(() {
                        _selectedDate = newDate;
                      });
                    },
                  ),
                  AdaptativeButton(
                    label: 'Adicionar Despesa',
                    onPressed: _submitFormfinal,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: CircleAvatar(
                      backgroundColor: Colors.orange,
                      radius: 20,
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
