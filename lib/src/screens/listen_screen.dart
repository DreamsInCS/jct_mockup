import 'dart:async';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ListenScreen extends StatefulWidget {

  @override
  _ListenScreenState createState() => _ListenScreenState();
}

class _ListenScreenState extends State<ListenScreen> {
  WebSocketChannel wsChannel;
  Timer timer;

  void initState() {
    wsChannel = IOWebSocketChannel.connect('ws://ade18054.ngrok.io/listen');
    timer = new Timer.periodic(
      Duration(milliseconds: 10), (Timer t) {
        wsChannel.sink.add("Gimme audio!");
      });

    super.initState();
  }

  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: wsChannel.stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final audioData = snapshot.data;
        return Scaffold(
          appBar: AppBar(
            title: Text('Listening Screen'),
          ),
          body: Center(
            child: Text('Audio data length is ${audioData.length}.'),
          ),
        );
      }
    );
  }
}