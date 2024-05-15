import 'package:flutter/material.dart';
import 'package:lab5/setting.dart';
import 'package:lab5/home.dart';
import 'package:lab5/new_user.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  int currentIndex = 0;

  late List<FactoryCard> factoryCardList;

  String appBarTitle = 'Factory 1';

  FactoryCard? selectedFactoryCard;

  List<Contact> factory1Contacts = [
    Contact(name: 'Ben', phoneNumber: '+60109219938'),
    Contact(name: 'Testing 1', phoneNumber: '+601234567891'),
    Contact(name: 'Hello', phoneNumber: '+6012456789'),
  ];

  List<Contact> factory2Contacts = [
    Contact(name: 'Contact 1', phoneNumber: '+60987654321'),
    Contact(name: 'Contact 2', phoneNumber: '+60876543210'),
  ];

  void addNewContact(Contact newContact) {
    setState(() {
      if (selectedFactoryCard?.title == 'Factory 1') {
        factory1Contacts.add(newContact);
      } else if (selectedFactoryCard?.title == 'Factory 2') {
        factory2Contacts.add(newContact);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    factoryCardList = [
      FactoryCard(title: 'Factory 1', isActive: true, onSelect: (isSelected) {}),
      FactoryCard(title: 'Factory 2', isActive: false, onSelect: (isSelected) {}),
      FactoryCard(title: 'Factory 3', isActive: false, onSelect: (isSelected) {}),
    ];

    selectedFactoryCard = factoryCardList[0];
  }

  void handleFactoryCardSelection(FactoryCard selectedCard) {
    setState(() {
      for (var card in factoryCardList) {
        card.isActive = card == selectedCard;
      }
      selectedFactoryCard = selectedCard;

      if (selectedCard.title == 'Factory 1') {
        updateAppBarTitle('Factory 1');
      } else if (selectedCard.title == 'Factory 2') {
        updateAppBarTitle('Factory 2');
      }
    });
  }

  void updateAppBarTitle(String title) {
    setState(() {
      appBarTitle = title;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    bool isTablet = screenSize.width > 600;

    List<Contact> currentContacts = selectedFactoryCard?.title == 'Factory 1' ? factory1Contacts : factory2Contacts;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: Text(appBarTitle,
            style: TextStyle(
                fontSize: isTablet ? 34 : 24,
                fontWeight: FontWeight.w800
            )
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: <Widget> [
          IconButton(
            icon: Icon(
              Icons.settings,
              size: isTablet ? 40 : 30,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.red[100],
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenSize.height * 0.02),
                Container(
                  height: isTablet ? screenSize.height * 0.6 : screenSize.height * 0.625,
                  width: isTablet ? screenSize.width * 0.9 : screenSize.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: screenSize.height * 0.02),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            itemCount: currentContacts.length,
                            separatorBuilder: (BuildContext context, int index) {
                              return SizedBox(height: screenSize.height * 0.02);
                            },
                            itemBuilder: (context, index) {
                              return ContactCard(
                                name: currentContacts[index].name,
                                phoneNumber: currentContacts[index].phoneNumber,
                              );
                            },
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                final newContact = await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const InvitationPage()),
                                );

                                if (newContact != null && newContact is Contact) {
                                  addNewContact(newContact);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                minimumSize: const Size(50, 50),
                              ),
                              child: Icon(
                                  Icons.add,
                                  size: isTablet ? 40 : 30
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  height: isTablet ? screenSize.height * 0.2 : screenSize.height * 0.15,
                  width: isTablet ? screenSize.width * 0.6 : screenSize.width * 0.9,

                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: factoryCardList.length,
                    itemBuilder: (context, index) {
                      return FactoryCard(
                        title: factoryCardList[index].title,
                        isActive: factoryCardList[index] == selectedFactoryCard,
                        onSelect: (bool isSelected) {
                          if (isSelected) {
                            handleFactoryCardSelection(factoryCardList[index]);
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            label: 'User',
            icon: Icon(Icons.person),
          ),
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Setting',
            icon: Icon(Icons.settings),
          )
        ],
        currentIndex: currentIndex,
        onTap: (int index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsPage()),
            );
          } else {
            setState(() {
              currentIndex = index;
            });
          }
        },
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final String name;
  final String phoneNumber;

  const ContactCard({
    Key? key,
    required this.name,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    bool isTablet = screenSize.width > 600;

    return Card(
      elevation: 3,
      child: ListTile(
        leading: const Icon(Icons.account_circle),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenSize.height * 0.02),
            Text(
              name,
              style: TextStyle(
                fontSize: isTablet ? 24 : 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        subtitle: Text(
          phoneNumber,
          style: TextStyle(
            fontSize: isTablet ? 20 : 14,
            color: Colors.grey,
          ),
        ),
        onTap: () {},
      ),
    );
  }
}

class FactoryCard extends StatefulWidget {
  final String title;
  late bool isActive;
  final ValueChanged<bool> onSelect;

  FactoryCard({
    Key? key,
    required this.title,
    this.isActive = false,
    required this.onSelect,
  }) : super(key: key);

  @override
  _FactoryCardState createState() => _FactoryCardState();
}

class _FactoryCardState extends State<FactoryCard> {
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _isActive = widget.isActive;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    bool isTablet = screenSize.width > 600;

    return GestureDetector(
      onTap: () {
        if (!widget.isActive) {
          widget.onSelect(true);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          margin: const EdgeInsets.all(5),
          elevation: 3,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: widget.isActive ? Colors.blue : Colors.transparent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SizedBox(
            height: isTablet ? screenSize.height * 0.05 : screenSize.height * 0.1,
            width: isTablet ? screenSize.width * 0.2 : screenSize.width * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.factory,
                  size: isTablet ? 50 : 30,
                ),
                SizedBox(height: screenSize.height * 0.01),
                Text(
                  widget.title,
                  style: TextStyle(
                      fontSize: isTablet ? 30 : 20,
                      fontWeight: FontWeight.normal
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}