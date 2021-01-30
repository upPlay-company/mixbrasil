import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mix_brasil/model/cep/cep_aberto_address.dart';

const token = '866968b5a2faee988b72d9c44dc63d52';

class CepAbertoService {

  Future<CepAbertoAddress> getAddressFromCep(String cep) async {
    final cleanCep = cep.replaceAll('.', '').replaceAll(('-'), '');
    final endpoint = "https://www.cepaberto.com/api/v3/cep?cep=$cleanCep";

    final Dio dio = Dio();

    dio.options.headers[HttpHeaders.authorizationHeader] = 'Token token=$token';

    try{
      final response = await dio.get<Map<String, dynamic>>(endpoint);

      if(response.data.isEmpty){
        return Future.error('CEP Inválido');
      }

      final CepAbertoAddress address = CepAbertoAddress.fromMap(response.data);

      return address;
    } on DioError {
      return Future.error('Erro ao buscar CEP');
    }
  }
}