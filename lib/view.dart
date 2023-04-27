import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TextChecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const text =
        'Hi, my email is john@example.com and my website is https://example.com  0123-456-7890';
    final emailRegex = RegExp(r'\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b',
        caseSensitive: false);

    final urlRegex = RegExp(
        r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+',
        caseSensitive: false);
    final phoneRegex = RegExp(r'\b\d{10}\b', caseSensitive: false);

    final textSpans = <TextSpan>[];
    var lastIndex = 0;

    for (final match in emailRegex.allMatches(text)) {
      final email = match.group(0)!;
      final before = text.substring(lastIndex, match.start);
      lastIndex = match.end;

      if (before.isNotEmpty) {
        textSpans.add(TextSpan(text: before));
      }

      textSpans.add(
        TextSpan(
          text: email,
          style: const TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              launch('mailto:$email');
            },
        ),
      );
    }

    final remainingText = text.substring(lastIndex);

    if (remainingText.isNotEmpty) {
      textSpans.add(TextSpan(text: remainingText));
    }

    lastIndex = 0;

    for (final match in urlRegex.allMatches(text)) {
      final url = match.group(0)!;
      final before = text.substring(lastIndex, match.start);
      lastIndex = match.end;

      if (before.isNotEmpty) {
        textSpans.add(TextSpan(text: before));
      }

      textSpans.add(
        TextSpan(
          text: url,
          style: const TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              launch(url);
            },
        ),
      );
    }

    final remainingText2 = text.substring(lastIndex);

    if (remainingText2.isNotEmpty) {
      textSpans.add(TextSpan(text: remainingText2));
    }
    for (final match in phoneRegex.allMatches(text)) {
      final phone = match.group(0)!;
      final before = text.substring(lastIndex, match.start);
      lastIndex = match.end;

      if (before.isNotEmpty) {
        textSpans.add(TextSpan(text: before));
      }

      textSpans.add(
        TextSpan(
          text: phone,
          style: const TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              launch('tel:$phone');
            },
        ),
      );
    }
    
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          RichText(
            text: TextSpan(children: textSpans),
          ),
        ],
      ),
    );
  }
}
