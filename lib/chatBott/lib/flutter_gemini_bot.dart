library flutter_gemini_bot;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:love_bird/chatBott/lib/components/cards/chat_item_card.dart';
import 'package:love_bird/chatBott/lib/models/chat_model.dart';
import 'package:love_bird/chatBott/lib/services/gemini_ai_api.dart';
import 'package:love_bird/chatBott/lib/utils/constants.dart';
import 'package:love_bird/chatBott/lib/utils/helper_widgets.dart';
import 'package:love_bird/config/constants.dart';

class FlutterGeminiChat extends StatefulWidget {
  const FlutterGeminiChat({
    super.key,
    required this.chatContext,
    required this.chatList,
    required this.apiKey,
    this.hintText = "Ask your questions...",
    // this.bodyPlaceHolder = const BodyPlaceholderWidget(),
    this.buttonColor = primaryColor,
    this.errorMessage =
        "I am unable to answer this question, please try a different question",
    this.botChatBubbleColor = primaryColor,
    this.userChatBubbleColor = primaryColor,
    this.botChatBubbleTextColor = Colors.black,
    this.userChatBubbleTextColor = Colors.black,
    this.loaderWidget = const Center(
      child: CircularProgressIndicator(
        color: primaryColor,
      ),
    ),
    this.onRecorderTap,
  });

  /// The context of the chat.
  final String chatContext;

  /// The list of chat models.
  final List<ChatModel> chatList;

  /// The API key for the chat get it on https://ai.google.dev/.
  final String apiKey;

  /// The hint text for the chat input field.
  final String hintText;

  /// The placeholder widget to be displayed in the chat body.
  // final Widget bodyPlaceHolder;

  /// The color of the chat button.
  final Color buttonColor;

  /// The error message to be displayed in case of an error.
  final String errorMessage;

  /// The color of the chat bubble for the bots messages.
  final Color botChatBubbleColor;

  /// The color of the chat bubble for the user's messages.
  final Color userChatBubbleColor;

  ///The color of text chat bubble for the bots messages.
  final Color botChatBubbleTextColor;

  ///The color of text chat bubble for the users messages.
  final Color userChatBubbleTextColor;

  /// The loader widget to be displayed in the chat body.
  final Widget loaderWidget;

  /// Recorder button onTap callback.
  final VoidCallback? onRecorderTap;

  @override
  _FlutterGeminiChatState createState() => _FlutterGeminiChatState();
}

class _FlutterGeminiChatState extends State<FlutterGeminiChat> {
  List<Map<String, String>> messages = [];

  final TextEditingController questionController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    messages.add({"text": widget.chatContext});
  }

  @override
  void dispose() {
    questionController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: chatBody(),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: texFieldBottomWidget(),
        ),
      ],
    );
  }

  /// Builds the chat body widget.
  ///
  /// This method returns a [Padding] widget that contains a [ListView.builder]
  /// widget. The [ListView.builder] widget is used to display a list of chat items
  /// based on the [widget.chatList] property. Each chat item is rendered using
  /// the [ChatItemCard] widget. The [onTap] callback is invoked when a chat item
  /// is tapped, and it shows a tools dialog for that chat item.
  ///
  /// The [controller] property of the [ListView.builder] is set to [_scrollController],
  /// which allows for scrolling functionality. The [scrollDirection] is set to
  /// [Axis.vertical] to display the chat items vertically. The [shrinkWrap] property
  /// is set to true to make the [ListView.builder] take up only the necessary space.
  ///
  /// Returns:
  ///   - A [Padding] widget that contains the chat body.
  Padding chatBody() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 90),
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: widget.chatList.length,
        itemBuilder: (context, index) => ChatItemCard(
          botChatBubbleColor: widget.botChatBubbleColor,
          userChatBubbleColor: widget.userChatBubbleColor,
          chatItem: widget.chatList[index],
          onTap: () {
            showToolsDialog(context, index);
          },
        ),
      ),
    );
  }

  /// Shows a dialog with tools options for a given [index] in the chat list.
  ///
  /// This method displays a custom dialog with options such as copy, delete, and edit.
  /// When the copy option is selected, the message at the specified [index] in the chat list
  /// is copied to the clipboard. When the delete option is selected, the message at the
  /// specified [index] is removed from the chat list. When the edit option is selected,
  /// the message at the specified [index] is set as the text in the [questionController]
  /// and the cursor is positioned at the end of the text.
  ///
  /// The [context] parameter is the build context of the widget where the dialog is shown.
  ///
  /// Returns a [Future] that resolves to the value returned by the [customDialog] method.
  Future<dynamic> showToolsDialog(BuildContext context, int index) {
    return customDialog(
      context: context,
      widget: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: () {
              Clipboard.setData(
                  ClipboardData(text: widget.chatList[index].message));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: primaryColor,
                  duration: Duration(milliseconds: 400),
                  content: Text('Copied to Clipboard',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500)),
                ),
              );
            },
            leading: const Icon(Icons.copy),
            title: const Text("Copy"),
          ),
          ListTile(
            onTap: () {
              setState(() {
                widget.chatList.removeAt(index);
              });
              Navigator.pop(context);
            },
            leading: const Icon(Icons.delete),
            title: const Text("Delete"),
          ),
          ListTile(
            onTap: () {
              setState(() {
                questionController.text = widget.chatList[index].message;
                questionController.selection = TextSelection.fromPosition(
                    TextPosition(offset: questionController.text.length));
              });
              Navigator.pop(context);
            },
            leading: const Icon(Icons.add),
            title: const Text("Edit"),
          ),
        ],
      ),
    );
  }

  Widget texFieldBottomWidget() {
    // return Container(
    //   height: 90,
    //   padding: const EdgeInsets.only(
    //       left: appPadding, right: appPadding, top: appPadding + 8),
    //   color: Colors.white,
    //   child: TextField(
    //     decoration: InputDecoration(
    //       contentPadding: const EdgeInsets.all(10),
    //       hintText: widget.hintText,
    //       suffixIcon: questionController.text.isEmpty
    //           ? InkWell(
    //               onTap: widget.onRecorderTap,
    //               child: Container(
    //                 decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(50),
    //                     color: secondaryColor),
    //                 padding: const EdgeInsets.all(14),
    //                 child: const Icon(
    //                   Icons.mic,
    //                   color: Colors.white,
    //                   size: 24,
    //                 ),
    //               ),
    //             )
    //           : InkWell(
    //               onTap: () async {
    //                 var question = questionController.text;
    //                 setState(() {
    //                   widget.chatList.add(ChatModel(
    //                       chat: 0,
    //                       message: questionController.text,
    //                       time:
    //                           "${DateTime.now().hour}:${DateTime.now().second}"));

    //                   setState(() {
    //                     widget.chatList.add(ChatModel(
    //                         chatType: ChatType.loading,
    //                         chat: 1,
    //                         message: "",
    //                         time: ""));
    //                   });

    //                   FocusScope.of(context).unfocus();
    //                   try {
    //                     _scrollController.animateTo(
    //                         _scrollController.position.maxScrollExtent,
    //                         duration: const Duration(milliseconds: 300),
    //                         curve: Curves.easeOut);
    //                   } catch (e) {
    //                     print(
    //                         "**************************************************************");
    //                     print(e);
    //                   }
    //                   messages.add({
    //                     "text": "${widget.chatContext}\n$question",
    //                   });
    //                   questionController.text = "";
    //                 });
    //                 var (responseString, response) =
    //                     await GeminiApi.geminiChatApi(
    //                         messages: messages, apiKey: widget.apiKey);
    //                 setState(() {
    //                   FocusScope.of(context).unfocus();
    //                   _scrollController.animateTo(
    //                       _scrollController.position.maxScrollExtent +
    //                           MediaQuery.of(context).size.height,
    //                       duration: const Duration(milliseconds: 300),
    //                       curve: Curves.easeOut);
    //                   if (response.statusCode == 200) {
    //                     widget.chatList.removeLast();
    //                     widget.chatList.add(ChatModel(
    //                         chat: 1,
    //                         message: responseString,
    //                         time:
    //                             "${DateTime.now().hour}:${DateTime.now().second}"));
    //                   } else {
    //                     widget.chatList.removeLast();
    //                     widget.chatList.add(ChatModel(
    //                         chat: 0,
    //                         chatType: ChatType.error,
    //                         message: widget.errorMessage,
    //                         time:
    //                             "${DateTime.now().hour}:${DateTime.now().second}"));
    //                   }
    //                   FocusScope.of(context).unfocus();
    //                 });
    //               },
    //               child: Container(
    //                 decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(50),
    //                     color: widget.buttonColor),
    //                 padding: const EdgeInsets.all(14),
    //                 child: const Icon(
    //                   Icons.send_rounded,
    //                   color: Colors.white,
    //                   size: 24,
    //                 ),
    //               ),
    //             ),
    //       labelStyle: const TextStyle(fontSize: 12),
    //       enabledBorder: OutlineInputBorder(
    //         borderSide: const BorderSide(color: Colors.blueGrey),
    //         borderRadius: BorderRadius.circular(25),
    //       ),
    //       focusedBorder: OutlineInputBorder(
    //         borderSide: const BorderSide(color: primaryColor),
    //         borderRadius: BorderRadius.circular(12),
    //       ),
    //     ),
    //     controller: questionController,
    //     onChanged: (value) {
    //       setState(() {});
    //     },
    //   ),
    // );

    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: appPadding),
      color: Colors.white,
      child: Row(
        children: [
          // Text Field
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                hintText: widget.hintText,
                labelStyle: const TextStyle(fontSize: 12),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: blue,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: blue,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              controller: questionController,
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          const SizedBox(
              width: 8), // Space between the TextField and Send Button

          // Send Button
          InkWell(
            onTap: () async {
              var question = questionController.text;
              if (question.isEmpty) return; // Prevent empty messages

              setState(() {
                widget.chatList.add(ChatModel(
                  chat: 0,
                  message: question,
                  time: "${DateTime.now().hour}:${DateTime.now().second}",
                ));

                widget.chatList.add(ChatModel(
                  chatType: ChatType.loading,
                  chat: 1,
                  message: "",
                  time: "",
                ));
              });

              FocusScope.of(context).unfocus();
              try {
                _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              } catch (e) {
                print(e);
              }

              messages.add({
                "text": "${widget.chatContext}\n$question",
              });
              questionController.text = "";

              var (responseString, response) = await GeminiApi.geminiChatApi(
                messages: messages,
                apiKey: widget.apiKey,
              );

              setState(() {
                widget.chatList.removeLast();
                if (response.statusCode == 200) {
                  widget.chatList.add(ChatModel(
                    chat: 1,
                    message: responseString,
                    time: "${DateTime.now().hour}:${DateTime.now().second}",
                  ));
                } else {
                  widget.chatList.add(ChatModel(
                    chat: 0,
                    chatType: ChatType.error,
                    message: widget.errorMessage,
                    time: "${DateTime.now().hour}:${DateTime.now().second}",
                  ));
                }
              });
            },
            child: const Icon(
              Icons.send_rounded,
              color: blue,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}

/// A placeholder widget for the body of the Gemini Bot.
///
/// This widget displays a centered column with an icon and a text.
/// It is typically used as a placeholder while the actual body content is being loaded.
// class BodyPlaceholderWidget extends StatelessWidget {
//   const BodyPlaceholderWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       Container(
//           width: 100,
//           height: 400,
//           decoration: const BoxDecoration(
//             color: blue, // Background color
//           ),
//           child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 children: [
//                   Expanded(
//                     flex: 2,
//                     child: Container(
//                       color: blue,
//                       child: Padding(
//                         padding:
//                             const EdgeInsets.only(top: 20, left: 5, right: 5),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Text(
//                                   "Hello there",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                                 // Image.asset('assets/images/wave.png',
//                                 //     height: 18),
//                               ],
//                             ),
//                             const SizedBox(height: 5),
//                             Text(
//                               "I am Libby!",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             const SizedBox(height: 5),
//                             Text(
//                               "Welcome to Zenkonect AI Virtual Assistance.",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             const SizedBox(height: 20),
//                             Text(
//                               "You can ask me anything on dating, relationship advice, event & activity suggestions, conversation advice, real-life tips, etc.",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontStyle: FontStyle.italic,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               )))
//     ]);
//   }
// }
