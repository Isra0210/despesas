import 'dart:math';

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.tr,
    @required this.onRemove,
  }) : super(key: key);

  final Transaction tr;
  final void Function(String) onRemove;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {

  static const colors = [
    Colors.red,
    Colors.purple,
    Colors.orange,
    Colors.black,
    Colors.blue,
  ];

  Color _backgroundColor;

  @override
  void initState(){//iniciando o estado
    super.initState();
    int i = Random().nextInt(5);
    _backgroundColor = colors[i];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _backgroundColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                'R\$${widget.tr.value}',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          widget.tr.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat('d/MMM/y').format(widget.tr.date),
        ),
        trailing: MediaQuery.of(context).size.width > 400
            ? FlatButton.icon(
                onPressed: () => widget.onRemove(widget.tr.id),
                icon: Icon(Icons.delete),
                label: Text('Excluir'),
                textColor: Colors.red,
              )
            : IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => widget.onRemove(widget.tr.id),
                color: Colors.red,
              ),
      ),
    );
  }
}
