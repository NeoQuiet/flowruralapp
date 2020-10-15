import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ruralflow/models/item.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:ruralflow/utils/constante.dart';

/* esta classe contem todos os metodos de Anuncio */
class ItemProvider with ChangeNotifier {
  String _token;
  String _userId;
  //instancia que aponta para a coleção no banco
  final String _baseUrl = '${Constants.API_URL}/produto';
  //cria lista contendo todos os anuncios sem provedor
  List<Item> _todosItens = [];

  ItemProvider([this._token, this._userId, this._todosItens = const []]);
  //função que retorna os dados da lista de anuncios
  List<Item> get todositens => [..._todosItens];
  //metodo reponsavel por pegar tamanho dos anuncios
  int get totalItens {
    return _todosItens.length;
  }

  //metodo responsavel por adicionar um novo anuncio na lista de anuncios

  Future<void> adicionarItemBanco(Item pNovoItem) async {
    final response = await http.post(
      "$_baseUrl.json?auth=$_token",
      body: json.encode({
        'id': _userId,
        'descricao': pNovoItem.descricao,
        'quantidade': pNovoItem.quantidade,
        'valor': pNovoItem.valor,
        'imagem': pNovoItem.imagem,
        'ativo': pNovoItem.ativo,
        'dtCadastro': pNovoItem.dtCadastro,
      }),
    );
    _todosItens.add(Item(
      id: json.decode(response.body)['id'],
      descricao: pNovoItem.descricao,
      quantidade: pNovoItem.quantidade,
      valor: pNovoItem.valor,
      imagem: pNovoItem.imagem,
      ativo: pNovoItem.ativo,
      dtCadastro: pNovoItem.dtCadastro,
    ));

    notifyListeners();
  }

  Future<void> loadItem() async {
    final response = await http.get("$_baseUrl.json?auth=$_token");
    Map<String, dynamic> data = json.decode(response.body);

    _todosItens.clear();
    if (data != null) {
      data.forEach((itemId, itemDados) {
        _todosItens.add(Item(
          id: itemId,
          descricao: itemDados['anuncio'],
          valor: itemDados['valor'],
          quantidade: itemDados['quantidade'],
        ));
      });
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> getItem() async {
    final response = await http.get("$_baseUrl.json?auth=$_token");
    Map<String, dynamic> data = json.decode(response.body);

    _todosItens.clear();
    if (data != null) {
      data.forEach((itemId, itemDados) {
        _todosItens.add(Item(
          id: itemId,
          descricao: itemDados['anuncio'],
          valor: itemDados['valor'],
          quantidade: itemDados['quantidade'],
        ));
      });
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> delete(String id) async {
    final index = _todosItens.indexWhere((anuncio) => anuncio.id == id);
    if (index >= 0) {
      final anuncio = _todosItens[index];
      _todosItens.remove(anuncio);
      notifyListeners();

      final response =
          await http.delete("$_baseUrl/${anuncio.id}.json?auth=$_token");

      if (response.statusCode >= 400) {
        _todosItens.insert(index, anuncio);
        notifyListeners();
        throw HttpException('Ocorreu um erro na exclusão do produto.');
      }
    }
  }

  Future<void> updateProduct(Item pItens) async {
    if (pItens == null || pItens.id == null) {
      return;
    }

    final index = _todosItens.indexWhere((anuncio) => anuncio.id == anuncio.id);
    if (index >= 0) {
      await http.patch(
        "$_baseUrl/${pItens.id}.json?auth=$_token",
        body: json.encode({
          'descricao': pItens.descricao,
          'quantidade': pItens.quantidade,
          'valor': pItens.valor,
        }),
      );
      _todosItens[index] = pItens;
      notifyListeners();
    }
  }
}
