import 'package:flutter/material.dart';

class JoinCircleScreen extends StatelessWidget {
  // بيانات حلقات تجريبية للانضمام
  final List<Map<String, dynamic>> availableCircles = [
    {
      'name': 'حلقة التدبر أ',
      'membersCount': 12,
      'description': 'حلقة مميزة لتدبر القرآن.'
    },
    {
      'name': 'حلقة التدبر ب',
      'membersCount': 9,
      'description': 'حلقة صباحية للتدبر والتأمل.'
    },
    {
      'name': 'حلقة التدبر ج',
      'membersCount': 20,
      'description': 'حلقة تفاعلية مع دروس إضافية.'
    },
  ];

  final Color darkBlue = Color(0xFF001F3F);
  final Color orange = Colors.orange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الانضمام إلى حلقة'),
        backgroundColor: darkBlue,
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: availableCircles.length,
        separatorBuilder: (_, __) => SizedBox(height: 14),
        itemBuilder: (context, index) {
          final circle = availableCircles[index];
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            elevation: 5,
            shadowColor: orange.withOpacity(0.3),
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              title: Text(
                circle['name'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: darkBlue,
                ),
              ),
              subtitle: Text(
                '${circle['membersCount']} أعضاء\n${circle['description']}',
                style: TextStyle(color: Colors.grey[700], height: 1.3),
              ),
              isThreeLine: true,
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text('انضمام'),
                onPressed: () {
                  // هنا تضيف الكود الخاص بالانضمام للحلقة (مثلاً API call)
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('تم الانضمام إلى ${circle['name']}')),
                  );
                  Navigator.pop(context);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
