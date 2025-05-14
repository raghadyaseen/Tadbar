import 'package:flutter/material.dart';

class CreateCircleScreen extends StatefulWidget {
  @override
  _CreateCircleScreenState createState() => _CreateCircleScreenState();
}

class _CreateCircleScreenState extends State<CreateCircleScreen> {
  final TextEditingController _circleNameController = TextEditingController();
  final TextEditingController _membersCountController = TextEditingController();

  String selectedTaskType = 'صور';
  final List<String> taskTypes = ['صور', 'صفحات', 'أجزاء'];

  final Color darkBlue = Color(0xFF001F3F);
  final Color orange = Colors.orange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: darkBlue,
        elevation: 0,
        title: Text(
          'إنشاء حلقة تدبر',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildLabeledField(
                label: 'اسم الحلقة',
                controller: _circleNameController,
                icon: Icons.edit_note,
              ),
              SizedBox(height: 20),
              _buildLabeledField(
                label: 'عدد الأعضاء',
                controller: _membersCountController,
                icon: Icons.people,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              Text(
                'طريقة التوزيع',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: darkBlue,
                ),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedTaskType,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.category, color: darkBlue),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: taskTypes
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedTaskType = value!;
                  });
                },
              ),
              SizedBox(height: 30),
              ElevatedButton.icon(
                icon: Icon(Icons.add_circle_outline),
                label: Text(
                  'إنشاء الحلقة',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  final name = _circleNameController.text;
                  final count = _membersCountController.text;
                  final method = selectedTaskType;

                  print('إنشاء حلقة: $name، عدد: $count، توزيع: $method');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('تم إنشاء الحلقة بنجاح!')),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: orange,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabeledField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: darkBlue),
        ),
        SizedBox(height: 10),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(icon, color: darkBlue),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}
