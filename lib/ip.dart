import 'package:flutter/material.dart';

import 'package:love_bird/providers/ip_address.dart';

//import 'dart:developer' as developer;
class IpAddressScreen extends StatelessWidget {
  final IpAddressProvider provider;

  const IpAddressScreen({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get IP Address'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            provider.ipAddress == null
                ? const Text('Press the button to fetch IP Address')
                : Text('IP Address: ${provider.ipAddress}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await provider.fetchIpAddress();
              },
              child: const Text('Get IP Address'),
            ),
          ],
        ),
      ),
    );
  }
}
