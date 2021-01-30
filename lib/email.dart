import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Email extends StatefulWidget {
  @override
  _EmailState createState() => _EmailState();
}

class _EmailState extends State<Email> {
  String _email = "";
  String _subject = "";
  String _body = "";

  final _emailkey = GlobalKey<FormState>();
  _launcUrl(String email, String subject, String body) async {
    var url =
        'mailto:$Email?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(body)}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Email"),
      ),
      body: Form(
        key: _emailkey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(hintText: 'E-mail adress'),
              onSaved: (String value) {
                _email = value;
              },
            ),
            Container(
              child: TextFormField(
                  decoration: InputDecoration(hintText: "Title"),
                  onSaved: (String value) {
                    _subject = value;
                  }),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              child: TextFormField(
                decoration: InputDecoration(hintText: "body"),
                onSaved: (String value) {
                  _body = value;
                },
              ),
            ),
            RaisedButton(
              child: Text("Send Email"),
              onPressed: () {
                _emailkey.currentState.save();
                _launcUrl(_email, _subject, _body);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
