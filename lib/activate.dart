import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab5/home.dart';

class ActivationScreen extends StatefulWidget {
  const ActivationScreen({Key? key}) : super(key: key);

  @override
  State<ActivationScreen> createState() => _ActivationScreenState();
}

class _ActivationScreenState extends State<ActivationScreen> {
  bool isChecked = false;
  TextEditingController _controller = TextEditingController();
  int _otpCounter = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _isInputValid(String value) {
    return value.length == 6;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    bool isTablet = screenSize.width > 600;

    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.red[100],

          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 50, 20, 50),

              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(isTablet ? screenSize.width * 0.08 : 0, 0, 20, 0),

                    child: Row(
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              'images/upm_logo.png',
                              width: isTablet ? screenSize.width * 0.2 : screenSize.width * 0.4,
                              height: isTablet ? screenSize.height * 0.15 : screenSize.height * 0.1,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 10),
                            Text('Welcome!',
                              style: TextStyle(
                                fontSize: isTablet ? 50 : 30,
                                fontWeight: FontWeight.w600,
                              ),),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: isTablet ? screenSize.width * 0.8 : screenSize.width * 0.85,
                        height: isTablet ? screenSize.height * 0.6 : screenSize.height * 0.45,
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: screenSize.height * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: isTablet ? screenSize.width * 0.6 : screenSize.width * 0.7,
                                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),

                                  child: Text('Enter the activation code you received via SMS.',
                                    style: TextStyle(
                                      fontSize: isTablet ? 30 : 18,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(width: screenSize.width * 0.005),
                                GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.error_outline,
                                    size: isTablet ? 40 : 30,
                                  ),
                                ),
                                SizedBox(width: screenSize.width * 0.005),
                              ],
                            ),
                            SizedBox(height: screenSize.height * 0.05),
                            Center(
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                                width: isTablet ? screenSize.width * 0.7 : screenSize.width * 0.7,
                                height: isTablet ? screenSize.height * 0.15 : screenSize.height * 0.1,

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: _controller,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          SixDigitInputFormatter(),
                                        ],
                                        keyboardType: TextInputType.phone,
                                        onChanged: (value) {
                                          setState(() {
                                            _otpCounter = value.length;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                                          hintText: 'OTP',
                                          hintStyle: TextStyle(fontSize: isTablet ? 30 : 20),
                                          fillColor: Colors.white,
                                          filled: true,
                                          isDense: true,
                                        ),
                                        style: TextStyle(
                                          fontSize: isTablet ? 30 : 20,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Text('$_otpCounter/6',
                                      style: TextStyle(
                                        fontSize: isTablet ? 26 : 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: screenSize.height * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Didn\'t receive?',
                                  style: TextStyle(fontSize: isTablet ? 26 : 16),
                                ),
                                GestureDetector(
                                  onTap: () {

                                  },
                                  child: Text(
                                    'Tap here',
                                    style: TextStyle(
                                      fontSize: isTablet ? 26 : 16,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenSize.height * 0.02),
                            Center(
                              child: Container(
                                width: isTablet ? screenSize.width * 0.2 : screenSize.width * 0.4,
                                height: isTablet ? screenSize.height * 0.1 : screenSize.height * 0.05,
                                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: ElevatedButton(
                                  onPressed: _isInputValid(_controller.text) ? () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const HomePage()),
                                    );
                                  }
                                      : null,
                                  child: Text('Activate',
                                    style: TextStyle(
                                      fontSize: isTablet ? 28 : 18,
                                      fontWeight: FontWeight.normal,
                                    ),)
                                  ,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: isTablet ? screenSize.width * 0.9 : screenSize.width * 0.9,
                    height: isTablet ? screenSize.height * 0.2 : screenSize.height * 0.2,
                    alignment: Alignment.center,

                    child: Column(
                      children: [
                        SizedBox(height: screenSize.height * 0.1),
                        GestureDetector(
                          onTap: () {

                          },
                          child: Text(
                            'Disclaimer | Privacy Statement',
                            style: TextStyle(
                              fontSize: isTablet ? 22 : 16,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.02),
                        Flexible(
                          child: Text('Copyright UPM & Kejuruteraan minyak Swait CCS Sdn. Bhd.',
                            style: TextStyle(
                                fontSize: isTablet ? 22 : 16,
                                fontWeight: FontWeight.normal
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SixDigitInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > 6) {
      // Limit the input to 6 characters
      return oldValue;
    }
    return newValue;
  }
}