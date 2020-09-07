import 'dart:convert';

import 'package:http/http.dart' as http;

getIcampff(params) async {
  final endpoint = 'http://buritaca.invemar.org.co/ICAMWebService/calculate-icam-ae';

  var response = await http.get(endpoint
      + '/od/' + params["dissolvedOxygen"] + '/no3/' + params["nitrate"]
      + '/sst/' + params["totalSuspendedSolids"] + '/ctt/' + params["thermotolerantColiforms"]
      + '/ph/' + params["pH"] + '/po4/' + params["phosphates"]
      + '/dbo/' + params["biochemicalOxygenDemand"] + '/cla/' + params["chrolophyllA"]);

  if (response.statusCode == 200) {
    return json.decode(response.body.toString());
  } else {
    throw Exception('Invemar API is down');
  }
}