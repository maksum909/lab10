import 'package:flutter/material.dart';
import 'second_screen.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final TextEditingController _textController = TextEditingController();
  double _textSize = 16.0; // Початковий розмір тексту

  Future<void> _showDialog(String message) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(16.0), // для кращого відступу
          content: Column(
            mainAxisSize: MainAxisSize.min, // обмежує висоту колонки
            children: [
              Center(
                child: Image.asset(
                  'assets/images/Robot_Emoji_Icon_abe1111a-1293-4668-bdf9-9ceb05cff58e_large.webp',
                  width: 100, // зменшення ширини зображення
                  height: 100, // зменшення висоти зображення
                ),
              ),
              SizedBox(height: 10), // додатковий відступ
              Text(
                message,
                textAlign: TextAlign.center, // для центрування тексту
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(labelText: 'Enter text'),
            ),
            SizedBox(height: 20),
            Text(
              'Text size: ${_textSize.toStringAsFixed(1)}',
              style: TextStyle(fontSize: 16),
            ),
            Slider(
              value: _textSize,
              min: 10.0,
              max: 50.0,
              divisions: 40,
              label: _textSize.toStringAsFixed(1),
              onChanged: (newValue) {
                setState(() {
                  _textSize = newValue;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondScreen(
                      text: _textController.text,
                      textSize: _textSize,
                    ),
                  ),
                );

                if (result == 'ok') {
                  _showDialog('Cool!');
                } else if (result == 'cancel') {
                  _showDialog('Let’s try something else');
                } else {
                  _showDialog('Don\'t know what to say');
                }
              },
              child: Text('Preview Text'),
            ),
          ],
        ),
      ),
    );
  }
}
