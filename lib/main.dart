import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

// For the testing purposes, you should probably use https://pub.dev/packages/uuid.
String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => 
      MaterialApp(
        home: const MyHomePage(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData (
          primarySwatch: Colors.blue,
        ),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<types.Message> _messages = [];
  final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');
  final _user1 = const types.User( firstName: "Khandoker", lastName: "Anan",id: '82091008-a484-4a89-ae75-a22bf8d6f3af', imageUrl: "https://media.licdn.com/dms/image/C4D03AQEw_wsDq963ng/profile-displayphoto-shrink_800_800/0/1663692245119?e=2147483647&v=beta&t=AWgt0znny1vHUvJrQaztDu-n2VaFYZIKOONem2Mlk8k" );
  int id = 1;


  void handleClick(int item) {
    switch (item) {
      case 0:
        break;
      case 1:
        break;
    }
  }
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black,),
          title: const Center(child:Text("KHANDOKER ANAN")),
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          titleTextStyle: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.arrow_turn_up_left, color: Colors.black,),
          ),
          actions: [
            PopupMenuButton<int>(
              
              onSelected: (item) => handleClick(item),
              itemBuilder: (context) => [
                const PopupMenuItem<int>(value: 0, child: Text('Show Profile')),
                const PopupMenuItem<int>(value: 1, child: Text('Mute')),
              ],
            ),
          ],
        ),
        body: Chat(
          showUserAvatars: true,
          inputOptions: const InputOptions(
              sendButtonVisibilityMode: SendButtonVisibilityMode.always,
              autocorrect: false,
          ),
          showUserNames: true,

          emptyState: const Center(child:Text("No Message\n Send a message now!", textAlign: TextAlign.center,)),
          theme: const DefaultChatTheme(
            backgroundColor:  Color.fromARGB(255, 229, 229, 229),
            inputBackgroundColor: Colors.black,
            inputBorderRadius: BorderRadius.all(Radius.circular(20)),
            //inputMargin: EdgeInsets.all(20),
            inputPadding: EdgeInsets.all(20),
            
            
            primaryColor: Colors.black,
            userNameTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            secondaryColor: Colors.white,
            userAvatarNameColors: [Colors.black],
        
          ),
          messages: _messages,
          onSendPressed: _handleSendPressed,
          user: _user,
          l10n: const ChatL10nEn(
            inputPlaceholder: 'Write Your Message',
          ),
        ),
      );

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: (id % 2 == 0) ? _user : _user1,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage);
    id++;
  }
}