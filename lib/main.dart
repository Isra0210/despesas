import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/material.dart';
import 'components/transaction_form.dart';
import 'components/transaction_list.dart';
import 'dart:math';
import 'models/transaction.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        //primarySwatch: Colors.orange,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transaction = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transaction.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7), //Subtraindo com 7 dias
      )); //Se a data for antes de 7 dias retorna true, se não retorna falso
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title:
          title, //title 1: Atributo de Transaction, title 2: parametro recebido na função
      value: value,
      date: date,
    );

    setState(() {
      _transaction.add(newTransaction); //Adicionando uma nova transação
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    //Deletando uma transação
    setState(() {
      _transaction.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    //esperamos receber o build context
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  _openTransactionListModal(BuildContext context) {
    //esperamos receber o build context
    showDialog(
      context: context,
      builder: (_) {
        return Container(
          height: 300,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(30, 20, 0, 20),
                child: Text(
                  'Lista de Despesas',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              TransactionList(_transaction, _removeTransaction),
              Container(
                height: 40,
                width: 150,
                margin: EdgeInsets.fromLTRB(20, 50, 0, 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Fechar',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context);

    bool isLanscape =
        mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = AppBar(
      title: Text(
        'Despesas Pessoais',
        style: TextStyle(
          color: Colors.white,
          //fontSize: 20 * MediaQuery.of(context).textScaleFactor, //estremamete importante para aplicações responsivas
        ),
      ),
      actions: <Widget>[
        if (isLanscape)
          IconButton(
            icon: Icon(_showChart ? Icons.list : Icons.pie_chart),
            onPressed: () {
              setState(() {
                _showChart = !_showChart;
              });
            },
          ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _openTransactionFormModal(context),
        ),
      ],
      backgroundColor: Colors.orange[700],
    );

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    return Scaffold(
      appBar: appBar,
      //Menu
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('Israel Rodrigues'),
                accountEmail: Text('r.israel0210@gmail.com'),
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://scontent.ftow2-1.fna.fbcdn.net/v/t1.0-9/p960x960/89722106_511179916255667_8280678207745687552_o.jpg?_nc_cat=100&_nc_sid=85a577&_nc_ohc=zzMgh7ZzF7QAX84uJ9b&_nc_ht=scontent.ftow2-1.fna&_nc_tp=6&oh=c72d5e3d2b6e7718033e80cd503e9f8b&oe=5ECB5CAC"),
                  ),
                ),
                // otherAccountsPictures: <Widget>[
                //   GestureDetector(
                //     onTap: () => print("This is the other profile"),
                //     child: CircleAvatar(
                //       backgroundImage: NetworkImage(
                //           "https://scontent.ftow2-1.fna.fbcdn.net/v/t1.0-9/p960x960/89722106_511179916255667_8280678207745687552_o.jpg?_nc_cat=100&_nc_sid=85a577&_nc_ohc=zzMgh7ZzF7QAX84uJ9b&_nc_ht=scontent.ftow2-1.fna&_nc_tp=6&oh=c72d5e3d2b6e7718033e80cd503e9f8b&oe=5ECB5CAC"),
                //     ),
                //   )
                // ], //Other account
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        "https://www.htcontabil.com/wp-content/uploads/2019/02/original-a8309888b49cc24d6b4976eb2fa2dd35.jpg"),
                  ),
                ),
              ),
              ListTile(
                title: Text('Adicionar Despesa'),
                trailing: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _openTransactionFormModal(context),
                  color: Colors.green,
                ),
              ),
              Divider(),
              ListTile(
                title: Text('Deletar Despesa'),
                trailing: new IconButton(
                  icon: Icon(Icons.delete_outline),
                  color: Colors.red,
                  onPressed: () {},
                ),
              ),
              Divider(),
              ListTile(
                title: Text('Editar Despesa'),
                trailing: new IconButton(
                  icon: Icon(Icons.edit),
                  color: Colors.blueGrey,
                  onPressed: () {},
                ),
              ),
              Divider(),
              ListTile(
                title: Text('Buscar Despesa'),
                trailing: new IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                  color: Colors.blue,
                ),
              ),
              Divider(),
              ListTile(
                title: Text('Listar Despesa'),
                trailing: IconButton(
                  icon: Icon(Icons.list),
                  onPressed: () {
                    _openTransactionListModal(context);
                  },
                  color: Colors.brown,
                ),
              ),
              Divider(),
              ListTile(
                title: Text('Fechar'),
                trailing: IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () => Navigator.of(context).pop(),
                  color: Colors.red,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Container(
                  color: Colors.orange,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(35, 0, 0, 0),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.copyright),
                          onPressed: () {},
                          color: Colors.white,
                        ),
                        Text(
                          '2020 Israel Rodrigues',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // if (isLanscape)
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: <Widget>[
            //       Text('Exibir Gráfico'),
            //       Switch(
            //         //"liga / desliga" gráfica
            //         value: _showChart,
            //         onChanged: (value) {
            //           setState(() {
            //             _showChart = value;
            //           });
            //         },
            //       ),
            //     ],
            //   ),
            if (_showChart || !isLanscape)
              Container(
                height: availableHeight * (isLanscape ? 0.8 : 0.3),
                child: Chart(_recentTransactions),
              ),
            if (!_showChart || !isLanscape)
              Container(
                height: availableHeight * (isLanscape ? 1: 0.7),
                child: TransactionList(_transaction, _removeTransaction),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          //Icon para adicionar uma nova transação
          child: Icon(Icons.add),
          onPressed: () => _openTransactionFormModal(context),
          backgroundColor: Colors.orange[600] //Theme.of(context).primaryColor,
          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
