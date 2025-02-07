import 'package:carro_weddings_ag/models/popular_list.dart';
import 'package:carro_weddings_ag/models/venue_carousel.dart';
import 'package:carro_weddings_ag/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// HomeScreen widget
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.8); 

  int _currentTab = 0;
  String userName = "Guest"; // Default name

  @override
  void initState() {
    super.initState();
    _loadUserName(); // Fetch saved user name
  }

  Future<void> _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? "Guest"; // Fetch user name or default
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30.0,
        unselectedItemColor: Colors.grey[350],
        selectedItemColor: kAccentColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentTab,
        onTap: (int value) {
          setState(() {
            _currentTab = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home", 
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favourites",
          ),
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20.0, top: 10.0),
            child: Text(
              "Hi, $userName",
              style: TextStyle(
                color: kAccentColor,
                fontSize: 20.0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, top: 4.0, bottom: 10.0),
            child: Text(
              "Browse a list of Venues",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          Padding(
            padding: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 20.0),
            child: Text(
              "Our Venues",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          VenueCarousel(pageController: _pageController), 
          SizedBox(height: 20.0),
          Container(
            padding: EdgeInsets.only(left: 20.0, top: 25.0, right: 20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              color: kAccentColor,
             // color: Colors.yellow[200],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Most Popular",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                PopularList(), // List of popular venues
              ],
            ),
          ),
        ],
      ),
    );
  }
}
