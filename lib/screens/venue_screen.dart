import 'package:carro_weddings_ag/models/venue_model.dart';
import 'package:carro_weddings_ag/screens/home_screen.dart';
import 'package:carro_weddings_ag/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class VenueScreen extends StatefulWidget {
  final Venue venue;

  const VenueScreen({super.key, required this.venue});

  @override
    State<VenueScreen> createState() => _VenueScreenState();
}

class _VenueScreenState extends State<VenueScreen> {
  int _currentSelect = -1;
  bool isSelected = false;
  late String firstHalf;
  late String secondHalf;
  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.venue.description.length > 150) {
      firstHalf = widget.venue.description.substring(0, 150);
      secondHalf = widget.venue.description.substring(150);
    } else {
      firstHalf = widget.venue.description;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Venue Image
          SizedBox(
            height: 600.0,
            width: double.infinity,
            child: ClipRRect(
              child: Image.asset(
                widget.venue.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Dark Gradient Overlay
          // Container(
          //   height: 600.0,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(15.0),
          //     gradient: const LinearGradient(
          //       colors: [
          //         Colors.black,
          //         Colors.black87,
          //         Colors.black54,
          //         Colors.black38,
          //       ],
          //       stops: [0.1, 0.4, 0.6, 0.9],
          //     ),
          //   ),
          // ),
          // Back and Cart Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.home_filled),
                  color: Colors.white,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          // Venue Details Container
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: <Widget>[
                Text(
                  widget.venue.title,
                  style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10.0),
                // Favorite Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: 55.0,
                      width: 55.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5.0),
                        color: kAccentColor,
                      ),
                      child: IconButton(
                        icon: Icon(
                          widget.venue.isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.white,
                          size: 24.0,
                        ),
                        onPressed: () {
                          setState(() {
                            widget.venue.isFavorite = !widget.venue.isFavorite;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20.0),
                const Text(
                  "Venue Detail",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20.0),
                // Venue Description with Read More Toggle
                Container(
                  child: secondHalf.isEmpty
                      ? Text(widget.venue.description)
                      : RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            text: flag ? "$firstHalf..." : "$firstHalf$secondHalf",
                            style: const TextStyle(color: kSecondaryColor, fontSize: 15.0),
                            children: <TextSpan>[
                              TextSpan(
                                text: flag ? " Read More" : " Read Less",
                                style: const TextStyle(
                                  color: kAccentColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()..onTap = () {
                                  setState(() {
                                    flag = !flag;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  "Capacity",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 30.0),
                // Size Selection Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    _sizeChoice("100", 0),
                    _divider(),
                    _sizeChoice("300", 1),
                    _divider(),
                    _sizeChoice("400", 2),
                    _divider(),
                    _sizeChoice("600", 3),
                  ],
                ),
                const SizedBox(height: 30.0),
                // Contact & Appointment Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _circleButton(Icons.phone),
                    _appointmentButton(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sizeChoice(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected && _currentSelect == index) {
            _currentSelect = -1;
            isSelected = false;
          } else {
            _currentSelect = index;
            isSelected = true;
          }
        });
      },
      child: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          shape: BoxShape.rectangle,
          color: _currentSelect == index ? kAccentColor : kSizingButtonColor,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              color: _currentSelect == index ? Colors.white : kSecondaryColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      width: 40.0,
      height: 6.0,
      color: kSizingButtonColor,
    );
  }

  Widget _circleButton(IconData icon) {
    return Container(
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(7.0),
        border: Border.all(color: kSecondaryColor),
      ),
      child: Icon(icon, color: kSecondaryColor),
    );
  }

  Widget _appointmentButton() {
    return Container(
      width: 240.0,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: kAccentColor,
      ),
      child: const Center(
        child: Text(
          "Make an Appointment",
          style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
