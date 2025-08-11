import 'package:calley_app/features/services/shared_preferences.dart';
import 'package:flutter/material.dart';

import '../../auth/screen/signup_screen.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  _LanguageSelectionScreenState createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String _selectedLanguage = 'English';
  final LanguagePreference languagePreference = LanguagePreference();


  final List<Map<String, String>> _languages = [
    {'name': 'English', 'greeting': 'Hi', 'code': 'en'},
    {'name': 'Hindi', 'greeting': 'नमस्ते', 'code': 'hi'},
    {'name': 'Bengali', 'greeting': 'হ্যালো', 'code': 'bn'},
    {'name': 'Kannada', 'greeting': 'ನಮಸ್ಕಾರ', 'code': 'kn'},
    {'name': 'Punjabi', 'greeting': 'ਸਤ ਸ੍ਰੀ ਅਕਾਲ', 'code': 'pa'},
    {'name': 'Tamil', 'greeting': 'வணக்கம்', 'code': 'ta'},
    {'name': 'Telugu', 'greeting': 'హాయ్', 'code': 'te'},
    {'name': 'French', 'greeting': 'Bonjour', 'code': 'fr'},
    {'name': 'Spanish', 'greeting': 'Hola', 'code': 'es'},
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0, // Hides app bar space
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Choose Your Language',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.black12),
                ),
                child: ListView.builder(
                  itemCount: _languages.length,
                  itemBuilder: (context, index) {
                    final lang = _languages[index];
                    return RadioListTile<String>(
                      title: Text(lang['name']!),
                      subtitle: Text(lang['greeting']!),
                      value: lang['name']!,
                      groupValue: _selectedLanguage,
                      onChanged: (value) {
                        setState(() {
                          _selectedLanguage = value!;
                        });
                      },
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2962FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  for (var lang in _languages) {
                    if (lang['name'] == _selectedLanguage) {
                      await languagePreference.setLanguageCode(lang['code']!);
                      print('Saved: ${lang['code']}');
                      break;
                    }
                  }

                  // Restart the app with new language
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const SignupScreen()),
                        (route) => false,
                  );
                },
                child: const Text(
                  'Select',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
