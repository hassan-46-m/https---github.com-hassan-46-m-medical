import 'package:flutter/material.dart';


class PharmaBotApp extends StatelessWidget {

  const PharmaBotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ChatScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
  static const String routeName = "Chat Screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const Icon(Icons.arrow_back),
        title: const Text("PharmaBot"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(

              padding: const EdgeInsets.all(16),
              children: const [
                BotMessage(text: "Hi, how can I help you today?"),
                UserMessage(text: "Tell me about Panadol."),
                BotMessage(
                  text: "Panadol is used for relieving pain and fever",
                  hasLink: true,
                ),
              ],
            ),
          ),
          const ChatInputField(),
        ],
      ),
    );
  }
}

class BotMessage extends StatelessWidget {
  final String text;
  final bool hasLink;

  const BotMessage({super.key, required this.text, this.hasLink = false});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(top:20,bottom: 20 ),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade700,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(text),
          ),
          if (hasLink)
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              child: const Text(
                "Drug Info",
                style: TextStyle(color: Colors.lightBlueAccent),
              ),
            )
        ],
      ),
    );
  }
}

class UserMessage extends StatelessWidget {
  final String text;

  const UserMessage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          color: Color(0xff20506D),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(text),
      ),

    );



  }
}

class ChatInputField extends StatelessWidget {
  const ChatInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: Colors.black,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade700,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Type your question...",
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.lightBlueAccent),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
