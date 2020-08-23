import 'package:flutter/material.dart';
class Productc {
  final String image,
      title,
      description,
      price,
      id,
      sellerEmail,
      sellerPhoneNumber,
      sellerUserUid,
      productCategory,
      sellerName;

  Productc({
    this.productCategory,
    this.id,
    this.image,
    this.title,
    this.price,
    this.description,
    this.sellerEmail,
    this.sellerPhoneNumber,
    this.sellerUserUid,
    this.sellerName
  });
}
class Product {
  final String image, title, description;
  final int price, id;

  Product({
    this.id,
    this.image,
    this.title,
    this.price,
    this.description,
  });
}

List<Product> car = [
  Product(
    id: 1,
    title: "Suzuki",
    price: 234,
    description: dummyText,
    image: "assets/car.jpg",
  ),
  Product(
    id: 2,
    title: "Mehran",
    price: 234,
    description: dummyText,
    image: "assets/car.jpg",
  ),
  Product(
    id: 3,
    title: "Suzki",
    price: 234,
    description: dummyText,
    image: "assets/car.jpg",
  ),
  Product(
    id: 4,
    title: "Corrola",
    price: 234,
    description: dummyText,
    image: "assets/car.jpg",
  ),
];
List<Product> sportsCars = [
  Product(
    id: 1,
    title: "Honda",
    price: 238,
    description: dummyText,
    image: "assets/car.jpg",
  ),
  Product(
    id: 2,
    title: "BMW",
    price: 904,
    description: dummyText,
    image: "assets/car.jpg",
  ),
  Product(
    id: 4,
    title: "Corrola",
    price: 234,
    description: dummyText,
    image: "assets/car.jpg",
  ),
];
List<Product> autoParts = [
  Product(
    id: 1,
    title: "parts",
    price: 234,
    description: dummyText,
    image: "assets/car.jpg",
  ),
  Product(
    id: 2,
    title: "Parts",
    price: 234,
    description: dummyText,
    image: "assets/car.jpg",
  ),
];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
