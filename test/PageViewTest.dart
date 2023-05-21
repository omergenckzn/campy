import 'package:flutter/material.dart';

class PageViewTest extends StatefulWidget {
  const PageViewTest({Key? key}) : super(key: key);

  @override
  State<PageViewTest> createState() => _PageViewTestState();
}

class _PageViewTestState extends State<PageViewTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: Expanded(
              child: Container(
                width: double.infinity,
                height: 100,
                child: PageView(
                  children: [
                    Text('Page1'),
                    Text('Page 2'),
                    Text('Page 3')
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
