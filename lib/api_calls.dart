import 'dart:convert';

import 'package:http/http.dart' as http;

Future getContacts() async {
  final response = await http.get('https://api.rootnet.in/covid19-in/contacts');
  return jsonDecode(response.body);
}

Future getNotifications() async {
  final response =
      await http.get('https://api.rootnet.in/covid19-in/notifications');
  return jsonDecode(response.body);
}
// Future getContacts() async {
//   final response = await http.get('https://api.rootnet.in/covid19-in/contacts');
//   return jsonDecode(response.body);
// }
