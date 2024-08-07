// import 'dart:convert';
// import 'dart:developer';

// import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:vendor_foody/core/constants/constants.dart';
// import 'package:vendor_foody/core/di/global.dart';
// import 'package:vendor_foody/data/network/api_consumer.dart';

// import '../../core/constants/end_points.dart';
// import '../../core/constants/local_keys.dart';
// import '../../core/services/cache_user.dart';


// class CustomHttpLink extends HttpLink {
//   final ApiConsumer apiConsumer;
//   final String graphQLBaseUrl;
//   CustomHttpLink({
//     required this.apiConsumer,
//     required this.graphQLBaseUrl,
//   }) : super(graphQLBaseUrl, httpResponseDecoder: (httpResponse) async {
//           // httpResponse.body?['errors'];
//           final myResponse = json.decode(
//             utf8.decode(
//               httpResponse.bodyBytes,
//             ),
//           ) as Map<String, dynamic>?;

//           /// Get GraphQL Query or Mutation name
//           final String? errorCode =
//               myResponse?['errors']?[0]?['extensions']?['code'];
//           log("::: API Response:: $myResponse #*#:::");
//           log("::: Error Data:: $errorCode #*#:::");

//           if (errorCode?.toLowerCase() == "unauthorized") {
//             try {
//               final isAnonymous =
//                   preferences.getBool(LocalKeys.isUserAnonymous) ?? false;
//               if (isAnonymous) {
//                 final response = await apiConsumer.post(
//                   EndPoints.connectTokenUrl,
//                   data: {
//                     "grant_type": "client_credentials",
//                     "client_id": AppConstants.clientId,
//                     "client_secret": AppConstants.clientSecret,
//                   },
//                 );

//                 log(
//                     "::: Anonymous access token - from client secret: ${response.data["access_token"]} :::");

//                 await preferences.setString(
//                     LocalKeys.accessToken, response.data["access_token"]);
//               } else {
//                 // final ctx = navigatorKey.currentContext;
//                 // if (ctx != null) {
//                 //   ctx.read<LogoutBloc>().add(
//                 //         const LogoutEvent.started(),
//                 //       );
//                 // }
//                 final username = preferences.getString(LocalKeys.userName);
//                 final password = preferences.getString(LocalKeys.password);

//                 final response = await apiConsumer.post(
//                   EndPoints.connectTokenUrl,
//                   data: {
//                     "grant_type": "password",
//                     "scope": "offline_access",
//                     "username": username,
//                     "password": password,
//                   },
//                 );

//                 await CacheUser.tokens(
//                   accessToken: response.data["access_token"],
//                   refreshToken: response.data["refresh_token"],
//                 ).saveTokens();
//               }
//             } catch (e) {
//               logger.e("::: Error: $e :::");
//             }
//           }

//           return myResponse;
//         });
// }
