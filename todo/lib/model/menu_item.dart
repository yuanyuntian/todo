import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final IconData icon;

  const MenuItem(this.title, this.icon);
}

const List<MenuItem> choices = <MenuItem>[
  MenuItem('Privacy Policy', Icons.vpn_key)
];
