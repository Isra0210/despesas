import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  _showDatePicker() {
    showDatePicker(
      //Função para mostrar Date picker
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      //clicado em data
      if (pickedDate == null) {
        return;
      }

      setState(() {
        //Efetuando a troca da data a interface preisa refletir a alteração desse valor
        _selectedDate = pickedDate;
      });
    });
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
              TextField(
                controller: _titleController, //Pegando o valor dos textField
                onSubmitted: (_) => _submitFormfinal(),
                decoration: InputDecoration(
                  labelText: 'Título:',
                ),
              ),
              TextField(
                controller: valueController, //Pegando o valor dos textField
                keyboardType: TextInputType.numberWithOptions(
                    decimal:
                        true), //chamando o teclado numérico com casas decimais exclusivamente para ios
                onSubmitted: (_) =>
                    _submitFormfinal(), //_ como parametro: estamos ignorando o parametro que ira ser passado na função
                decoration: InputDecoration(
                  labelText: 'Valor (R\$):',
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          _selectedDate == null
                              ? 'Selecione uma Data:'
                              : 'Data: ${DateFormat('d/MM/y').format(_selectedDate)}',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.date_range),
                          onPressed: _showDatePicker,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: FlatButton(
                      shape: new RoundedRectangleBorder(
                        //Colocando border radius no botão
                        borderRadius: new BorderRadius.circular(20),
                        side: BorderSide(
                            color:
                                Colors.red), //Theme.of(context).primaryColor),
                      ),
                      child: Text(
                        'Adicionar Dispesa',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                      onPressed: _submitFormfinal, //color: Colors.grey[100],
                    ),
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
