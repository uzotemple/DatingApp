import 'package:flutter/material.dart';
import 'package:flutter_story/flutter_story.dart';

class StoryExamplePage extends StatefulWidget {
  const StoryExamplePage({super.key});

  @override
  State<StoryExamplePage> createState() => _StoryExamplePageState();
}

class _StoryExamplePageState extends State<StoryExamplePage> {
  StoryController storyController = StoryController();
  late List<StoryModel> stories;

  @override
  void initState() {
    super.initState();
    stories = getStories();
  }

  @override
  void dispose() {
    super.dispose();
    storyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Story.builder(
                  controller: storyController,
                  itemCount: stories.length,
                  itemBuilder: (context, index) {
                    StoryModel s = stories[index];
                    return StoryUser(
                      avatar: s.avatar,
                      label: s.label,
                      children: s.cards == null
                          ? []
                          : s.cards!
                              .map((card) => StoryCard(
                                    onVisited: (cardIndex) {
                                      setState(() {
                                        card.visited = true;
                                      });
                                    },
                                    footer: StoryCardFooter(
                                      messageBox: StoryCardMessageBox(
                                        child: Center(
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.5,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.5,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    MaterialButton(
                                                      minWidth: 0,
                                                      padding: EdgeInsets.zero,
                                                      shape:
                                                          const CircleBorder(),
                                                      child: const Text(
                                                        "😂",
                                                        style: TextStyle(
                                                            fontSize: 32),
                                                      ),
                                                      onPressed: () {},
                                                    ),
                                                    MaterialButton(
                                                      minWidth: 0,
                                                      padding: EdgeInsets.zero,
                                                      shape:
                                                          const CircleBorder(),
                                                      child: const Text(
                                                        "😮",
                                                        style: TextStyle(
                                                            fontSize: 32),
                                                      ),
                                                      onPressed: () {},
                                                    ),
                                                    MaterialButton(
                                                      minWidth: 0,
                                                      padding: EdgeInsets.zero,
                                                      shape:
                                                          const CircleBorder(),
                                                      child: const Text(
                                                        "😍",
                                                        style: TextStyle(
                                                            fontSize: 32),
                                                      ),
                                                      onPressed: () {},
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 30),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    MaterialButton(
                                                      minWidth: 0,
                                                      padding: EdgeInsets.zero,
                                                      shape:
                                                          const CircleBorder(),
                                                      child: const Text(
                                                        "😢",
                                                        style: TextStyle(
                                                            fontSize: 32),
                                                      ),
                                                      onPressed: () {},
                                                    ),
                                                    MaterialButton(
                                                      minWidth: 0,
                                                      padding: EdgeInsets.zero,
                                                      shape:
                                                          const CircleBorder(),
                                                      child: const Text(
                                                        "👏",
                                                        style: TextStyle(
                                                            fontSize: 32),
                                                      ),
                                                      onPressed: () {},
                                                    ),
                                                    MaterialButton(
                                                      minWidth: 0,
                                                      padding: EdgeInsets.zero,
                                                      shape:
                                                          const CircleBorder(),
                                                      child: const Text(
                                                        "🔥",
                                                        style: TextStyle(
                                                            fontSize: 32),
                                                      ),
                                                      onPressed: () {},
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      likeButton: StoryCardLikeButton(
                                        onLike: (cardLike) {},
                                      ),
                                      forwardButton: StoryCardForwardButton(
                                        onForward: (cardIndex) {},
                                      ),
                                    ),
                                    color: card.color,
                                    visited: card.visited,
                                    cardDuration: card.duration,
                                    childOverlay: card.childOverlay,
                                    child: card.child,
                                  ))
                              .toList(),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  List<StoryModel> getStories() {
    List<StoryModel> storyList = [];
    for (int i = 1; i <= 3; i++) {
      storyList.add(StoryModel(
          id: i + 2,
          avatar: Image.asset("assets/images/avatar$i.png"),
          label: Text(
            userLabel(i),
            style: const TextStyle(color: Colors.black),
          ),
          cards: [
            storyCard1(i),
            storyCard2(i),
          ]));
    }
    return storyList;
  }

  StoryCardModel storyCard1(int i) => StoryCardModel(
        color: Colors.purple,
        childOverlay: Container(
          margin: const EdgeInsets.all(50),
          child: const Center(
            child: Text(
              "Lorem Ipsum is simply dummy text of the printing "
              "and typesetting industry. Lorem Ipsum has been the industry's "
              "standard dummy text ever since the 1500s, when an unknown "
              "printer took a galley of type and scrambled it to "
              "make a type specimen book. It has survived not only five centuries,"
              " but also the leap into electronic typesetting, "
              "remaining essentially unchanged. It was popularised in the 1960s "
              "with the release of Letraset sheets containing "
              "Lorem Ipsum passages, and more recently with "
              "desktop publishing software like Aldus PageMaker "
              "including versions of Lorem Ipsum.",
              style: TextStyle(color: Colors.white, fontSize: 20, height: 1.5),
            ),
          ),
        ),
      );

  StoryCardModel storyCard2(int i) => StoryCardModel(
        child: Container(
          color: Colors.purple,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                color: Colors.white,
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    "user $i",
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Image.asset("assets/images/avatar$i.png"),
              const SizedBox(height: 10),
              Container(
                width: 250,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.red.withAlpha(150),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: const Center(
                  child: Text(
                    "This is a container widget",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 350,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.black.withAlpha(50),
                    border: Border.all(color: Colors.white, width: 1)),
                child: Center(
                  child: Text(
                    "This is a container widget",
                    style:
                        TextStyle(color: Colors.white, fontSize: 20, shadows: [
                      Shadow(
                          color: Colors.black.withAlpha(150),
                          blurRadius: 20,
                          offset: const Offset(0, 0))
                    ]),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  "Story $i",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    shadows: [
                      Shadow(
                          color: Colors.red,
                          blurRadius: 20,
                          offset: Offset(0, 0))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  String userLabel(int storyIndex) {
    String label = "";
    switch (storyIndex) {
      case 1:
        return "Oliver";
      case 2:
        return "Liam";
      case 3:
        return "Benjamin";
    }
    return label;
  }
}

class StoryModel {
  StoryModel({
    this.id,
    this.avatar,
    this.label,
    this.cards,
  });

  int? id;
  Widget? avatar;
  Text? label;
  List<StoryCardModel>? cards;
}

class StoryCardModel {
  StoryCardModel({
    this.visited = false,
    this.duration = const Duration(seconds: 2),
    this.color = const Color(0xff333333),
    this.childOverlay,
    this.child,
  });

  bool visited;
  Duration duration;
  Color color;
  Widget? childOverlay;
  Widget? child;
}
