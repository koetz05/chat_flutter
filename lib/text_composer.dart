import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TextComposer extends StatefulWidget {
  TextComposer(this.sendMessage);

  final Function({String text, File imgFile}) sendMessage;

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _isComponsing = false;

  void _reset() {
    _textEditingController.clear();
    setState(() {
      _isComponsing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_camera),
            onPressed: () async {
              final File imagFile =
                  await ImagePicker.pickImage(source: ImageSource.camera);
              if (imagFile == null) {
                return;
              } else {
                widget.sendMessage(imgFile: imagFile);
              }
            },
          ),
          Expanded(
            child: TextField(
              controller: _textEditingController,
              decoration:
                  InputDecoration.collapsed(hintText: "Enviar uma Mensagem"),
              onChanged: (text) {
                setState(() {
                  _isComponsing = text.isNotEmpty;
                });
              },
              onSubmitted: (text) {
                widget.sendMessage(text: text);
                _reset();
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _isComponsing
                ? () {
                    widget.sendMessage(text: _textEditingController.text);
                    _reset();
                  }
                : null,
          )
        ],
      ),
    );
  }
}
