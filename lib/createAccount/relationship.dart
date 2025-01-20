import 'package:flutter/material.dart';

import 'package:love_bird/providers/auth_provider.dart';
import 'package:love_bird/providers/relationship_goal_provider.dart';
import 'package:provider/provider.dart';
import 'package:love_bird/config/constants.dart';

class RelationshipGoalsScreen extends StatelessWidget {
  const RelationshipGoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final goalProvider = Provider.of<GoalProvider>(context);

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                    vertical: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.02,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                color: blue.withOpacity(0.19),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                color: blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            const Text(
                              'Your Relationship Goals',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03,
                            ),
                            Image.asset(
                              'assets/images/icons/love.png',
                              height: 50,
                              width: 30,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Choose the type of relationship you are seeking on Zenkonect. Love, friendship, or something in between. It’s your choice.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 20),
                      RelationshipOption(
                        label: "Dating",
                        description:
                            "Seeking love and meaningful connections? Choose dating for genuine relationships",
                        image: 'assets/images/icons/couple.png',
                        selected: goalProvider.selectedGoal == 'DATING',
                        onTap: () {
                          goalProvider.setGoal('DATING');
                        },
                      ),
                      const SizedBox(height: 20),
                      RelationshipOption(
                        label: "Friendship",
                        description:
                            "Expand your social circle and make new friends. Opt for friendship today.",
                        image: 'assets/images/icons/friend.png',
                        selected: goalProvider.selectedGoal == 'FRIENDSHIP',
                        onTap: () {
                          goalProvider.setGoal('FRIENDSHIP');
                        },
                      ),
                      const SizedBox(height: 20),
                      RelationshipOption(
                        label: "Casual",
                        description:
                            "Looking for fun and relaxed encounters? Select casual for carefree connections.",
                        image: 'assets/images/icons/casual.png',
                        selected: goalProvider.selectedGoal == 'CASUAL',
                        onTap: () {
                          goalProvider.setGoal('CASUAL');
                        },
                      ),
                      const SizedBox(height: 20),
                      RelationshipOption(
                        label: "Serious Relationship",
                        description:
                            "Ready for a commitment and a lasting partnership? Pick serious relationship.",
                        image: 'assets/images/icons/couple.png',
                        selected:
                            goalProvider.selectedGoal == 'SERIOUS_RELATIONSHIP',
                        onTap: () {
                          goalProvider.setGoal('SERIOUS_RELATIONSHIP');
                        },
                      ),
                      const SizedBox(height: 20),
                      RelationshipOption(
                        label: "Networking",
                        description:
                            "Ready to network with fellow professionals",
                        image: 'assets/images/icons/couple.png',
                        selected: goalProvider.selectedGoal == 'OPEN_TO_CHAT',
                        onTap: () {
                          goalProvider.setGoal('OPEN_TO_CHAT');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  if (goalProvider.selectedGoal == null) {
                    // Display SnackBar if no gender is selected
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Please select a relationship goal before proceeding.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } else {
                    // Navigate if gender is selected
                    goalProvider.updateGoal(context, authProvider);
                  }
                },
                // onPressed: () {
                //   // You can access the selectedGoal from goalProvider if needed
                //   Navigator.pushNamed(context, distancePreferenceScreen);
                // },
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Continue',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RelationshipOption extends StatelessWidget {
  final String label;
  final String description;
  final String image;
  final bool selected;
  final VoidCallback onTap;

  const RelationshipOption({
    super.key,
    required this.label,
    required this.description,
    required this.image,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? Colors.blue[100] : Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: blue,
              spreadRadius: 1,
            ),
          ],
          border: Border.all(
            color: selected ? Colors.blue : Colors.grey[300]!,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 5),
              Image.asset(image, width: 30),
            ]),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(color: Colors.black, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
