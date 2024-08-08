import 'package:flutter/material.dart';

class NoInternetConnectionScreen extends StatelessWidget {
  final VoidCallback onRetry;

  const NoInternetConnectionScreen({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.wifi_off,
                color: Colors.redAccent,
                size: 80.0,
              ),
              const SizedBox(height: 20.0),
              Text(
                'No Internet Connection',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.black87,
                    ),
              ),
              const SizedBox(height: 10.0),
              Text(
                'Please check your internet settings and try again.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                    ),
              ),
              const SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 15.0),
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text(
                  'Retry',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
