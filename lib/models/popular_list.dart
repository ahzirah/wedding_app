import 'package:carro_weddings_ag/models/venue_model.dart';
import 'package:carro_weddings_ag/screens/venue_screen.dart';
import 'package:flutter/material.dart';

class PopularList extends StatefulWidget {
  const PopularList({super.key});

  @override
  State<PopularList> createState() => _PopularListState();
}

class _PopularListState extends State<PopularList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: popularList.length,
      itemBuilder: (BuildContext context, int index) {
        Venue venue = popularList[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => VenueScreen(venue: venue)),
            );
          },
          child: Container(
            height: 120.0,
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 20.0),
            padding: EdgeInsets.fromLTRB(7.0, 7.0, 20.0, 7.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    venue.image,
                    height: 110.0,
                    width: 100.0,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
                SizedBox(width: 20.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        venue.title,
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        children: [
                          IconButton(
                            icon: venue.isFavorite
                                ? Icon(Icons.favorite, color: Colors.red)
                                : Icon(Icons.favorite_border, color: Colors.grey),
                            onPressed: () {
                              setState(() {
                                venue.isFavorite = !venue.isFavorite;
                              });
                            },
                          ),
                         
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
