import 'package:carro_weddings_ag/models/venue_model.dart';
import 'package:carro_weddings_ag/screens/venue_screen.dart';
import 'package:carro_weddings_ag/theme.dart';
import 'package:flutter/material.dart';

class VenueCarousel extends StatefulWidget {
  final PageController pageController; 

  const VenueCarousel({super.key, required this.pageController});

  @override
  State<VenueCarousel> createState() => _VenueCarouselState();
}

class _VenueCarouselState extends State<VenueCarousel> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380.0,
      child: PageView.builder(
        physics: const BouncingScrollPhysics(),
        controller: widget.pageController, 
        itemCount: venuesList.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildPost(context, index);
        },
      ),
    );
  }

  Widget _buildPost(BuildContext context, int index) {
    Venue venue = venuesList[index];

    return AnimatedBuilder(
      animation: widget.pageController,
      builder: (BuildContext context, Widget? w) {
        double value = 1;
        if (widget.pageController.position.haveDimensions) {
          value = (widget.pageController.page ?? 0.0) - index;
          value = (1 - (value.abs() * 0.35)).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 400.0,
            child: w ?? Container(),
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => VenueScreen(venue: venue)),
          );
        },
        child: Stack(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
                  venue.image,
                  height: 400.0,
                  width: 300.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            Positioned(
              bottom: 30.0,
              left: 30.0,
              right: 30.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    venue.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: 40.0,
                        width: 40.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: kAccentColor,
                        ),
                        child: IconButton(
                          icon: Icon(
                            venue.isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: Colors.white,
                            size: 22.0,
                          ),
                          onPressed: () {
                            setState(() {
                              venue.isFavorite = !venue.isFavorite;
                            });
                          },
                        ),
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
  }
}
