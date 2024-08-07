import 'dart:async';

import 'package:bin_rashid_task_app/data/repos/product_repo.dart';
import 'package:bin_rashid_task_app/presentation/blocs/products/products_bloc.dart';
import 'package:bin_rashid_task_app/presentation/ui/screens/home_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductsBloc(ProductRepo())..add(const ProductsEvent.getProducts()),
      child: const MaterialApp(
        home: ConnectivityWidget(child: HomeScreen()),
      ),
    );
  }
}

class ConnectivityWidget extends StatefulWidget {
  final Widget child;

  const ConnectivityWidget({required this.child, super.key});

  @override
  State<ConnectivityWidget> createState() => _ConnectivityWidgetState();
}

class _ConnectivityWidgetState extends State<ConnectivityWidget> {
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool _isDialogShowing = false;

  get developer => null;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Initialize connectivity
  Future<void> initConnectivity() async {
    List<ConnectivityResult> result;
    try {
      result = [await _connectivity.checkConnectivity()];
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    if (!mounted) {
      return;
    }

    return _updateConnectionStatus(result.first);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = [result];
    });

    if (result == ConnectivityResult.none) {
      _showNoConnectionDialog();
    } else {
      if (_isDialogShowing) {
        Navigator.pop(context); // Close the dialog when connection is restored
        _isDialogShowing = false;
      }
    }
  }

  void _showNoConnectionDialog() {
    _isDialogShowing = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('No Internet Connection'),
          content: const Text('Please check your internet settings.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _isDialogShowing = false;
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
