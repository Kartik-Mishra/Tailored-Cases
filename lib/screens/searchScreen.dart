import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int totalAmount = 0;

  Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void checkout() {
    var options = {
      'key': 'rzp_test_qluNpjtBIszBk8',
      'amount': totalAmount * 100, //in the smallest currency sub-unit.
      'name': 'Testing',
      'description': 'product name here',
     // 'prefill': {'contact': '', 'email': ''},
      'external' : {
          'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    Fluttertoast.showToast(msg: "success"+ response.paymentId);
  }
  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
     Fluttertoast.showToast(msg: "error"+ response.message.toString() + " . "+ response.message);
  }
  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
     Fluttertoast.showToast(msg: "ext wallet"+ response.walletName);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        leading: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: IconButton(
            onPressed: (){checkout();},
            color: Colors.black.withOpacity(0.5), 
            icon: Icon(Icons.payment),
          ),
        ),
        centerTitle: false,
        title: new TextFormField(
          autofocus: true,
          decoration: new InputDecoration(
              hintText: 'Enter the amount', hintMaxLines: 1),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              totalAmount = num.parse(value);
            });
          },
        ),
      ),
      body: ListView.builder(
        itemCount: 30,
        itemBuilder: (context, item) {
          return ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.ac_unit),
            ),
          );
        },
      ),
    );
  }
}
