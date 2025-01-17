import 'package:flutter/material.dart';

class PlanCard extends StatelessWidget {
  final double price;
  final String duration;
  final String description;
  final Color borderColor;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback? onTap;

  const PlanCard({
    super.key,
    required this.price,
    required this.duration,
    required this.description,
    this.borderColor = Colors.blue,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Main container
          Container(
            width: 135,
            height: 130,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: borderColor,
                width: 3,
              ),
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '\$$price',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: borderColor.withOpacity(0.8),
                        fontSize: 9,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Smaller container on top border
          Positioned(
            top: -15, // Position it above the main container
            left: 25, // Adjust left position if needed
            child: Container(
              width: 90,
              height: 30,
              decoration: BoxDecoration(
                color: borderColor,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: borderColor,
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  duration,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
