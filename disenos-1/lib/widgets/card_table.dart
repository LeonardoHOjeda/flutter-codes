import 'dart:ui';

import 'package:flutter/material.dart';

class CardTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: [
            _SingleCard(color: Colors.blue, icon: Icons.calendar_today_outlined, text: 'Calendar',),
            _SingleCard(color: Colors.pinkAccent, icon: Icons.pie_chart_outline, text: 'Analytics',),
          ]
        ),
        TableRow(
          children: [
            _SingleCard(color: Colors.purple, icon: Icons.supervised_user_circle_outlined, text: 'User Settings',),
            _SingleCard(color: Colors.green, icon: Icons.car_rental, text: 'Transport',),
          ]
        ),
        TableRow(
          children: [
            _SingleCard(color: Colors.redAccent, icon: Icons.border_all, text: 'General',),
            _SingleCard(color: Colors.pinkAccent, icon: Icons.car_rental, text: 'Transport',),
          ]
        ),
        TableRow(
          children: [
            _SingleCard(color: Colors.blue, icon: Icons.border_all, text: 'General',),
            _SingleCard(color: Colors.pinkAccent, icon: Icons.car_rental, text: 'Transport',),
          ]
        ),
      ],
    );
  }
}

class _SingleCard extends StatelessWidget {

  final IconData icon;
  final Color color;
  final String text;

  const _SingleCard({
    Key? key, 
    required this.icon, 
    required this.color, 
    required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _CardBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: this.color,
            child: Icon(this.icon, size: 35, color: Colors.white,),
            radius: 30,
          ),
          SizedBox(height: 20),
          Text(this.text, style: TextStyle(color: this.color, fontSize: 15, fontWeight: FontWeight.bold))
        ],
      )
    );
  }
}


class _CardBackground extends StatelessWidget {

  final Widget child;

  const _CardBackground({
    Key? key, 
    required this.child
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            height: 180,
            decoration: BoxDecoration(
              color: Color.fromRGBO(62, 66, 107, 0.7),
              // borderRadius: BorderRadius.circular(20)
            ),
            child: this.child,
          ),
        ),
      ),
    );
  }
}