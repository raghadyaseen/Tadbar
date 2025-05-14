import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      'title': 'حلقة جديدة',
      'body': 'تم إنشاء حلقة تدبر جديدة بنجاح',
      'date': '14 مايو 2025',
    },
    {
      'title': 'تذكير',
      'body': 'لا تنسى حضور الحلقة اليوم الساعة 8 مساءً',
      'date': '13 مايو 2025',
    },
  ];

  final Color darkBlue = Color(0xFF001F3F);
  final Color lightGray = Color(0xFFF7F9FC);
  final Color cardWhite = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGray,
      appBar: AppBar(
        backgroundColor: cardWhite,
        elevation: 2,
        centerTitle: true,
        iconTheme: IconThemeData(color: darkBlue),
        title: Text(
          'الإشعارات',
          style: TextStyle(
            color: darkBlue,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 0.5,
          ),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        itemCount: notifications.length,
        separatorBuilder: (context, index) => SizedBox(height: 14),
        itemBuilder: (context, index) {
          final notif = notifications[index];
          return Material(
            color: cardWhite,
            borderRadius: BorderRadius.circular(14),
            elevation: 5,
            shadowColor: darkBlue.withOpacity(0.15),
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              splashColor: darkBlue.withOpacity(0.1),
              highlightColor: Colors.transparent,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(
                      notif['title'] ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: darkBlue,
                      ),
                    ),
                    content: Text(
                      notif['body'] ?? '',
                      style: TextStyle(fontSize: 16),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'إغلاق',
                          style: TextStyle(
                            color: darkBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 22),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: darkBlue.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(12),
                      child:
                          Icon(Icons.notifications, color: darkBlue, size: 32),
                    ),
                    SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notif['title'] ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: darkBlue,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            notif['body'] ?? '',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                      notif['date'] ?? '',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
