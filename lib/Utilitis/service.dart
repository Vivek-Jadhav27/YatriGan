import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../main.dart';
import '../screen/buses.dart';
import '../screen/creditCard.dart';

class Service {
  bool validateContinue(BuildContext context) {
    bool hasError = false;
    for (int i = 0; i < maxPassengerAll; i++) {
      if (personAll[i].isEmpty) {
        hasError = true;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter passenger name'),
          ),
        );
      }
      if (ageAll[i] == 0) {
        hasError = true;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter age'),
          ),
        );
      }
      if (genderAll[i].isEmpty) {
        hasError = true;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Plearse male')));
      }
    }
    if (emailAll.isEmpty) {
      hasError = true;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please enter email')));
    }
    if (phoneAll.isEmpty) {
      hasError = true;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please enter phone number')));
    }
    return hasError;
  }

  bool validateCardHolderName(BuildContext context, String cardHolderName) {
    if (cardHolderName == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your name'),
        ),
      );
      return false;
    } else {
      return true;
    }
  }

  bool validateCardNumber(BuildContext context, String cardNumber) {
    String newcardNumber = getClearedText(cardNumber);
    if (newcardNumber == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your card number'),
        ),
      );
      return false;
    } else {
      if (newcardNumber.length == 16) {
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a valid card number'),
          ),
        );
        return false;
      }
    }
  }

  bool validateExpiryDate(BuildContext context, String expiryDate) {
    List<int> newexpiryDate = getMonth(expiryDate);

    if (newexpiryDate.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your expiry date'),
        ),
      );
      return false;
    } else {
      final int month = newexpiryDate[0] * 10 + newexpiryDate[1];
      final int year = newexpiryDate[2] * 10 + newexpiryDate[3];
      final DateTime now = DateTime.now();
      final int currentYear = now.year % 100;
      final int currentMonth = now.month;

      if (month > 12 || month < 1) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a valid month'),
          ),
        );
        return false;
      } else if (year < currentYear) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a valid year'),
          ),
        );
        return false;
      } else if (year == currentYear && month < currentMonth) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a valid month'),
          ),
        );
        return false;
      } else {
        return true;
      }
    }
  }

  bool validateCvv(BuildContext context, int cvv) {
    if (cvv == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your cvv'),
        ),
      );
      return false;
    } else {
      if (cvv.toString().length == 3) {
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a valid cvv'),
          ),
        );
        return false;
      }
    }
  }

  bool validatepay(BuildContext context) {
    return (validateCardHolderName(context, cardHolderName) &&
        validateCardNumber(context, cardNumber) &&
        validateExpiryDate(context, expiryDate) &&
        validateCvv(context, cvv));
  }

  static String getClearedText(String text) {
    RegExp regExp = RegExp(r'[^0-9]');
    return text.replaceAll(regExp, '');
  }

  static List<int> getMonth(String text) {
    List<int> month = [];
    for (int i = 0; i < text.length; i++) {
      if (text[i] == '/') {
        continue;
      } else {
        month.add(int.parse(text[i]));
      }
    }
    return month;
  }
}

class CardNumnberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(' ');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != text.length) {
        buffer.write('/');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
