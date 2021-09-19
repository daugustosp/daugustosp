
import 'package:flutter/material.dart';

import 'listaSegredos.dart';


class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Segredos'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
          ),

          Container(
            height: 501,
            child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
            DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
            color: Colors.blue,
            ),
            ),
              ListTile(
                title: Text('Novo segredo'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ],
            ),
          ),
          Container(
            height: 140,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _FeatureItem(
                  'Visualizar segredos',
                  Icons.wb_cloudy_sharp,
                  onClick: () => _showContactsList(context),
                ),
                _FeatureItem(
                  'Compartilhar segredo',
                  Icons.ios_share,
                  onClick: () => _showTransactionsList(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showContactsList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => listaSegredos(),
      ),
    );
  }

  _showTransactionsList(BuildContext context) {


  }
}

class _FeatureItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function onClick;

  _FeatureItem(
    this.name,
    this.icon, {
    @required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColorDark,
        child: InkWell(
          onTap: () => onClick(),
          child: Container(
            padding: EdgeInsets.all(8.0),
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24.0,
                ),
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

  }
}



