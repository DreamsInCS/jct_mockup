import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: Center(
        child: Text("Text."),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.mic),
              title: Text('Record'),
              onTap: () => Navigator.pushNamed(context, "/auth"),
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Search')
            ),
            ListTile(
              leading: Icon(Icons.music_note),
              title: Text('My Music')
            ),
          ],
        )
      ),
    );
  }
}