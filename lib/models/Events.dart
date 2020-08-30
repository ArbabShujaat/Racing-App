
class Events {
  final List<dynamic> imageUrls;
  final String title, description, date;
  final id;

  Events({
    this.id,
    this.imageUrls,
    this.title,
    this.date,
    this.description,
  });
}

List<Events> events = [
  Events(
    id: 1,
    title: "Suzuki",
    description: dummyText,
    date: "21 Sep 2020",
    imageUrls: ["assets/event.jpg", "assets/event.jpg", "assets/event.jpg"],
  ),
  Events(
    id: 2,
    title: "Mehran",
    description: dummyText,
    date: "21 Sep 2020",
    imageUrls: ["assets/event.jpg", "assets/car.jpg", "assets/car.jpg"],
  ),
  Events(
    id: 3,
    title: "Suzki",
    description: dummyText,
    date: "21 Sep 2020",
    imageUrls: ["assets/event.jpg", "assets/car.jpg", "assets/car.jpg"],
  ),
  Events(
    id: 4,
    title: "Corrola",
    description: dummyText,
    date: "21 Sep 2020",
    imageUrls: ["assets/event.jpg", "assets/car.jpg", "assets/car.jpg"],
  ),
];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
