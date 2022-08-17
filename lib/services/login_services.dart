
import 'package:axolon_container/model/login_model.dart';
import 'package:http/http.dart' as http;

class RemoteServicesLogin {
  Future<Login?> getLogin(String url,String data) async {
   
    print(data);

    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: data,
    );

    if (response.statusCode == 200) {
      final String responseString = response.body;
      print(responseString);
      return loginFromJson(responseString);
    } else {
      return null;
    }
  }
}
