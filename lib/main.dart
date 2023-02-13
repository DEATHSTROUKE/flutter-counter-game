import 'package:flutter/material.dart';
import 'dart:math';

void main() => (runApp(const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Align(
            alignment: Alignment.centerRight,
            child: Text('Counter'),
          ),
          centerTitle: false,
          backgroundColor: Colors.deepPurple,
          toolbarHeight: 70,
          leadingWidth: 70,
          leading: Padding(
            padding: EdgeInsets.all(4),
            child: HeaderLogo(),
          ),
        ),
        body: Center(child: Counter()),
      ),
    );
  }
}

class HeaderLogo extends StatefulWidget {
  @override
  _HeaderLogo createState() => _HeaderLogo();
}

class _HeaderLogo extends State<HeaderLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: Duration(seconds: 10),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: Image.asset(
        "assets/images/myicon.png",
        width: 100,
        height: 100,
        fit: BoxFit.fill,
      ),
      builder: (_, child) {
        return Transform.rotate(
          angle: _controller.value * 2.0 * pi,
          child: child,
        );
      },
    );
  }
}

class Counter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;
  bool _game_start = true;
  final GameCounterFinish = 10;

  Widget build(BuildContext context) {
    return Center(
        child: (_counter < GameCounterFinish || _game_start)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _counter.toString(),
                    style: TextStyle(fontSize: 40),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 70,
                        height: 70,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          color: Colors.white,
                          onPressed: () {
                            setState(() {
                              _counter--;
                              _game_start = true;
                            });
                          },
                          icon: Icon(Icons.remove),
                        ),
                      ),
                      Container(
                        width: 70,
                        height: 70,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          color: Colors.white,
                          onPressed: () {
                            setState(() {
                              _counter++;
                              _counter == 0
                                  ? _game_start = true
                                  : _game_start = false;
                            });
                          },
                          icon: Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 300,
                        child: LinearProgressIndicator(
                          value: _counter / GameCounterFinish,
                          color: Colors.deepPurple,
                        ),
                      )
                    ],
                  )
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "You win!",
                    style: TextStyle(fontSize: 30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.deepPurple,
                        ),
                        child: IconButton(
                          color: Colors.white,
                          onPressed: () => setState(() {
                            _counter = 0;
                            _game_start = true;
                          }),
                          icon: Icon(Icons.restart_alt),
                        ),
                      ),
                    ],
                  )
                ],
              ));
  }
}
