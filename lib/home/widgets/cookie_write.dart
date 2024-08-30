import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twofile/services/onefile.dart';

class CookieWrite extends StatefulWidget {
  const CookieWrite({super.key});

  @override
  State<CookieWrite> createState() => _CookieWriteState();
}

class _CookieWriteState extends State<CookieWrite> {
  final _onefile = OneFileAPI();

  final _controller = TextEditingController();

  bool isWriting = false;
  bool isWriteSuccess = false;
  bool showInfoIcon = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      width: 420,
      height: 124,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Put your OneFile Cookie in here and it will be written to local storage.",
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () async {
                    await writeCookie();
                  },
                  icon: _writeIcon(),
                ),
                hintText: "cookie here..",
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _writeIcon() {
    if (isWriting) {
      return const SpinKitThreeBounce(color: Colors.grey, size: 20);
    } else if (isWriteSuccess) {
      return const Icon(Icons.check, color: Colors.green);
    } else if (!isWriteSuccess && !showInfoIcon) {
      return const Icon(Icons.close, color: Colors.red);
    } else {
      return const Icon(Icons.info, color: Colors.grey);
    }
  }

  Future<void> writeCookie() async {
    setState(() {
      isWriting = true;
      showInfoIcon = false;
    });

    await Future.delayed(const Duration(seconds: 1));

    final prefs = await SharedPreferences.getInstance();
    final writeSuccess = await prefs.setString('OneFile-Cookie', _controller.text);

    var results = await _onefile.getJournalEntries();

    setState(() {
      isWriting = false;
      isWriteSuccess = writeSuccess;
      showInfoIcon = false;
    });
  }
}
