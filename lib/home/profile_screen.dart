import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  final String userName = 'Deyaa';
  final String userEmail = 'deyaa@example.com';

  final List<Map<String, dynamic>> adminGroups = [
    {'name': 'حلقة التدبر 1', 'membersCount': 10},
    {'name': 'حلقة التدبر 2', 'membersCount': 8},
  ];

  final List<Map<String, dynamic>> memberGroups = [
    {'name': 'حلقة التدبر 3', 'membersCount': 15},
    {'name': 'حلقة التدبر 4', 'membersCount': 7},
  ];

  final Color darkBlue = Color(0xFF001F3F);
  final Color orange = Colors.orange;

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildGroupCard(Map<String, dynamic> group, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
      shadowColor: orange.withOpacity(0.4),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: orange.withOpacity(0.2),
          child: Icon(icon, color: orange, size: 28),
        ),
        title: Text(
          group['name'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: darkBlue,
          ),
        ),
        trailing: Text(
          '${group['membersCount']} أعضاء',
          style: TextStyle(
            fontSize: 14,
            color: darkBlue.withOpacity(0.6),
            fontWeight: FontWeight.w600,
          ),
        ),
        onTap: () {
          // TODO: تفاصيل الحلقة
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Scaffold(
        backgroundColor: Color(0xFFF6F9FF),
        appBar: AppBar(
          backgroundColor: darkBlue,
          title: Text(
            'الملف الشخصي',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24,
              letterSpacing: 1,
            ),
          ),
          centerTitle: true,
          elevation: 6,
          shadowColor: orange.withOpacity(0.6),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: orange.withOpacity(0.3),
                      blurRadius: 18,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/profile.jpg'),
                  backgroundColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 14),
              Text(
                userName,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: darkBlue,
                ),
              ),
              SizedBox(height: 6),
              Text(
                userEmail,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: darkBlue.withOpacity(0.7),
                  letterSpacing: 0.4,
                ),
              ),
              SizedBox(height: 30),

              // الحلقات كمسؤول
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'الحلقات التي تديرها',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: darkBlue.withOpacity(0.8),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: adminGroups.length,
                  itemBuilder: (context, index) {
                    return buildGroupCard(
                        adminGroups[index], Icons.admin_panel_settings);
                  },
                ),
              ),
              SizedBox(height: 20),

              // الحلقات كعضو
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'الحلقات التي تنضم إليها',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: darkBlue.withOpacity(0.8),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: memberGroups.length,
                  itemBuilder: (context, index) {
                    return buildGroupCard(memberGroups[index], Icons.group);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
