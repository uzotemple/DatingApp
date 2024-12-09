// import 'package:flutter/material.dart';
// import 'package:love_bird/chatBott/lib/models/chat_model.dart';
// import 'package:love_bird/chatBott/lib/utils/constants.dart';
// import 'package:love_bird/chatBott/lib/utils/helper_widgets.dart';

// class ChatItemCard extends StatefulWidget {
//   final ChatModel chatItem;
//   final GestureTapCallback? onTap;
//   final GestureTapCallback? onLongPress;
//   final Color botChatBubbleColor;
//   final Color userChatBubbleColor;
//   final Color chatBubbleTextColor;

//   const ChatItemCard(
//       {super.key,
//       this.onTap,
//       this.onLongPress,
//       required this.chatItem,
//       this.botChatBubbleColor = primaryColor,
//       this.userChatBubbleColor = secondaryColor,
//       this.chatBubbleTextColor = Colors.black});

//   @override
//   State<ChatItemCard> createState() => _ChatItemCardState();
// }

// class _ChatItemCardState extends State<ChatItemCard> {
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onLongPress: widget.onLongPress,
//       onTap: widget.onTap,
//       child: Row(
//         mainAxisAlignment: widget.chatItem.chat == 0
//             ? MainAxisAlignment.end
//             : MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           if (widget.chatItem.chat == 1 ||
//               widget.chatItem.chatType == ChatType.error)
//             const Row(
//               children: [
//                 SizedBox(width: 8),
//                 CircleAvatar(
//                   radius: 20,
//                   backgroundImage: AssetImage('assets/images/libby.png'),
//                 ),
//                 SizedBox(width: 8), // Spacing between image and bubble
//               ],
//             ),
//           Flexible(
//             child: Container(
//               margin: const EdgeInsets.only(left: 0, right: 10, top: 20),
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: widget.chatItem.chat == 0
//                     ? widget.botChatBubbleColor.withOpacity(0.1)
//                     : widget.userChatBubbleColor.withOpacity(0.1),
//                 borderRadius: widget.chatItem.chatType == ChatType.error
//                     ? const BorderRadius.all(Radius.circular(30))
//                     : widget.chatItem.chat == 0
//                         ? const BorderRadius.only(
//                             topLeft: Radius.circular(30),
//                             topRight: Radius.circular(30),
//                             bottomLeft: Radius.circular(30),
//                             bottomRight: Radius.circular(10),
//                           )
//                         : const BorderRadius.only(
//                             topLeft: Radius.circular(30),
//                             topRight: Radius.circular(30),
//                             bottomRight: Radius.circular(30),
//                             bottomLeft: Radius.circular(10),
//                           ),
//               ),
//               child: Column(
//                 crossAxisAlignment: widget.chatItem.chatType == ChatType.error
//                     ? CrossAxisAlignment.start
//                     : CrossAxisAlignment.start,
//                 children: [
//                   if (widget.chatItem.chatType == ChatType.loading)
//                     SizedBox(height: 50, width: 50, child: loadingWidget()),
//                   if (widget.chatItem.chatType != ChatType.loading)
//                     RichText(
//                       text: formatText(
//                         widget.chatItem.message,
//                         widget.chatBubbleTextColor,
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//           if (widget.chatItem.chat == 0)
//             const Row(
//               children: [
//                 SizedBox(width: 8), // Spacing between bubble and image
//                 CircleAvatar(
//                   radius: 20,
//                   backgroundImage: AssetImage('assets/images/homeImage.png'),
//                 ),
//                 SizedBox(width: 8),
//               ],
//             ),
//         ],
//       ),
//     );
//   }

//   /// Formats the given text by applying bold styling to the text enclosed in double asterisks.
// //   TextSpan formatText(String text) {
// //     RegExp regex = RegExp(r'\*\*(.*?)\*\*');
// //     List<TextSpan> spans = [];

// //     text.splitMapJoin(
// //       regex,
// //       onMatch: (Match match) {
// //         spans.add(TextSpan(
// //           text: match.group(1),
// //           style: const TextStyle(
// //             fontWeight: FontWeight.bold,
// //             // Autres propriétés de style si nécessaire
// //           ),
// //         ));
// //         return '';
// //       },
// //       onNonMatch: (String text) {
// //         spans.add(TextSpan(text: text));
// //         return '';
// //       },
// //     );
// //     return TextSpan(children: spans);
// //   }
// // }

//   TextSpan formatText(String text, Color textColor) {
//     RegExp regex = RegExp(r'\*\*(.*?)\*\*');
//     List<TextSpan> spans = [];

//     text.splitMapJoin(
//       regex,
//       onMatch: (Match match) {
//         spans.add(TextSpan(
//           text: match.group(1),
//           style: TextStyle(
//             fontWeight: FontWeight.w500,
//             color: textColor, // Apply the passed text color
//           ),
//         ));
//         return '';
//       },
//       onNonMatch: (String text) {
//         spans.add(TextSpan(
//           text: text,
//           style: TextStyle(
//             color: textColor,
//             fontWeight: FontWeight.w500,
//           ), // Apply the passed text color
//         ));
//         return '';
//       },
//     );
//     return TextSpan(children: spans);
//   }
// }

// @override
// bool hitTestSelf(Offset position) => true;
import 'package:flutter/material.dart';
import 'package:love_bird/chatBott/lib/models/chat_model.dart';
import 'package:love_bird/chatBott/lib/utils/constants.dart';
import 'package:love_bird/chatBott/lib/utils/helper_widgets.dart';

// List of blocked keywords or phrases you want to prevent from displaying
final List<String> blockedKeywords = [
  ''' **Home Screen**: Explain the swipe-based interface where users can:
   - **Like** a profile by tapping the heart icon.
   - **Superlike** a profile by tapping the star icon.
   - **Cancel** a profile by tapping the cancel icon.  
   - **Reverse** a recent action (like, superlike,'''
];

// Function to check if a response should be blocked
bool isResponseBlocked(String message) {
  for (var keyword in blockedKeywords) {
    if (message.toLowerCase().contains(keyword.toLowerCase())) {
      return true;
    }
  }
  return false; // Allow the response if no blocked keyword is found
}

class ChatItemCard extends StatefulWidget {
  final ChatModel chatItem;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onLongPress;
  final Color botChatBubbleColor;
  final Color userChatBubbleColor;
  final Color chatBubbleTextColor;

  const ChatItemCard({
    super.key,
    this.onTap,
    this.onLongPress,
    required this.chatItem,
    this.botChatBubbleColor = primaryColor,
    this.userChatBubbleColor = secondaryColor,
    this.chatBubbleTextColor = Colors.black,
  });

  @override
  State<ChatItemCard> createState() => _ChatItemCardState();
}

class _ChatItemCardState extends State<ChatItemCard> {
  @override
  Widget build(BuildContext context) {
    // Check if the response should be blocked
    if (isResponseBlocked(widget.chatItem.message)) {
      // return SizedBox
      //     .shrink();
      return _buildErrorMessage();
    }

    return Row(
      mainAxisAlignment: widget.chatItem.chat == 0
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (widget.chatItem.chat == 1 ||
            widget.chatItem.chatType == ChatType.error)
          const Row(
            children: [
              SizedBox(width: 8),
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/libby.png'),
              ),
              SizedBox(width: 8), // Spacing between image and bubble
            ],
          ),
        Flexible(
          child: InkWell(
            onTap: widget.chatItem.chat == 0 ? widget.onTap : () {},
            onLongPress: widget.chatItem.chat == 0 ? widget.onLongPress : () {},
            child: Container(
              margin: const EdgeInsets.only(left: 0, right: 10, top: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: widget.chatItem.chat == 0
                    ? widget.botChatBubbleColor.withOpacity(0.1)
                    : widget.userChatBubbleColor.withOpacity(0.1),
                borderRadius: widget.chatItem.chatType == ChatType.error
                    ? const BorderRadius.all(Radius.circular(30))
                    : widget.chatItem.chat == 0
                        ? const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(10),
                          )
                        : const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                            bottomLeft: Radius.circular(10),
                          ),
              ),
              child: Column(
                crossAxisAlignment: widget.chatItem.chatType == ChatType.error
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.start,
                children: [
                  if (widget.chatItem.chatType == ChatType.loading)
                    SizedBox(height: 50, width: 50, child: loadingWidget()),
                  if (widget.chatItem.chatType != ChatType.loading)
                    RichText(
                      text: formatText(
                        widget.chatItem.message,
                        widget.chatBubbleTextColor,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        if (widget.chatItem.chat == 0)
          const Row(
            children: [
              SizedBox(width: 8), // Spacing between bubble and image
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/homeImage.png'),
              ),
              SizedBox(width: 8),
            ],
          ),
      ],
    );
  }

  // Function to handle error messages
  Widget _buildErrorMessage() {
    return Row(
      children: [
        const Row(
          children: [
            SizedBox(width: 8),
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/libby.png'),
            ),
            SizedBox(width: 8), // Spacing between image and bubble
          ],
        ),
        Flexible(
          child: Container(
            margin: const EdgeInsets.only(left: 0, right: 10, top: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: widget.botChatBubbleColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text(
              'Sorry, there was an issue with processing your request. Please try again.',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Formats the given text by applying bold styling to the text enclosed in double asterisks
  TextSpan formatText(String text, Color textColor) {
    RegExp regex = RegExp(r'\*\*(.*?)\*\*');
    List<TextSpan> spans = [];

    text.splitMapJoin(
      regex,
      onMatch: (Match match) {
        spans.add(TextSpan(
          text: match.group(1),
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ));
        return '';
      },
      onNonMatch: (String text) {
        spans.add(TextSpan(
          text: text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w500,
          ), // Apply the passed text color
        ));
        return '';
      },
    );
    return TextSpan(children: spans);
  }
}

@override
bool hitTestSelf(Offset position) => true;
