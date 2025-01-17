import 'package:flutter/material.dart';
import 'package:love_bird/grids/user_model.dart';

class PeopleNearbyGrid extends StatelessWidget {
  final List<User> users = [
    User(
        imageUrl: 'assets/images/homeImage.png',
        name: 'David',
        age: 31,
        isOnline: true),
    User(
        imageUrl: 'assets/images/homeImage.png',
        name: 'James',
        age: 29,
        isOnline: false),
    User(
        imageUrl: 'assets/images/homeImage.png',
        name: 'Tom',
        age: 32,
        isOnline: true),
    User(
        imageUrl: 'assets/images/homeImage.png',
        name: 'Michael',
        age: 30,
        isOnline: false),
    User(
        imageUrl: 'assets/images/homeImage.png',
        name: 'Michael',
        age: 30,
        isOnline: true),
    User(
        imageUrl: 'assets/images/homeImage.png',
        name: 'Michael',
        age: 30,
        isOnline: false),
    User(
        imageUrl: 'assets/images/homeImage.png',
        name: 'Michael',
        age: 30,
        isOnline: true),
    User(
        imageUrl: 'assets/images/homeImage.png',
        name: 'Michael',
        age: 30,
        isOnline: false),
    User(
        imageUrl: 'assets/images/homeImage.png',
        name: 'Michael',
        age: 30,
        isOnline: true),
  ];

  PeopleNearbyGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 9.0,
        mainAxisSpacing: 14.0,
        childAspectRatio: 0.7,
      ),
      itemCount: users.length,
      itemBuilder: (context, index) {
        return UserCard(user: users[index]);
      },
    );
  }
}
