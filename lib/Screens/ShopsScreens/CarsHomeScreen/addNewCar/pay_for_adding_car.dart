import 'package:flutter/material.dart';
import 'package:racingApp/services/payment_service.dart';

class AddCarPayment extends StatefulWidget {
  AddCarPayment({this.useruid});

  final String useruid;

  @override
  _AddCarPaymentState createState() => _AddCarPaymentState();
}

class _AddCarPaymentState extends State<AddCarPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }

  @override
  void initState() {
    super.initState();
    StripeService.init();
  }
}
