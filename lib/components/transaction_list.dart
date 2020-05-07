import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  TransactionList(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            //rendenizar o componente
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  Text(
                    'Nenhuma Transação Cadastrada!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 20), //Espaçamentro entre o texto e a imagem
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit
                          .cover, //Ajustando a image dentro do espaçamento
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            //usamos o ListView.builder para que ele só possa rendenizar os elementos mostrados em telas
            itemCount: transactions.length, //quantidade de elementos no objeto
            itemBuilder: (ctx, index) {
              //exibe quais elementos são necessario
              final tr = transactions[index];
              return TransactionItem(
                key: GlobalObjectKey(tr),
                tr: tr,
                onRemove: onRemove,
              );
            },
          );
    //     ListView(
    //         children: transactions.map((tr) {
    //           return TransactionItem(
    //             key: ValueKey(tr.id),
    //             tr: tr,
    //             onRemove: onRemove,
    //           );
    //         }).toList(),
    //       );
  }
}
