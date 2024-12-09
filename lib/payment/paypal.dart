// import 'package:flutter/material.dart';
// import 'package:flutter_paypal/flutter_paypal.dart';

// class PayPal extends StatefulWidget {
//   const PayPal({super.key});

//   @override
//   State<PayPal> createState() => _PayPalState();
// }

// class _PayPalState extends State<PayPal> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: UsePaypal(
//           sandboxMode: true,
//           clientId:
//               "AW1TdvpSGbIM5iP4HJNI5TyTmwpY9Gv9dYw8_8yW5lYIbCqf326vrkrp0ce9TAqjEGMHiV3OqJM_aRT0",
//           secretKey:
//               "EHHtTDjnmTZATYBPiGzZC_AZUfMpMAzj2VZUeqlFUrRJA_C0pQNCxDccB5qoRQSEdcOnnKQhycuOWdP9",
//           returnURL: "https://samplesite.com/return",
//           cancelURL: "https://samplesite.com/cancel",
//           transactions: const [
//             {
//               "amount": {
//                 "total": '1500',
//                 "currency": "NGN",
//                 "details": {
//                   "subtotal": '10.12',
//                   "shipping": '0',
//                   "shipping_discount": 0
//                 }
//               },
//               "description": "The payment transaction description.",
//               // "payment_options": {
//               //   "allowed_payment_method":
//               //       "INSTANT_FUNDING_SOURCE"
//               // },
//               "item_list": {
//                 "items": [
//                   {
//                     "name": "A demo product",
//                     "quantity": 1,
//                     "price": '10.12',
//                     "currency": "USD"
//                   }
//                 ],
//                 "shipping_address": {
//                   "recipient_name": "Jane Foster",
//                   "line1": "Travis County",
//                   "line2": "",
//                   "city": "Austin",
//                   "country_code": "US",
//                   "postal_code": "73301",
//                   "phone": "+00000000",
//                   "state": "Texas"
//                 },
//               }
//             }
//           ],
//           note: "Contact us for any questions on your order.",
//           onSuccess: (Map params) async {
//             print("onSuccess: $params");
//           },
//           onError: (error) {
//             print("onError: $error");
//           },
//           onCancel: (params) {
//             print('cancelled: $params');
//           }),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';

class Paypal extends StatefulWidget {
  const Paypal({
    super.key,
  });

  @override
  State<Paypal> createState() => PayPal();
}

class PayPal extends State<Paypal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UsePaypal(
          sandboxMode: true,
          clientId:
              "AW1TdvpSGbIM5iP4HJNI5TyTmwpY9Gv9dYw8_8yW5lYIbCqf326vrkrp0ce9TAqjEGMHiV3OqJM_aRT0",
          secretKey:
              "EHHtTDjnmTZATYBPiGzZC_AZUfMpMAzj2VZUeqlFUrRJA_C0pQNCxDccB5qoRQSEdcOnnKQhycuOWdP9",
          returnURL: "https://samplesite.com/return",
          cancelURL: "https://samplesite.com/cancel",
          transactions: const [
            {
              "amount": {
                "total": '10.12',
                "currency": "USD",
                "details": {
                  "subtotal": '10.12',
                  "shipping": '0',
                  "shipping_discount": 0
                }
              },
              "description": "The payment transaction description.",
              // "payment_options": {
              //   "allowed_payment_method":
              //       "INSTANT_FUNDING_SOURCE"
              // },
              "item_list": {
                "items": [
                  {
                    "name": "A demo product",
                    "quantity": 1,
                    "price": '10.12',
                    "currency": "USD"
                  }
                ],

                // shipping address is not required though
                "shipping_address": {
                  "recipient_name": "Jane Foster",
                  "line1": "Travis County",
                  "line2": "",
                  "city": "Austin",
                  "country_code": "US",
                  "postal_code": "73301",
                  "phone": "+00000000",
                  "state": "Texas"
                },
              }
            }
          ],
          note: "Contact us for any questions on your order.",
          onSuccess: (Map params) async {
            print("onSuccess: $params");
          },
          onError: (error) {
            print("onError: $error");
          },
          onCancel: (params) {
            print('cancelled: $params');
          }),
    );
  }
}
