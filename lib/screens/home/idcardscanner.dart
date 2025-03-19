import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class IdCardScanner extends StatefulWidget {
  const IdCardScanner({super.key});

  @override
  State<IdCardScanner> createState() => _IdCardScannerState();
}

class _IdCardScannerState extends State<IdCardScanner> {
  String _nid = '';
  bool _isScanning = false;
  final ImagePicker _picker = ImagePicker();

  Future<void> requestPermissions() async {
    var cameraStatus = await Permission.camera.request();
    var storageStatus = await Permission.storage.request();

    if (!cameraStatus.isGranted || !storageStatus.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يجب منح صلاحيات الكاميرا والتخزين للمتابعة'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<XFile?> pickImage() async {
    return await _picker.pickImage(source: ImageSource.camera);
  }

  Future<String> extractText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.textRecognizer();
    final RecognizedText recognizedText =
        await textDetector.processImage(inputImage);
    String text = recognizedText.blocks.map((block) => block.text).join('\n');
    textDetector.close();
    return text;
  }

  String getNID(String extractedText) {
    RegExp nidRegex = RegExp(r'\d{10}');
    return nidRegex.firstMatch(extractedText)?.group(0) ??
        "لم يتم العثور على الرقم الوطني";
  }

  Future<void> scanId() async {
    setState(() {
      _isScanning = true;
      _nid = '';
    });

    await requestPermissions();
    final XFile? image = await pickImage();

    if (image != null) {
      try {
        String extractedText = await extractText(image);
        setState(() => _nid = getNID(extractedText));
      } catch (e) {
        setState(() => _nid = "خطأ في قراءة البطاقة");
      }
    }

    setState(() => _isScanning = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "الماسح الضوئي للبطاقة الشخصية",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[50]!, Colors.white],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Result Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  child: Column(
                    children: [
                      const Icon(Icons.fingerprint,
                          size: 40, color: Colors.blue),
                      const SizedBox(height: 15),
                      Text(
                        _nid.isEmpty ? 'سيظهر معلومات الطالب هنا' : _nid,
                        style: TextStyle(
                          fontSize: 20,
                          color: _nid.isEmpty ? Colors.grey : Colors.blue[900],
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Conditional Scanning Widget
              _isScanning
                  ? Column(
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 15),
                        Text(
                          'جاري المسح...',
                          style: TextStyle(
                            color: Colors.blue[800],
                            fontSize: 16,
                          ),
                        )
                      ],
                    )
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.camera_alt,
                            size: 28, color: Colors.white),
                        label: const Text(
                          'مسح البطاقة',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          backgroundColor: Colors.blue[800],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          elevation: 4,
                        ),
                        onPressed: scanId,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
