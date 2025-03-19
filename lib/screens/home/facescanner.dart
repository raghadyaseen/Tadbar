import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class FaceScanner extends StatefulWidget {
  const FaceScanner({super.key});

  @override
  State<FaceScanner> createState() => _FaceScannerState();
}

class _FaceScannerState extends State<FaceScanner> {
  String _studentName = '';
  String _studentId = '';
  bool _isScanning = false;
  final ImagePicker _picker = ImagePicker();
  String _capturedFeatures = '';

  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      performanceMode: FaceDetectorMode.fast,
      enableLandmarks: true,
    ),
  );

  final List<Map<String, dynamic>> _data = [
    {
      "st_name": "mohamed abdullah",
      "st_id": 1234567890,
      "face_features":
          "[0.31069609507640067, 0.40635451505016723, 0.6706281833616299, 0.3963210702341137, 0.46519524617996605, 0.6304347826086957, 0.11884550084889643, 0.5585284280936454, 0.8607809847198642, 0.5501672240802675, 0.3633276740237691, 0.7959866220735786, 0.6417657045840407, 0.7909698996655519, 0.3600762116551662]",
    },
    {
      "st_name": "hind khalid",
      "st_id": 1234567891,
      "face_features":
          "[0.308300395256917, 0.3908969210174029, 0.6798418972332015, 0.41633199464524767, 0.4598155467720685, 0.6131191432396251, 0.13438735177865613, 0.5394912985274432, 0.927536231884058, 0.6198125836680054, 0.308300395256917, 0.7376171352074966, 0.6284584980237155, 0.7603748326639893, 0.37238385528850626]",
    },
    {
      "st_name": "ahmed helmey",
      "st_id": 1234567892,
      "face_features":
          "[0.31515499425947185, 0.40932944606413996, 0.6538461538461539, 0.39300291545189503, 0.4965556831228473, 0.6256559766763848, 0.11021814006888633, 0.5854227405247814, 0.9138920780711826, 0.519533527696793, 0.3616532721010333, 0.7615160349854228, 0.6727898966704937, 0.7271137026239067, 0.3390723496565607]",
    },
    {
      "st_name": "baraa",
      "st_id": 1234567893,
      "face_features":
          "[0.3064275037369208, 0.4176470588235294, 0.6666666666666666, 0.4235294117647059, 0.4648729446935725, 0.6735294117647059, 0.1375186846038864, 0.5220588235294118, 0.922272047832586, 0.49411764705882355, 0.34379671150971597, 0.8014705882352942, 0.6517189835575485, 0.8058823529411765, 0.3602887783780906]",
    },
  ];

  Future<void> requestPermissions() async {
    var cameraStatus = await Permission.camera.request();
    if (!cameraStatus.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يجب منح صلاحية الكاميرا للمتابعة'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<XFile?> pickImage() async {
    return await _picker.pickImage(source: ImageSource.camera);
  }

  Future<List<double>?> extractFaceFeatures(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final List<Face> faces = await _faceDetector.processImage(inputImage);

    if (faces.isNotEmpty) {
      final Face face = faces.first;
      final Rect boundingBox = face.boundingBox;
      List<double> features = [];

      final List<FaceLandmarkType> landmarkTypes = [
        FaceLandmarkType.leftEye,
        FaceLandmarkType.rightEye,
        FaceLandmarkType.noseBase,
        FaceLandmarkType.leftEar,
        FaceLandmarkType.rightEar,
        FaceLandmarkType.leftMouth,
        FaceLandmarkType.rightMouth,
      ];

      for (var type in landmarkTypes) {
        var landmark = face.landmarks[type];
        if (landmark != null) {
          double normX =
              (landmark.position.x - boundingBox.left) / boundingBox.width;
          double normY =
              (landmark.position.y - boundingBox.top) / boundingBox.height;
          features.add(normX);
          features.add(normY);
        } else {
          features.add(0.0);
          features.add(0.0);
        }
      }

      if (face.landmarks[FaceLandmarkType.leftEye] != null &&
          face.landmarks[FaceLandmarkType.rightEye] != null) {
        var leftEye = face.landmarks[FaceLandmarkType.leftEye]!;
        var rightEye = face.landmarks[FaceLandmarkType.rightEye]!;
        double eyeDistance = sqrt(
          pow(rightEye.position.x - leftEye.position.x, 2) +
              pow(rightEye.position.y - leftEye.position.y, 2),
        );
        double normEyeDistance = eyeDistance / boundingBox.width;
        features.add(normEyeDistance);
      }

      return features;
    }
    return null;
  }

  Future<void> captureMyFeatures() async {
    await requestPermissions();
    final image = await pickImage();
    if (image != null) {
      final features = await extractFaceFeatures(image);
      if (features != null && features.isNotEmpty) {
        setState(() {
          _capturedFeatures = jsonEncode(features);
        });
      } else {
        setState(() {
          _capturedFeatures = "لم يتم اكتشاف وجه";
        });
      }
    }
  }

  double calculateEuclideanDistance(
    List<double> features1,
    List<double> features2,
  ) {
    if (features1.length != features2.length) return double.infinity;
    double sum = 0;
    for (int i = 0; i < features1.length; i++) {
      sum += pow(features1[i] - features2[i], 2);
    }
    return sqrt(sum);
  }

  Map<String, dynamic>? findMatchingStudent(List<double> capturedFeatures) {
    const double threshold = 0.11;
    for (var student in _data) {
      List<dynamic> storedFeaturesDynamic = jsonDecode(
        student["face_features"],
      );
      List<double> storedFeatures =
          storedFeaturesDynamic.map((e) => (e as num).toDouble()).toList();
      double distance = calculateEuclideanDistance(
        capturedFeatures,
        storedFeatures,
      );

      if (distance < threshold) {
        return student;
      }
    }
    return null;
  }

  Future<void> scanFace() async {
    setState(() {
      _isScanning = true;
      _studentName = '';
      _studentId = '';
    });

    await captureMyFeatures();

    if (_capturedFeatures != "لم يتم اكتشاف وجه" &&
        _capturedFeatures.isNotEmpty) {
      List<double> captured = [];
      try {
        List<dynamic> decoded = jsonDecode(_capturedFeatures);
        captured = decoded.map((e) => (e as num).toDouble()).toList();
      } catch (e) {
        print("خطأ في فك تشفير الميزات: $e");
      }

      Map<String, dynamic>? student = findMatchingStudent(captured);
      if (student != null) {
        setState(() {
          _studentName = student["st_name"];
          _studentId = student["st_id"].toString();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("لا يوجد تطابق للطالب"),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("لم يتم اكتشاف وجه"),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() {
      _isScanning = false;
    });
  }

  @override
  void dispose() {
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "نظام التعرف بالوجه",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[50]!, Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Student Info Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  child: Column(
                    children: [
                      const Icon(Icons.face_retouching_natural,
                          size: 50, color: Colors.blue),
                      const SizedBox(height: 20),
                      _buildInfoRow("الاسم:", _studentName),
                      const SizedBox(height: 10),
                      _buildInfoRow("الرقم الجامعي:", _studentId),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Scan Controls
              if (_isScanning) ...[
                Column(
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 15),
                    Text(
                      "جاري التحقق...",
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                )
              ] else ...[
                Column(
                  children: [
                    _buildActionButton(
                      icon: Icons.camera_alt,
                      label: "التقاط الميزات",
                      onPressed: captureMyFeatures,
                    ),
                    const SizedBox(height: 15),
                    _buildActionButton(
                      icon: Icons.fingerprint,
                      label: "بدء التحقق",
                      onPressed: scanFace,
                    ),
                  ],
                )
              ],

              const SizedBox(height: 25),

              // Features Preview
              if (_capturedFeatures.isNotEmpty)
                Text(
                  "الميزات الملتقطة: ${_capturedFeatures.substring(0, 30)}...",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.blue[900],
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value.isEmpty ? "غير معروف" : value,
            style: TextStyle(
              color: value.isEmpty ? Colors.orange : Colors.green[700],
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity, // يجعل الزر بعرض الحاوية بالكامل
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 28),
        label: Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20), // تكبير الارتفاع
          backgroundColor: Colors.blue[800],
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
