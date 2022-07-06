import 'package:http/http.dart' as http;
import 'package:kurdish_names/src/model/kurdish_names_model.dart';

class RequestNames {
// https://github.com/DevelopersTree/nawikurdi
// https://nawikurdi.com/
//API end point : https://nawikurdi.com/api

//create method with type future to send request to the api .
  Future<KurdishName> getnames(String limit, String gender) async {
    //create url to send request for it.
    Uri url = Uri(
      scheme: 'https',
      host: 'nawikurdi.com',
      path: 'api',
      //query paramaeter are used for get request.
      queryParameters: {
        'limit': limit,
        'gender': gender,
        'offset': '0',
      },
    );

    //get response from the api if there is any data
    //send get() request to the api
    http.Response response =
        await http.get(Uri.parse(url.toString())).catchError(
              (err) => print(err),
            );
    return KurdishName.fromJson(response.body);
  }
}
