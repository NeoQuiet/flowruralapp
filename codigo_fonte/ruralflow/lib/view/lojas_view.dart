import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ruralflow/utils/app_routes.dart';
import 'package:ruralflow/widgets/list_cad_lojas.dart';
import '../provider/pessoa_provider.dart';

/*
AUTOR: CAIO RODRIGO C PEIXOTO
DATA: 30/08/2020
FUNÇÃO: ESTE ESTÁ INTERFACE TEM COMO FINALIDADE, LISTAR OS ANUNCIOS JÁ CRIADOS E 
PERMITIR QUE O USUÁRIO POSSA CRIAR, EDITAR OU INATIVAR ANUNCIOS. 
 */
class LojasView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    RotasFlowRural.NOTIFICACOES,
                  );
                  // CadAnuncioForm();
                },
              ),
            ],
            title: Text(
              'Buscar',
            ),
          ),
          body: _body(context),
        ),
      ],
    );
  }
}

_body(context) {
  final pessoasDados = Provider.of<Pessoas>(context);
  final pessoas = pessoasDados.todasPessoas;
  return Container(
    child: Padding(
      padding: EdgeInsets.all(10),
      child: ListView.builder(
        //captura o total de anuncios
        itemCount: pessoasDados.totalPessoa,
        //inicia a construção da lista de items
        itemBuilder: (ctx, i) => Column(
          children: [
            //Objeto que captura os anuncios cadastados e os lista
            ListCadLoja(pessoas[i]),

            //divisor responsavel por desenha uma linha de divisaos
            Divider(),
          ],
        ),
      ),
    ),
  );
}
