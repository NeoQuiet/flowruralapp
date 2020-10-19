import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ruralflow/provider/auth.dart';
import '../utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Bem vindo, Visitante'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home_filled),
            title: Text('Principal'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                RotasFlowRural.BUSCAR,
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Meu Perfil'),
            onTap: () {
              Navigator.of(context).pushNamed(
                RotasFlowRural.PERFIL_PESSOA,
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.view_module),
            title: Text('Meus Produtos e Serviços'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                RotasFlowRural.ITENS_GERENCIA,
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.stairs),
            title: Text('Minhas Compras e Vendas'),
            onTap: () {
              Navigator.of(context).pushNamed(
                RotasFlowRural.PEDIDOS,
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sair'),
            onTap: () {
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
