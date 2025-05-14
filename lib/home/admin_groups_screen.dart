import 'package:flutter/material.dart';

class AdminGroupsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> adminGroups = [
    {'name': 'حلقة التدبر 1', 'membersCount': 10},
    {'name': 'حلقة التدبر 2', 'membersCount': 8},
  ];

  final Color darkBlue = Color(0xFF001F3F);
  final Color orange = Colors.orange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: adminGroups.length,
        itemBuilder: (context, index) {
          final group = adminGroups[index];
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: Icon(Icons.admin_panel_settings, color: orange),
              title: Text(group['name']),
              trailing: Text(
                '${group['membersCount']} أعضاء',
                style: TextStyle(color: Colors.grey[700]),
              ),
              onTap: () {
                // تفاصيل المجموعة (اختياري)
              },
            ),
          );
        },
      ),
    );
  }
}
