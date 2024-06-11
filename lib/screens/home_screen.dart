import 'package:flutter/material.dart';
import 'package:interview/methods/navigate_to.dart';
import 'package:interview/screens/invoice_details_screen.dart';
import 'package:interview/screens/invoices_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.blue),
              ),
              onPressed: () {
                navigateTo(
                  context,
                  InvoiceDetailsScreen(),
                );
              },
              child: const Text(
                "Invoice Details",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.blue),
              ),
              onPressed: () {
                navigateTo(
                  context,
                  const InvoicesScreen(),
                );
              },
              child: const Text(
                "Invoice List",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
