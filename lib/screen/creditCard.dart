import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yatrigan/screen/ticket.dart';
import '../Utilitis/service.dart';
import '../main.dart';
import 'package:yatrigan/Utilitis/firebaseServise.dart';

String cardHolderName = '';
String cardNumber = '';
String expiryDate = '';
int cvv = 0;

class CreditCard extends StatefulWidget {
  const CreditCard({super.key});

  @override
  State<CreditCard> createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  final TextEditingController _cardHolderName = TextEditingController();
  final TextEditingController _cardNumber = TextEditingController();
  final TextEditingController _expiryDate = TextEditingController();
  final TextEditingController _cvv = TextEditingController();

  @override
  void dispose() {
    _cardHolderName.dispose();
    _cardNumber.dispose();
    _expiryDate.dispose();
    _cvv.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xFF499D95),
            )),
        title: const Text(
          'Credit Card',
          style: TextStyle(
            color: Color(0xFF499D95),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 450,
              width: double.infinity,
              margin: const EdgeInsets.only(top: 10, right: 30, left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'CardHolder Name',
                    style: TextStyle(
                      color: Color(0xFF499D95),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextField(
                    controller: _cardHolderName,
                    onChanged: (value) {
                      setState(() {
                        cardHolderName = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: '',
                      hintStyle: TextStyle(
                        color: Color(0xFF499D95),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'CardNumber',
                    style: TextStyle(
                      color: Color(0xFF499D95),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextField(
                    controller: _cardNumber,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        cardNumber = value;
                      });
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(19),
                      FilteringTextInputFormatter.digitsOnly,
                      CardNumnberFormatter(),
                    ],
                    decoration: const InputDecoration(
                      hintText: '1234 5678 9012 3456',
                      hintStyle: TextStyle(
                        color: Color(0xFF499D95),
                      ),
                      fillColor: Colors.white,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              'Expiry Date',
                              style: TextStyle(
                                color: Color(0xFF499D95),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextField(
                              controller: _expiryDate,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  expiryDate = value;
                                });
                              },
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(5),
                                FilteringTextInputFormatter.digitsOnly,
                                CardMonthInputFormatter()
                              ],
                              decoration: const InputDecoration(
                                hintText: 'MM/YY',
                                hintStyle: TextStyle(
                                  color: Color(0xFF499D95),
                                ),
                                fillColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              'CVV',
                              style: TextStyle(
                                color: Color(0xFF499D95),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextField(
                              controller: _cvv,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  cvv = int.parse(value);
                                });
                              },
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(3),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: const InputDecoration(
                                hintText: '123',
                                hintStyle: TextStyle(
                                  color: Color(0xFF499D95),
                                ),
                                fillColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: const Color(0xFF499D95),
                    onPressed: () {
                      if (Service().validatepay(context)) {
                        FirebaseService().addBookedSeat();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Payment Successful'),
                          ),
                        );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Ticket()));
                      }
                    },
                    child: const Center(
                      child: Text(
                        'Pay',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
