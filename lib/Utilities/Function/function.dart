import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:matchfinder/Utilities/Function/url.dart';

getDate(String date) async {
  final getAppraisalsKey = UrlLinks.systemCodeUrl;
  Dio dio = Dio();
  var a = {"type": date};
  Response response =
      await dio.post(getAppraisalsKey, data: FormData.fromMap(a));
  return response.data['code'];
}

getCountry() async {
  final getAppraisalsKey = UrlLinks.countryUrl;
  Dio dio = Dio();
  Response response = await dio.get(getAppraisalsKey);
  return response.data['countries'];
}

getCountryISD() async {
  final getAppraisalsKey = UrlLinks.countryISDUrl;
  Dio dio = Dio();
  Response response = await dio.get(getAppraisalsKey);
  return response.data['countryisd'];
}

getMotherTongue() async {
  final getAppraisalsKey = UrlLinks.motherTongueUrl;
  Dio dio = Dio();
  Response response = await dio.get(getAppraisalsKey);
  return response.data['mothertongue'];
}

getReligion() async {
  final getAppraisalsKey = UrlLinks.religionUrl;
  Dio dio = Dio();
  Response response = await dio.get(getAppraisalsKey);
  return response.data['religion'];
}

getChurch() async {
  final getAppraisalsKey = UrlLinks.systemCodeUrl;
  Dio dio = Dio();
  var a = {"type": 'CHURCH'};
  Response response =
      await dio.post(getAppraisalsKey, data: FormData.fromMap(a));
  return response.data['code'];
}

getCast(String cast) async {
  final getAppraisalsKey = UrlLinks.casteUrl;
  Dio dio = Dio();
  var a = {"q": cast};
  Response response =
      await dio.post(getAppraisalsKey, data: FormData.fromMap(a));
  return response.data['casteList'];
}

getCity(String city) async {
  final getAppraisalsKey = UrlLinks.cityUrl;
  Dio dio = Dio();
  var a = {"q": city};
  Response response =
      await dio.post(getAppraisalsKey, data: FormData.fromMap(a));
  return response.data['cityList'];
}

getRelationShip() async {
  final getAppraisalsKey = UrlLinks.systemCodeUrl;
  Dio dio = Dio();
  var a = {"type": 'PROFILE_CREATOR'};
  Response response =
      await dio.post(getAppraisalsKey, data: FormData.fromMap(a));
  return response.data['code'];
}

resetMail(String email) async {
  Dio dio = Dio();
  final response = await dio.post(
    UrlLinks.resetUrl,
    queryParameters: {
      "marsid": email,
    },
  );
  return response;
}

signUp({
  String email,
  String password,
  String name,
  String lastName,
  String gender,
  String day,
  String month,
  String year,
  String motherTongue,
  String religion,
  String cast,
  String country,
  String relationShip,
  String countryISD,
  String phone,
}) async {
  Dio dio = Dio();
  var cookieJar = CookieJar();
  dio.interceptors.add(CookieManager(cookieJar));
  final response = await dio.post(
    UrlLinks.signUpUrl,
    queryParameters: {
      "emailbd": email,
      "pwordbd": password,
      "firstnamebd": name,
      "lastnamebd": lastName,
      "genderbd": gender,
      "daybd": day,
      "monthbd": month,
      "yearbd": year,
      "mothertonguebd": motherTongue,
      "religionbd": religion,
      "castenamebd": cast,
      "countrybd": country,
      "profilecreatorbd": relationShip,
      "phoneisdbd": countryISD,
      "phonenobd": phone,
    },
  );
  return response;
}

login(String email, String password) async {
  var dio = Dio();
  var cookieJar = CookieJar();
  dio.interceptors.add(CookieManager(cookieJar));
  final response = await dio.post(
    UrlLinks.loginUrl,
    queryParameters: {
      "username": email,
      "password": password,
    },
  );
  return response;
}

getSession() async {
  var dio = Dio();
  var cookieJar = CookieJar();
  dio.interceptors.add(CookieManager(cookieJar));
  List<Cookie> value = cookieJar.loadForRequest(Uri.parse(UrlLinks.loginUrl));
  if (value.isNotEmpty) {
    print(value);
    if (value[0].name == 'JSESSIONID' && value[0].path == '/matrimony/') {
      return value[0].value;
    }
  }
}

getDetails() async {
  final getAppraisalsKey = UrlLinks.editAllDetails;
  Dio dio = Dio();
  var cookieJar = CookieJar();
  dio.interceptors.add(CookieManager(cookieJar));
  Response response = await dio.post(getAppraisalsKey);
  return response;
}

getCaste() async {
  Dio dio = Dio();
  final getAppraisalsKey = UrlLinks.getCasteDetails;
  BaseOptions baseOptions = new BaseOptions(
    baseUrl: UrlLinks.baseUrl,
    validateStatus: (status) {
      return status <= 500;
    },
    // connectTimeout: 300,
  );
  dio = new Dio(baseOptions);
  dio.interceptors.add(DioCacheManager(
    CacheConfig(
      baseUrl: UrlLinks.baseUrl,
      defaultMaxAge: Duration(hours: 1),
    ),
  ).interceptor);
  Response response = await dio.get(getAppraisalsKey);
  return response;
}

getPaymentPackages() async {
  final getAppraisalsKey = UrlLinks.addons;
  Dio dio = Dio();
  var cookieJar = CookieJar();
  dio.interceptors.add(CookieManager(cookieJar));
  Response response = await dio.post(getAppraisalsKey);
  print(response.data);
  return response;
}

getPlans() async {
  final getAppraisalsKey = UrlLinks.plans;
  Dio dio = Dio();
  var cookieJar = CookieJar();
  dio.interceptors.add(CookieManager(cookieJar));
  Response response = await dio.post(getAppraisalsKey);
  print(response.data);
  return response;
}

submitData(String link, query) async {
  Dio dio = Dio();
  var cookieJar = CookieJar();
  dio.interceptors.add(CookieManager(cookieJar));
  Response response = await dio.post(link, queryParameters: query);
 print(response);
  return response;
}
checkoutData(String link) async {
  Dio dio = Dio();
  var cookieJar = CookieJar();
  dio.interceptors.add(CookieManager(cookieJar));
  Response response = await dio.post(link);
 print(response);
  return response;
}

// getMartialStatus() async {
//   final getAppraisalsKey =
//       'https://www.matchfinder.in/matrimony/profile/ed/probasicdetregsubmit.htm';
//   Dio dio = Dio();
//   var cookieJar = CookieJar();
//   dio.interceptors.add(CookieManager(cookieJar));
//   List<Cookie> value = cookieJar.loadForRequest(Uri.parse(UrlLinks.loginUrl));
//   Response response = await dio.post(getAppraisalsKey);
//   print(response.data);
//   // return response.data['marstatusbd'];
// }
//
// getHighestEducationStatus() async {
//   final getAppraisalsKey =
//       'https://www.matchfinder.in/matrimony/profile/ed/eduemplsubmit.htm';
//   Dio dio = Dio();
//   Response response = await dio.get(getAppraisalsKey);
//   return response.data['marstatusbd'];
// }

// getAnnualIncomeStatus() async {
//   final getAppraisalsKey = 'https://www.matchfinder.in/matrimony/profile/ed/probasicdetregsubmit.htm';
//   Dio dio = Dio();
//   Response response =
//   await dio.get(getAppraisalsKey);
//   return response.data['marstatusbd'];
// }
