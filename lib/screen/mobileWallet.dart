import 'package:flutter/material.dart';

class MobileWallet extends StatefulWidget {
  const MobileWallet({super.key});

  @override
  State<MobileWallet> createState() => _MobileWalletState();
}

class _MobileWalletState extends State<MobileWallet> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Color(0xFF499D95),
              )
          ),
          title: Text('Mobile wallet',
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
                margin: EdgeInsets.only(top: 10, right: 30, left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CardHolder Name',
                      style: TextStyle(
                        color: Color(0xFF499D95),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: '',
                        hintStyle: TextStyle(
                          color: Color(0xFF499D95),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),                  
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'CardNumber',
                      style: TextStyle(
                        color: Color(0xFF499D95),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
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
                        Container(
                          width: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                'Expiry Date',
                                style: TextStyle(
                                  color: Color(0xFF499D95),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextField(
                                decoration: InputDecoration(
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
                        Container(
                          width: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                'CVV',
                                style: TextStyle(
                                  color: Color(0xFF499D95),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextField(
                                decoration: InputDecoration(
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
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: (){},
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        elevation: 0,                        
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Color(0xFF499D95),
                        
                        onPressed: () {  },
                        child: Center(
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