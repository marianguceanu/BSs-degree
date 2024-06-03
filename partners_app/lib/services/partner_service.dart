import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:partners_app/constants/api_urls.dart';
import 'package:partners_app/models/partner.dart';
import 'package:partners_app/models/signup.dart';
import 'package:partners_app/models/user.dart';
import 'package:partners_app/services/storage_service.dart';

class PartnerApiService {
  Future<void> updateCookie(http.Response response) async {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      await storageService.write(
          cookieKey, (index == -1) ? rawCookie : rawCookie.substring(0, index));
    }
  }

  Future<int> login(User user) async {
    // Building the login URL
    const String url =
        UrlConstants.base + UrlConstants.user + UrlConstants.login;

    // Making the POST request
    http.Response response =
        await http.post(Uri.parse(url), body: jsonEncode(user));
    await updateCookie(response);

    // Return the status code
    return response.statusCode;
  }

  Future<int> signUp(SignUp signupBody) async {
    // Building the signup URL
    const String url =
        UrlConstants.base + UrlConstants.user + UrlConstants.signup;

    // Making the POST request
    http.Response response =
        await http.post(Uri.parse(url), body: jsonEncode(signupBody));

    // Return the status code
    return response.statusCode;
  }

  Future<List<Partner>> topFive() async {
    // Building the top five URL
    const String url =
        UrlConstants.base + UrlConstants.partners + UrlConstants.topFive;

    // Getting the cookies
    String? cookies = await storageService.read(cookieKey);

    http.Response response = await http.get(
      Uri.parse(url),
      headers: {'cookie': cookies ?? ''},
    );

    List<dynamic> partners = jsonDecode(response.body);
    return partners.map((partner) => Partner.fromJson(partner)).toList();
  }

  Future<int> validateToken() async {
    // Building the validate token URL
    const String url =
        UrlConstants.base + UrlConstants.user + UrlConstants.validateToken;

    // Getting the token from storage
    String? cookies = await storageService.read(cookieKey);

    // Making the GET request
    http.Response response = await http.get(
      Uri.parse(url),
      headers: {'cookie': cookies ?? ''},
    );

    return response.statusCode;
  }

  Future<List<Partner>> getPartners() async {
    // Building the get partners URL
    const String url = UrlConstants.base + UrlConstants.partners;

    // Getting the token from storage
    String? cookie = await storageService.read(cookieKey);

    // Making the GET request
    http.Response response = await http.get(Uri.parse(url), headers: {
      'cookie': cookie ?? '',
    });

    if (response.statusCode == 200) {
      List<dynamic> partners = jsonDecode(response.body);
      return partners.map((partner) => Partner.fromJson(partner)).toList();
    }
    return [];
  }

  Future<int> getPartnerId() async {
    const String url =
        UrlConstants.base + UrlConstants.user + UrlConstants.getId;
    // Getting the token from storage
    String? cookie = await storageService.read(cookieKey);

    // Making the GET request
    http.Response response = await http.get(Uri.parse(url), headers: {
      'cookie': cookie ?? '',
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> resp = jsonDecode(response.body);
      await storageService.write(partnerIdKey, resp['partner_id'].toString());
      return resp['partner_id']!;
    }
    return 0;
  }

  Future<Partner> getPartnerById(int id) async {
    String url = '${UrlConstants.base}${UrlConstants.partners}/$id';
    String? cookie = await storageService.read(cookieKey);
    http.Response response = await http.get(Uri.parse(url), headers: {
      'cookie': cookie ?? '',
    });

    if (response.statusCode == 200) {
      return Partner.fromJson(jsonDecode(response.body));
    }
    return Partner(
        id: 0,
        businessName: '',
        address: '',
        phoneNumber: '',
        contactPerson: '',
        email: '',
        reach: 0);
  }

  Future<int> updatePartner(Partner partner) async {
    String url = '${UrlConstants.base}${UrlConstants.partners}';
    String? cookie = await storageService.read(cookieKey);
    http.Response response = await http.put(Uri.parse(url),
        headers: {
          'cookie': cookie ?? '',
        },
        body: jsonEncode(partner.toJson()));

    if (response.statusCode == 200) {
      return response.statusCode;
    }
    return 0;
  }
}

final PartnerApiService partnerService = PartnerApiService();
List<Partner> partners = [];
