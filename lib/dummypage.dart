import 'package:flutter/material.dart';

class DummyPage extends StatefulWidget {
  const DummyPage({super.key});

  @override
  State<DummyPage> createState() => _DummyPageState();
}

class _DummyPageState extends State<DummyPage> {
  String name = "Ramu";

  List<Message> messages = [
    Message(
        sender: 'Me',
        text: 'Hello!',
        timeStamp: "02:03:00PM",
        profilePic: 'assets/images/background.jpg'),
    Message(
        sender: 'Friend',
        text: 'Hi there!',
        timeStamp: "01:03:00PM",
        profilePic: 'assets/images/background1.jpg'),
    Message(
        sender: 'Me',
        text: 'How are you?',
        timeStamp: "04:03:00PM",
        profilePic: 'assets/images/background.jpg'),
    Message(
        sender: 'Friend',
        text: 'I\'m doing great. Thanks!',
        timeStamp: "02:03:00PM",
        profilePic: 'assets/images/background1.jpg'),

    Message(
        sender: 'Me',
        text: 'Hello!',
        timeStamp: "02:03:00PM",
        profilePic: 'assets/images/background.jpg'),
    Message(
        sender: 'Friend',
        text: 'Hi there!',
        timeStamp: "01:03:00PM",
        profilePic: 'assets/images/background1.jpg'),
    Message(
        sender: 'Me',
        text: 'How are you?',
        timeStamp: "04:03:00PM",
        profilePic: 'assets/images/background.jpg'),
    Message(
        sender: 'Friend',
        text: 'I\'m doing great. Thanks!',
        timeStamp: "02:03:00PM",
        profilePic: 'assets/images/background1.jpg'),

    Message(
        sender: 'Me',
        text: 'Hello!',
        timeStamp: "02:03:00PM",
        profilePic: 'assets/images/background.jpg'),
    Message(
        sender: 'Friend',
        text: 'Hi there!',
        timeStamp: "01:03:00PM",
        profilePic: 'assets/images/background1.jpg'),
    Message(
        sender: 'Me',
        text: 'How are you?',
        timeStamp: "04:03:00PM",
        profilePic: 'assets/images/background.jpg'),
    Message(
        sender: 'Friend',
        text: 'I\'m doing great. Thanks!',
        timeStamp: "02:03:00PM",
        profilePic: 'assets/images/background1.jpg'),

    Message(
        sender: 'Me',
        text: 'Hello!',
        timeStamp: "02:03:00PM",
        profilePic: 'assets/images/background.jpg'),
    Message(
        sender: 'Friend',
        text: 'Hi there!',
        timeStamp: "01:03:00PM",
        profilePic: 'assets/images/background1.jpg'),
    Message(
        sender: 'Me',
        text: 'How are you?',
        timeStamp: "04:03:00PM",
        profilePic: 'assets/images/background.jpg'),
    Message(
        sender: 'Friend',
        text: 'I\'m doing great. Thanks!',
        timeStamp: "02:03:00PM",
        profilePic: 'assets/images/background1.jpg'),

    // Add more messages...
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [customAppBar(), chatBox(context), inputEntry()],
      )),
    );
  }

  Widget customAppBar() {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.blue,
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(255, 255, 255, 255),
                          spreadRadius: 3),
                    ],
                  ),
                  child: const Center(child: Text("AAC")),
                ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Marketing team"),
                    Text(
                      "Alice is typing",
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey.withOpacity(.7)),
                    ),
                  ],
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.blue,
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(255, 255, 255, 255),
                          spreadRadius: 3),
                    ],
                  ),
                  child: const Center(child: Text("DDD")),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.red,
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(255, 255, 255, 255),
                            spreadRadius: 3),
                      ],
                    ),
                    child: const Center(child: Text("DDD")),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey,
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(255, 255, 255, 255),
                            spreadRadius: 3),
                      ],
                    ),
                    child: const Center(child: Text("DDD")),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget chatBox(BuildContext context) {
    return Expanded(
        flex: 5,
        child: Container(
            color: const Color.fromRGBO(239, 246, 251, 1.0),
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isMe = message.sender == 'Me';

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment:
                        isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      !isMe
                          ? CircleAvatar(
                              child: Image.asset(
                                messages[index].profilePic,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const SizedBox.shrink(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isMe ? Colors.blue : Colors.grey[200],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            message.text,
                            style: TextStyle(
                              color: isMe ? Colors.white : Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      isMe
                          ? CircleAvatar(
                              child: Image.asset(messages[index].profilePic),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                );
              },
            )));
  }

  Widget inputEntry() {
    return Expanded(
        flex: 1,
        child: Container(
          color: Colors.blueAccent,
        ));
  }
}

class Message {
  final String sender;
  final String text;
  final String timeStamp;
  final String profilePic;

  Message(
      {required this.sender,
      required this.text,
      required this.profilePic,
      required this.timeStamp});
}
