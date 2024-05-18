import 'package:flutter/material.dart';
import 'package:lab5/user.dart';
import 'package:flutter/services.dart';
import 'package:lab5/home.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int currentIndex = 2;

  late List<FactoryCard> factoryCardList;

  String appBarTitle = 'Factory 1';

  FactoryCard? selectedFactoryCard;

  List<GridItem> gridItems = [
    GridItem(title: 'Steam Pressure', value: 0, unit: 'bar'),
    GridItem(title: 'Steam Flow', value: 0, unit: 'T/H'),
    GridItem(title: 'Water Level', value: 0, unit: '%'),
    GridItem(title: 'Power Frequency', value: 0, unit: 'Hz'),
  ];

  @override
  void initState() {
    super.initState();

    factoryCardList = [
      FactoryCard(title: 'Factory 1', isActive: true, onSelect: (isSelected) {}),
      FactoryCard(title: 'Factory 2', isActive: false, onSelect: (isSelected) {}),
      FactoryCard(title: 'Factory 3', isActive: false, onSelect: (isSelected) {}),
    ];

    selectedFactoryCard = factoryCardList[1];
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
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.settings,
                size: isTablet ? 40 : 30,
              ),
              onPressed: () {},
            ),
          ]
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SizedBox(height: screenSize.height * 0.02),
                          Container(
                            margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text("Minimum Threshold",
                                        style: TextStyle(
                                            fontSize: isTablet ? 30 : 20,
                                            fontWeight: FontWeight.w800
                                        )
                                    ),
                                    SizedBox(width: screenSize.width * 0.01),
                                    GestureDetector(
                                      onTap: () {},
                                      child: const Icon(Icons.error_outline),
                                    ),
                                  ],
                                ),
                                SizedBox(width: screenSize.width * 0.05),
                                ElevatedButton(
                                  onPressed: () {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(height: screenSize.height * 0.01),
                                      Icon(
                                          Icons.create,
                                          size: isTablet ? 40 : 30),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.01),
                          SizedBox(
                            height: isTablet ? screenSize.height * 0.425 : screenSize.height * 0.5,
                            width: isTablet ? screenSize.width * 0.85 : screenSize.width * 0.8,

                            child: GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: isTablet ? 4 : 2,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                                childAspectRatio: 1.2,
                              ),
                              itemCount: gridItems.length,
                              itemBuilder: (context, index) {
                                return GridItemWidget(item: gridItems[index]);
                              },
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
                    )
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
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UserPage()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
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

class GridItem {
  final String title;
  double value;
  final String unit;

  GridItem({
    required this.title,
    required this.value,
    required this.unit,
  });
}

class GridItemWidget extends StatelessWidget {
  final GridItem item;

  const GridItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    bool isTablet = screenSize.width > 600;

    return GridTile(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(item.title,
            style: TextStyle(
                fontSize: isTablet ? 22 : 18,
                fontWeight: FontWeight.bold
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: SizedBox(
                    width: isTablet ? screenSize.width * 0.8 : screenSize.width * 0.5,

                    child: TextField(
                      onChanged: (value) {},
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: isTablet ? 20 : 14,
                          fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        hintText: '0.0',
                        hintStyle: TextStyle(
                          fontSize: isTablet ? 20 : 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            bottomLeft: Radius.circular(5.0),
                          ),
                          borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.0
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      ),
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$')),
                      ],
                      keyboardType: const TextInputType.numberWithOptions(decimal: false),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black,
                        width: 1.0
                    ),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(5.0),
                      bottomRight: Radius.circular(5.0),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                  child: Text(
                    item.unit,
                    style: TextStyle(
                        fontSize: isTablet ? 16 : 14,
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
