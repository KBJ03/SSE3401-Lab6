import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InvitationPage extends StatefulWidget {
  const InvitationPage({super.key});

  @override
  State<InvitationPage> createState() => _InvitationPageState();
}

class _InvitationPageState extends State<InvitationPage> {

  String appBarTitle = 'Factory 1';

  late TextEditingController nameController;
  late TextEditingController phoneController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    bool isTablet = screenSize.width > 600;

    String ownerName = nameController.text;
    String ownerPhoneNumber = phoneController.text;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: Text(appBarTitle,
            style: TextStyle(
                fontSize: isTablet ? 34 : 24,
                fontWeight: FontWeight.w800
            )
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.red[100],

            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Invitation',
                              style: TextStyle(
                                fontSize: isTablet ? 40 : 30,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Invite users',
                              style: TextStyle(
                                fontSize: isTablet ? 30 : 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            SizedBox(height: screenSize.height * 0.01),
                          ]
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: isTablet ? screenSize.height * 0.2 : screenSize.height * 0.15,
                            width: isTablet ? screenSize.width * 0.85 : screenSize.width * 0.8,
                            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),

                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Owner\'s Name',
                                    style: TextStyle(
                                      fontSize: isTablet ? 30 : 20,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  TextFormField(
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                      hintText: 'Type here',
                                      hintStyle: TextStyle(fontSize: isTablet ? 20 : 16),
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                    style: TextStyle(fontSize: isTablet ? 24 : 18),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a name';
                                      }
                                      return null;
                                    },
                                  ),
                                ]
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.01),
                          Container(
                            height: isTablet ? screenSize.height * 0.2 : screenSize.height * 0.15,
                            width: isTablet ? screenSize.width * 0.85 : screenSize.width * 0.8,
                            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),

                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Owner\'s Phone Number',
                                    style: TextStyle(
                                      fontSize: isTablet ? 30 : 20,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'images/malaysia_logo.png',
                                        width: isTablet ? 50 :40,
                                        height: isTablet ? 50 :40,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(width: screenSize.width * 0.02),
                                      Text(
                                        '+60',
                                        style: TextStyle(
                                          fontSize: isTablet ? 24 : 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      SizedBox(width: screenSize.width * 0.02),
                                      Expanded(
                                        child: TextFormField(
                                          controller: phoneController,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.digitsOnly,
                                          ],
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(
                                            hintText: 'Enter your phone number',
                                            hintStyle: TextStyle(fontSize: isTablet ? 20 : 16),
                                            fillColor: Colors.white,
                                            filled: true,
                                          ),
                                          style: TextStyle(fontSize: isTablet ? 24 : 18),
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
                                ]
                            ),
                          ),
                          Container(
                            height: isTablet ? screenSize.height * 0.1 : screenSize.height * 0.05,
                            width: isTablet ? screenSize.width * 0.85 : screenSize.width * 0.8,
                            margin: const EdgeInsets.all(10),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ?? false) {
                                  String ownerName = nameController.text;
                                  String ownerPhoneNumber = phoneController.text;
                                  String phoneNumber = '+60$ownerPhoneNumber';

                                  Contact newContact = Contact(name: ownerName, phoneNumber: phoneNumber);

                                  Navigator.pop(context, newContact);
                                }
                              },
                              child: Text('Submit',
                                style: TextStyle(
                                  fontSize: isTablet ? 28 : 18,
                                  fontWeight: FontWeight.normal,
                                ),)
                              ,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Contact {
  final String name;
  final String phoneNumber;

  Contact({required this.name, required this.phoneNumber});
}