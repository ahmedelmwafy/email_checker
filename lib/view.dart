import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmailChecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const text = 'hi ahmed  hi@gmail.com';
    final emailRegex = RegExp(r'\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b',
        caseSensitive: false);

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
