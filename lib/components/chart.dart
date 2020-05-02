import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTrnasaction {
    return List.generate(7, (index) {
      //Gerando a lista enumerada como 7 dias da semana e o index aponta para ele
      final weekDay = DateTime.now().subtract(
        Duration(days: index), //Pegando o dia de hj e subitraindo com o index
      );

      double totalSum = 0.0; //calcular o valor total

      for (var i = 0; i < recentTransaction.length; i++) {
        bool sameDay = recentTransaction[i].date.day ==
            weekDay
                .day; //comparando para ver se a ultima transação e igual o dia atual
        bool sameMonth = recentTransaction[i].date.month ==
            weekDay
                .month; //comparando para ver se a ultima transação e igual o mes atual
        bool sameYear = recentTransaction[i].date.year ==
            weekDay
                .year; //comparando para ver se a ultima transação e igual o anos atual

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransaction[i].value;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay)[
            0], //"E" => representa o dia da semana formatando conforme o weekDay
        'value': totalSum,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    //Calculando o valor gasto na semana
    return groupedTrnasaction.fold(0.0, (sum, tr) {
      return sum + tr['value'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTrnasaction.map((tr) {
            return Flexible(
              fit: FlexFit.tight,//Expande o elemento para ocupar todos os espaços em branc dessa linha
              child: ChartBar(
                label: tr['day'],
                value: tr['value'],
                percentage: _weekTotalValue == 0 ? 0 : (tr['value'] as double) / _weekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
