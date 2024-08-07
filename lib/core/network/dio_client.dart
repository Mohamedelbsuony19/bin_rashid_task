// import 'package:alkhbaz/dependency_injection/di_container.dart';
// import 'package:alkhbaz/dependency_injection/global.dart';
// import 'package:dio/dio.dart';
// import 'package:go_router/go_router.dart';

// import '../constants/end_points.dart';
// import '../constants/local_keys.dart';
// import '../routes/go_routes.dart';
// import '../routes/routes.dart';
// import '../services/cache_user.dart';
// import 'api_consumer.dart';
// import 'dio_exceptions_handler.dart';
// import 'network_interceptor.dart';

// class DioClient implements ApiConsumer {
//   late Dio dio;

//   DioClient() {
//     BaseOptions options = BaseOptions(
//       baseUrl: restBaseUrl,
//       headers: {
//         "Content-Type": Headers.formUrlEncodedContentType,
//       },
//       connectTimeout: const Duration(seconds: 10),
//       receiveTimeout: const Duration(seconds: 10),
//     );
//     dio = Dio(options);

//     dio.interceptors.add(NetworkInterceptor(handleError: (err, handler) async {
//       if (err.response?.statusCode == 401) {
//         try {
//           final username = preferences.getString(LocalKeys.userName);
//           final password = preferences.getString(LocalKeys.password);

//           final response = await dio.post(EndPoints.connectTokenUrl, data: {
//             "grant_type": "password",
//             "scope": "offline_access",
//             "username": username,
//             "password": password,
//           });

//           await CacheUser.tokens(
//             accessToken: response.data["access_token"],
//             refreshToken: response.data["refresh_token"],
//           ).saveTokens();
//         } catch (e) {
//           // TODO: Logout
//           final context = navigatorKey.currentState?.context;
//           if (context?.mounted ?? false) {
//             context?.goNamed(Routes.auth);
//           }
//         }
//       }
//     }));
//   }

//   @override
//   Future<Response<dynamic>> post(
//     String path, {
//     Object? data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//     ProgressCallback? onSendProgress,
//     ProgressCallback? onReceiveProgress,
//   }) async {
//     try {
//       Response<dynamic> response = await dio.post(
//         path,
//         data: data,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//         onSendProgress: onSendProgress,
//         onReceiveProgress: onReceiveProgress,
//       );
//       return response;
//     } on DioException catch (exception) {
//       throw DioExceptionHandler.handle(exception);
//     }
//   }

//   @override
//   Future<Response<dynamic>> delete(
//     String path, {
//     Object? data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//   }) async {
//     try {
//       Response<dynamic> response = await dio.delete(
//         path,
//         data: data,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//       );
//       return response;
//     } on DioException catch (exception) {
//       throw DioExceptionHandler.handle(exception);
//     }
//   }

//   @override
//   Future<Response<dynamic>> get(
//     String path, {
//     Object? data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//     ProgressCallback? onReceiveProgress,
//   }) async {
//     try {
//       Response<dynamic> response = await dio.get(
//         path,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//         onReceiveProgress: onReceiveProgress,
//       );
//       return response;
//     } on DioException catch (exception) {
//       throw DioExceptionHandler.handle(exception);
//     }
//   }

//   @override
//   Future<Response<dynamic>> put(
//     String path, {
//     Object? data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//     ProgressCallback? onSendProgress,
//     ProgressCallback? onReceiveProgress,
//   }) async {
//     try {
//       Response<dynamic> response = await dio.put(
//         path,
//         data: data,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//         onSendProgress: onSendProgress,
//         onReceiveProgress: onReceiveProgress,
//       );
//       return response;
//     } on DioException catch (exception) {
//       throw DioExceptionHandler.handle(exception);
//     }
//   }
// }
