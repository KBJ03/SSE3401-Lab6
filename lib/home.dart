import 'package:flutter/material.dart';
import 'package:lab5/setting.dart';
import 'package:lab5/user.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 1;

  String appBarTitle = 'Factory 2';

  late List<CardData> cardDataList;
  late List<CardData> factory1Data;
  late List<CardData> factory2Data;
  late List<FactoryCard> factoryCardList;
  FactoryCard? selectedFactoryCard;

  @override
  void initState() {
    super.initState();

    factory1Data = [
      CardData(
        title: 'Steam Pressure',
        gaugeValue:0.0,
        value: '0.0bar',
        markValue: 29,
      ),
      CardData(
        title: 'Steam Flow',
        gaugeValue: 0.0,
        value: '0.0T/H',
        markValue: 22,
      ),
      CardData(
        title: 'Water Level',
        gaugeValue: 0.0,
        value: '0.0%',
        markValue: 53,
      ),
      CardData(
        title: 'Power Frequency',
        gaugeValue: 0.0,
        value: '0.0Hz',
        markValue: 48,
      ),
    ];

    factory2Data = [
      CardData(
        title: 'Steam Pressure',
        gaugeValue: 34.19,
        value: '34.19bar',
        markValue: 29,
      ),
      CardData(
        title: 'Steam Flow',
        gaugeValue: 22.82,
        value: '22.82T/H',
        markValue: 28,
      ),
      CardData(
        title: 'Water Level',
        gaugeValue: 55.41,
        value: '55.41%',
        markValue: 53,
      ),
      CardData(
        title: 'Power Frequency',
        gaugeValue: 50.08,
        value: '50.08Hz',
        markValue: 48,
      ),
    ];

    cardDataList = factory2Data;

    factoryCardList = [
      FactoryCard(title: 'Factory 1', isActive: false, onSelect: (isSelected) {}),
      FactoryCard(title: 'Factory 2', isActive: true, onSelect: (isSelected) {}),
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
        cardDataList = factory1Data;
        updateAppBarTitle('Factory 1');
      } else if (selectedCard.title == 'Factory 2') {
        cardDataList = factory2Data;
        updateAppBarTitle('Factory 2');
      }
    });
  }

  void updateAppBarTitle(String title) {
    setState(() {
      appBarTitle = title;
    });
  }


  String getCurrentDateTime() {
    DateTime now = DateTime.now();
    return '${now.year}-${_addLeadingZero(now.month)}-${_addLeadingZero(now.day)} ${_addLeadingZero(now.hour)}:${_addLeadingZero(now.minute)}:${_addLeadingZero(now.second)}';
  }

  String _addLeadingZero(int value) {
    return value < 10 ? '0$value' : value.toString();
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
                      SizedBox(height: screenSize.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          selectedFactoryCard?.title == 'Factory 1'
                              ? const Icon(
                            Icons.warning_outlined,
                            color: Colors.yellow,
                          )
                              : const SizedBox.shrink(),
                          Text(
                            selectedFactoryCard?.title == 'Factory 1' ? 'ABD1234 IS UNREACHABLE!' : '1549.7kW',
                            style: TextStyle(
                              fontSize: isTablet ? 30 : 22,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenSize.height * 0.01),
                      SizedBox(
                        height: isTablet ? screenSize.height * 0.425 : screenSize.height * 0.5,
                        width: isTablet ? screenSize.width * 0.85 : screenSize.width * 0.8,
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: isTablet ? 4 : 2,
                            mainAxisSpacing: 5.0,
                            crossAxisSpacing: 5.0,
                            childAspectRatio: 0.85,
                          ),
                          itemCount: cardDataList.length,
                          itemBuilder: (context, index) {
                            return CardWidget(
                                title: cardDataList[index].title,
                                gaugeValue: cardDataList[index].gaugeValue,
                                value: cardDataList[index].value,
                                markValue: cardDataList[index].markValue
                            );
                          },
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.005),
                      Text(
                        selectedFactoryCard?.title == 'Factory 1'
                            ? '--:--'
                            : getCurrentDateTime(),
                        style: TextStyle(
                          fontSize: isTablet ? 20 : 14,
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                    ],
                  ),
                ),
                Container(
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    height: isTablet ? screenSize.height * 0.2 : screenSize.height * 0.15,
                    width: isTablet ? screenSize.width * 0.6 : screenSize.width * 0.9,

                    child: Center(
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

class CardData {
  final String title;
  final double gaugeValue; // Add gauge value here instead of imagePath
  final String value;
  final double markValue;

  CardData({
    required this.title,
    required this.gaugeValue, // Modify the constructor to accept gaugeValue
    required this.value,
    required this.markValue,
  });
}

class CardWidget extends StatelessWidget {
  final String title;
  final double gaugeValue;
  final String value;
  final double markValue;

  const CardWidget({
    required this.title,
    required this.gaugeValue,
    required this.value,
    required this.markValue,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    bool isTablet = screenSize.width > 600;

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: isTablet ? 26 : 16
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: isTablet ? screenSize.height * 0.08 : screenSize.height * 0.07,
              width: isTablet ? screenSize.width * 0.8 : screenSize.width * 0.5,
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    startAngle: 180,
                    endAngle: 0,
                    canScaleToFit: true,
                    minimum: 0,
                    maximum: 100,
                    interval: 25,
                    minorTicksPerInterval: 0,
                    showLabels: false,
                    showTicks: true,
                    radiusFactor: 1.5,
                    axisLineStyle: const AxisLineStyle(
                      thickness: 15,
                      cornerStyle: CornerStyle.bothFlat,
                      color: Colors.grey,
                    ),
                    pointers: <GaugePointer>[
                      RangePointer(
                        value: gaugeValue,
                        width: 15,
                        sizeUnit: GaugeSizeUnit.logicalPixel,
                        color: gaugeValue < 25 ? Colors.red : Colors.green,
                      ),
                      MarkerPointer(
                        value: markValue,
                        markerType: MarkerType.invertedTriangle,
                        color: Colors.grey,
                        markerWidth: 10,
                        markerHeight: 10,
                        markerOffset: -10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: TextStyle(
                fontSize: isTablet ? 30 : 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
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
    required this.isActive,
    required this.onSelect,
  }) : super(key: key);

  @override
  _FactoryCardState createState() => _FactoryCardState();
}

class _FactoryCardState extends State<FactoryCard> {

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