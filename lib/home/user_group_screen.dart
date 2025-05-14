import 'package:flutter/material.dart';

class UserGroupsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> memberGroups = [
    {'name': 'حلقة التدبر 3', 'membersCount': 15},
    {'name': 'حلقة التدبر 4', 'membersCount': 7},
  ];

  final Color darkBlue = Color(0xFF001F3F);
  final Color orange = Colors.orange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: memberGroups.length,
        itemBuilder: (context, index) {
          final group = memberGroups[index];
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: Icon(Icons.group, color: orange),
              title: Text(group['name']),
              trailing: Text(
                '${group['membersCount']} أعضاء',
                style: TextStyle(color: Colors.grey[700]),
              ),
              onTap: () {
                // تفاصيل الحلقة (اختياري)
              },
            ),
          );
        },
      ),
    );
  }
}
