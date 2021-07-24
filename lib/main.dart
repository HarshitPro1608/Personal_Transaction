import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.amber,
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
        title: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
          button: TextStyle(color: Colors.white),
        ),
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    fontFamily: 'OpenSans',
                fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
            ),
      )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput='Val';
  // String amountInput='0';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   final List<Transaction> _userTransactions = [
     // Transaction(
  //   id: 't1',
  //   title: 'New Shoes',
  //   amount: 70.00,
  //   date: DateTime.now(),
  // ),
  //   Transaction(
  //     id: 't2',
  //     title: 'Groceries',
  //     amount: 30.00,
  //     date: DateTime.now(),
  //   ),
  ];

   List<Transaction> get _recentTransactions{
     return _userTransactions.where((tx) {
       return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7),
       ),
       );
     }).toList();
   }

  void _addNewTransaction(String txTitle,double txAmount, DateTime chosenDate){
    final newTx = Transaction(id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(context: ctx, builder: (_) {
      return GestureDetector(
        onTap: () {},
        child :NewTransaction(_addNewTransaction),
        behavior: HitTestBehavior.opaque,
      );
    },
    );
  }

  void _deleteTransaction(String id){
     setState(() {
       _userTransactions.removeWhere((tx) {
         return tx.id == id;
       });
     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Personal Expenses'),
          actions: [
            IconButton(onPressed: ()=> _startAddNewTransaction(context),
                icon: Icon(Icons.add),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
              // mainAxisAlignment:  MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
               Chart(_recentTransactions),
              TransactionList(_userTransactions, _deleteTransaction),
              ],
            ),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
        );
  }
}