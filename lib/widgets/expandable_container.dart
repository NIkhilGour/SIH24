import 'package:flutter/material.dart';

class ExpandableIconExample extends StatefulWidget {
  const ExpandableIconExample({super.key, required this.iconname, required this.textdata});
  final String iconname;
  final String textdata;

  @override
  _ExpandableIconExampleState createState() => _ExpandableIconExampleState();
}

class _ExpandableIconExampleState extends State<ExpandableIconExample>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  Color color = Colors.white;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine the icon color based on iconname
    if (widget.iconname == 'plant_type') {
      color = const Color(0xFF50C878);
    } else if (widget.iconname == 'soil') {
      color = Colors.brown;
    } else if (widget.iconname == 'season') {
      color = Colors.purpleAccent;
    } else if (widget.iconname == 'region') {
      color = Colors.red;
    } else {
      color = Colors.blue;
    }

    // Get screen width to ensure no overflow
    final screenWidth = MediaQuery.of(context).size.width;
    final maxExpandableWidth = screenWidth * 0.5; // Limit max width to 50% of screen width

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerRight, // Align to the right of the screen
        child: GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
              if (_isExpanded) {
                _controller.forward(); // Start rotation animation
              } else {
                _controller.reverse(); // Reverse rotation animation
              }
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 50.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            constraints: BoxConstraints(
              minWidth: 50.0,
              maxWidth: _isExpanded ? maxExpandableWidth : 50.0, // Limit the expansion width
            ),
            child: Row(
              mainAxisAlignment: _isExpanded
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.center,
              children: [
                if (_isExpanded)
                  Flexible( // Ensure text doesn't overflow
                    child: Text(
                      widget.textdata,
                      style: TextStyle(color: color),
                      overflow: TextOverflow.ellipsis, // Prevent overflow of text
                    ),
                  ),
                RotationTransition(
                  turns: _animation,
                  child: Image.asset(
                    'assets/icons/${widget.iconname}.png',
                    fit: BoxFit.contain,
                    height: 30,
                    width: 30,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
