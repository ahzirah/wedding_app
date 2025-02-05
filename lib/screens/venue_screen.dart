
import 'package:carro_weddings_ag/models/venue_model.dart';
import 'package:flutter/material.dart';




class VenueScreen extends StatelessWidget {
  const VenueScreen({super.key, required Venue venue,});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Venue Screen', style: TextStyle(color: Colors.white),),
        
      ),
      body: const Center(
        child: Text('Welcome to the Venue Screen!', style: TextStyle(fontSize: 35, color: Colors.black),),
      ),
    );
  }
}