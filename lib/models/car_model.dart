class Car {
  final String id;
  final String brand;
  final String vehicles;
  final String year;
  final String price;
  final String imageUrl;

  const Car({
    this.id = "",
    required this.brand,
    required this.vehicles,
    required this.year,
    required this.price,
    this.imageUrl =
        "https://portallubes.com.br/wp-content/uploads/2019/01/corolla_xei_2019.jpg",
  });
}
