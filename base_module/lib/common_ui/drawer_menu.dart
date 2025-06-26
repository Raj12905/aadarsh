import 'dart:ui';

import 'package:flutter/material.dart';

Widget buildDrawerHeader(String? args1, String? args2) {
  return UserAccountsDrawerHeader(
    accountName: Padding(
      padding: EdgeInsets.only(top: 24),
      child: Text(
        args2 ?? '',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    accountEmail: Text(args1 ?? ''),
    currentAccountPicture: CircleAvatar(
      backgroundColor: Colors.white,
      child: Text(
        args2?.isNotEmpty == true ? args2![0] ?? '' : '',
        style: const TextStyle(fontSize: 40.0),
      ),
    ),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFAD1DEB), Color(0xFF6E72FC), Color(0xFF0892d0)],
        begin: Alignment.topLeft,
        end: Alignment.bottomCenter,
      ),
    ),
  );
}

Widget buildDrawer(
    String args1, String? args2, Function(String id) onItemClick) {
  return Drawer(
    child: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFAD1DEB), Color(0xFF6E72FC), Color(0xFF0892d0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildDrawerHeader(args1, args2),
          _buildDrawerItem(
            icon: Icons.dark_mode,
            text: 'Dark Theme',
            onTap: () {
              // Handle dark theme toggle
            },
          ),
          _buildDrawerItem(
            icon: Icons.account_circle,
            text: 'My Account',
            onTap: () {
              // Handle My Account navigation
            },
          ),
          _buildDrawerItem(
            icon: Icons.dashboard,
            text: 'RTC Platform',
            onTap: () {
              // Handle RTC Platform navigation
            },
          ),
          _buildDrawerItem(
            icon: Icons.settings,
            text: 'Settings',
            onTap: () {
              // Handle settings navigation
            },
          ),
          _buildDrawerItem(
            icon: Icons.logout,
            text: 'Sign out',
            onTap: () {
              onItemClick('signout');
            },
          ),
        ],
      ),
    ),
  );
}

Widget _buildDrawerItem({
  required IconData icon,
  required String text,
  GestureTapCallback? onTap,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15), // Rounded corners
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Apply blur
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            // Glass effect background
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.white.withOpacity(0.3), // Slight white border
              width: 1,
            ),
          ),
          child: ListTile(
            leading: Icon(icon, color: Colors.white70),
            title: Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white, // White text for glass effect
              ),
            ),
            onTap: onTap,
          ),
        ),
      ),
    ),
  );
}
