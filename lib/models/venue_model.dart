
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
    price: 2400,
    description: "This is stunning venue with modern decor and beautiful views.."
  ),
  Venue(
    title: "As You Like It",
    image: "assets/images/as_you_like_it/060624 Emma and Peter Wedding As You Like Photos CARRO-724.jpg",
    price: 1300,
    description: "A luxurious venue with spacious ballrooms and classic ambiance."
  ),
  Venue(
    title: "Grand Villa Heights",
    image: "assets/images/grand_villa_heights/9.jpg",
    price: 6000,
    description: "A Magnificent castle venue for a royal wedding experience."
  ),
  Venue(
    title: "Lartington Hall",
    image: "assets/images/lartington_hall/439255094_972954258167539_8037834473941986353_n.jpg",
    price: 1800,
    description: "This is a beautiful venue."
  ),
  Venue(
    title: "Le Petit Chateau",
    image: "assets/images/le_petit _chateau/280424 Amy and Georgia Le Petit Wedding Photos CARRO-15.jpg",
    price: 3000,
    description: "This is a beautiful venue."
  ),
  Venue(
    title: "Newton Hall",
    image: "assets/images/newton_hall/181123 Julie and Adam Newton Hall wedding Photos CARRO-68.jpg",
    price: 5700,
    description: "This is a beautiful venue."
  ),
  Venue(
    title: "Runa Farm",
    image: "assets/images/runa_farm/419303765_939730071489958_591781465014245620_n.jpg",
    price: 2300,
    description: "This is a beautiful venue."
  ),
];

List<Venue> popularList = venuesList.take(3).toList(); // Picks the first 3 venues
