
import 'package:bytebank/pages/carro/CarrosListView.dart';
import 'package:bytebank/pages/carro/carro.dart';
import 'package:bytebank/pages/carro/carros_api.dart';
import 'package:bytebank/pages/utils/drawer_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin<HomePage> {
  TabController _tabController;


  @override
  void initState() {
    super.initState();
    //para gravar a mesma aba que sempre usa
    _tabController = TabController(length: 3, vsync: this);

    _tabController.index = 1;


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Carros"),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
            Tab(text: "Clássicos",),
            Tab(text: "Esportivos",),
            Tab(text: "Luxo",),
          ],),
        ),
        body: TabBarView(
            controller: _tabController,
            children: [
          CarrosListView(TipoCarro.classicos),
          CarrosListView(TipoCarro.esportivos),
          CarrosListView(TipoCarro.luxo),
        ]),
      drawer: DrawerList(),

    );
  }
}
