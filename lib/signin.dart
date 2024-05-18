import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab5/activate.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isChecked = false;
  TextEditingController phoneNumberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                    margin: EdgeInsets.fromLTRB(isTablet ? screenSize.width * 0.08 : 0, 0, 0, 0),

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
                            SizedBox(height: screenSize.height * 0.01),
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
                          color: Colors.red[200],
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

                        child: Form(
                          key: _formKey,
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

                                    child: Text('Enter your mobile number to activate your account.',
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
                              SizedBox(height: screenSize.height * 0.1),
                              Center(
                                child: Container(
                                  width: isTablet ? screenSize.width * 0.8 : screenSize.width * 0.8,
                                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        'images/malaysia_logo.png',
                                        width: isTablet ? 80 : 40,
                                        height: isTablet ? 80 : 40,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(width: screenSize.width * 0.02),
                                      Text(
                                        '+60',
                                        style: TextStyle(
                                          fontSize: isTablet ? 30 : 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      SizedBox(width: screenSize.width * 0.05),
                                      Expanded(
                                        child: TextFormField(
                                          controller: phoneNumberController,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.digitsOnly,
                                          ],
                                          keyboardType: TextInputType.phone,
                                          decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                            border: OutlineInputBorder(),
                                            fillColor: Colors.white,
                                            filled: true,
                                            isDense: true,
                                          ),
                                          style: TextStyle(
                                            fontSize: isTablet ? 26 : 16,
                                          ),
                                          validator: (value) {
                                            if (value == null || value.isEmpty || (value.length != 9 && value.length != 10)) {
                                              return 'Please enter a valid phone number.';
                                            }
                                            return null;
                                          },
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
                                  Checkbox(
                                    value: isChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        if (value != null) {
                                          isChecked = value;
                                        }
                                      });
                                    },
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isChecked = !isChecked;
                                      });
                                    },
                                    child: Text(
                                      'I agree to the terms & conditions',
                                      style: TextStyle(fontSize: isTablet ? 26 : 16),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: screenSize.height * 0.01),
                              Center(
                                child: Container(
                                  width: isTablet ? screenSize.width * 0.3 : screenSize.width * 0.6,
                                  height: isTablet ? screenSize.height * 0.1 : screenSize.height * 0.05,
                                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: ElevatedButton(
                                    onPressed: isChecked && _formKey.currentState?.validate() == true ? () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const ActivationScreen()),
                                      );
                                    }
                                        : null,
                                    child: Text('Get Activation Code',
                                      style: TextStyle(
                                        fontSize: isTablet ? 28 : 18,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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