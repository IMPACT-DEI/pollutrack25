import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:pollutrack25/models/heart_rate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class Impact{

  static String baseUrl = 'https://impact.dei.unipd.it/bwthw/';
  static String pingEndpoint = 'gate/v1/ping/';
  static String tokenEndpoint = 'gate/v1/token/';
  static String refreshEndpoint = 'gate/v1/refresh/';

  static String hrEndpoint = 'data/v1/heart_rate/patients/';

  static String impactUsername = 'Jpefaq6m58';

//This method allows to refresh the stored JWT in SharedPreferences
  Future<int> refreshTokens() async {
    //Create the request
    final url = Impact.baseUrl + Impact.refreshEndpoint;
    final sp = await SharedPreferences.getInstance();
    final refresh = sp.getString('refresh');
    if (refresh != null) {
      final body = {'refresh': refresh};

      //Get the response
      print('Calling: $url');
      final response = await http.post(Uri.parse(url), body: body);

      //If the response is OK, set the tokens in SharedPreferences to the new values
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        final sp = await SharedPreferences.getInstance();
        await sp.setString('access', decodedResponse['access']);
        await sp.setString('refresh', decodedResponse['refresh']);
      } //if

      //Just return the status code
      return response.statusCode;
    }
    return 401;
  } //_refreshTokens

  Future<int> getAndStoreTokens(String username, String password ) async {

    //Create the request
    final url = Impact.baseUrl + Impact.tokenEndpoint;
    final body = {'username': username, 'password': password};

    //Get the response
    print('Calling: $url');
    final response = await http.post(Uri.parse(url), body: body);

    //If response is OK, decode it and store the tokens. Otherwise do nothing.
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      final sp = await SharedPreferences.getInstance();
      await sp.setString('access', decodedResponse['access']);
      await sp.setString('refresh', decodedResponse['refresh']);
    } //if

    //Just return the status code
    return response.statusCode;
  } //_getAndStoreTokens

  Future<List<HR>> getHRData(DateTime date) async {
    
    List<HR> result = [];
    
    final sp = await SharedPreferences.getInstance();
    var access = sp.getString('access');

    //If access token is expired, refresh it
    if(JwtDecoder.isExpired(access!)){
      await refreshTokens();
      access = sp.getString('access');
    }

    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    final url = Impact.baseUrl + 'data/v1/heart_rate/patients/' + Impact.impactUsername + '/day/$formattedDate/';
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};

    print('Calling: $url');
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);

    print(decodedResponse['data']['date']);
    print(decodedResponse['data']['data'][0]);
    print(decodedResponse['data']['data'][0].runtimeType);
    
      for (var i = 0; i < decodedResponse['data']['data'].length; i++) {
        result.add(HR.fromJson(decodedResponse['data']['date'], decodedResponse['data']['data'][i]));
      }//for
    }
    return result;
  } //_getHRData


}//Impact

  