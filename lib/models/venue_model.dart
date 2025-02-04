
class Venue {
  final String title;
  final String image;
  final String description;
  final int price;
  bool isFavorite;

  Venue({
    required this.title,
    required this.image,
    required this.description,
    required this.price,
    this.isFavorite = false, // Default value to avoid null
  });
}

List<Venue> venuesList = [
  Venue(
    title: "The Croft",
    image: "assets/images/the_croft/021224 Katy and James The Croft Hotel Photos CARRO-3.jpg",
    price: 400,
    description: "This is stunning venue with modern decor and beautiful views.."
  ),
  Venue(
    title: "As You Like It",
    image: "assets/images/the_croft/021224 Katy and James The Croft Hotel Photos CARRO-3.jpg",
    price: 400,
    description: "A luxurious venue with spacious ballrooms and classic ambiance."
  ),
  Venue(
    title: "Grand Villa Heights",
    image: "assets/images/the_croft/021224 Katy and James The Croft Hotel Photos CARRO-3.jpg",
    price: 400,
    description: "A Magnificent castle venue for a royal wedding experience."
  ),
  Venue(
    title: "Lartington Hall",
    image: "assets/images/the_croft/021224 Katy and James The Croft Hotel Photos CARRO-3.jpg",
    price: 400,
    description: "This is a beautiful venue."
  ),
  Venue(
    title: "Le Petit Chateau",
    image: "assets/images/the_croft/021224 Katy and James The Croft Hotel Photos CARRO-3.jpg",
    price: 400,
    description: "This is a beautiful venue."
  ),
  Venue(
    title: "Newton Hall",
    image: "assets/images/the_croft/021224 Katy and James The Croft Hotel Photos CARRO-3.jpg",
    price: 400,
    description: "This is a beautiful venue."
  ),
  Venue(
    title: "Runa Farm",
    image: "assets/images/the_croft/021224 Katy and James The Croft Hotel Photos CARRO-3.jpg",
    price: 400,
    description: "This is a beautiful venue."
  ),
];

List<Venue> popularList = venuesList.take(3).toList(); // Picks the first 3 venues
