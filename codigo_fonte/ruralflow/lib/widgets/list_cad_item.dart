import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ruralflow/models/item.dart';

import 'package:ruralflow/provider/item.dart';
import 'package:ruralflow/utils/app_routes.dart';

class ListCadItem extends StatelessWidget {
  final Item itens;

  ListCadItem(
    this.itens,
  );

  @override
  Widget build(BuildContext context) {
    // scaffold
    final scaffold = Scaffold.of(context);
    // lista em forma tijolo
    return Column(
      children: <Widget>[
        Card(
          margin: EdgeInsets.all(10),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              child: Image.asset(
                'assets/images/queijocaipira.jpg',
                fit: BoxFit.cover,
              ),
            ),
            title: Text(itens.descricao),
            subtitle: Text(itens.ativo),
            onTap: () {
              Navigator.of(context)
                  .pushNamed(RotasFlowRural.VISUALIZAR, arguments: itens);
            },
            trailing: Container(
              width: 100,
              height: 300,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.call,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          RotasFlowRural.FORM_CAD_ANUNCIO,
                          arguments: itens);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.star,
                      color: Colors.orange,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text('Notificar compra'),
                          content: Text('Tem certeza?'),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Não'),
                              onPressed: () => Navigator.of(context).pop(false),
                            ),
                            FlatButton(
                              child: Text('Sim'),
                              onPressed: () => Navigator.of(context).pop(true),
                            ),
                          ],
                        ),
                      ).then(
                        (value) async {
                          if (value) {
                            try {
                              await Provider.of<ItemProvider>(context,
                                      listen: false)
                                  .delete(itens.id);
                            } on HttpException catch (error) {
                              scaffold.showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Vendedor notificado, aguarde o contato.'),
                                ),
                              );
                            }
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}