
import 'package:bytebank/pages/carro/CarrosListView.dart';
import 'package:bytebank/pages/carro/carro.dart';
import 'package:bytebank/pages/carro/carro_form_page.dart';
import 'package:bytebank/pages/carro/carros_api.dart';
import 'package:bytebank/pages/carro/carros_page.dart';
import 'package:bytebank/pages/favoritos/favoritos_page.dart';
import 'package:bytebank/pages/utils/alert.dart';
import 'package:bytebank/pages/utils/drawer_list.dart';
import 'package:bytebank/pages/utils/nav.dart';
import 'package:bytebank/pages/utils/prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    _initTabs();

  }
  _initTabs() async {

    // Primeiro busca o índice nas prefs.
    int tabIdx = await Prefs.getInt("tabIdx");

    // Depois cria o TabController
    // No método build na primeira vez ele poderá estar nulo
    _tabController = TabController(length: 4, vsync: this);

    // Agora que temos o TabController e o índice da tab,
    // chama o setState para redesenhar a tela
    setState(() {
      _tabController.index = tabIdx;
    });

    _tabController.addListener(() {
      Prefs.setInt("tabIdx", _tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Carros"),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
            Tab(text: "Clássicos",
              icon: Icon(Icons.directions_car),
            ),
            Tab(text: "Esportivos",
              icon: Icon(Icons.directions_car),

            ),
            Tab(text: "Luxo",
              icon: Icon(Icons.directions_car),
            ),
              Tab(text: "Favoritos",
                icon: Icon(Icons.favorite),

              ),
          ],),
        ),
        body: TabBarView(
            controller: _tabController,
            children: [
          CarrosPage(TipoCarro.classicos),
          CarrosPage(TipoCarro.esportivos),
          CarrosPage(TipoCarro.luxo),
         FavoritosPage(),
        ]),
      drawer: DrawerList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _onClickAdicionarCarro,
      ),

    );
  }

  void _onClickAdicionarCarro() {
   push(context, CarroFormPage());
  }
}
