import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final learntController = TextEditingController();
  final implementController = TextEditingController();
  final impactController = TextEditingController();

  final outputController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 700, height: 900,
          child: Column(
            children: [
              _title(),
              Container(
                width: 700, height: 800,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 250, 250, 250),
                  border: Border.all(color: const Color.fromARGB(255, 211, 211, 211)),
                  borderRadius: BorderRadius.circular(4)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _textField("what did you learn?", learntController, screen, 140),
                    _textField("how will you implement this in your job?", implementController, screen, 140),
                    _textField("what impact will this have on your job?", impactController, screen, 140),

                    Tooltip(
                      message: "click here to ethically generate a completely authentic and very legitimate paraphrased text",
                      child: _button("generate", () {
                        setState(() {
                          outputController.text = "Hello World!";
                        });
                      }),
                    ),

                    Stack(
                      children: [
                        _textField("emptiness...", outputController, screen, 320),

                        Positioned(
                          right: 24,
                          top: 24,
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                Clipboard.setData(ClipboardData(text: outputController.text));
                              },
                              child: const Tooltip(
                                message: "BAM! COPY THAT",
                                child: Icon(
                                  Icons.copy,
                                  color: Colors.grey,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _button(String text, VoidCallback onClick) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onClick,
          child: Container(
            width: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.grey),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Center(
                child: !isLoading
                  ? Text(
                      text,
                      style: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14,
                        fontWeight: FontWeight.w100,
                        color: Colors.black,
                      ),
                    )
                  : const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                    child: SpinKitThreeBounce(
                        color: Colors.grey,
                        size: 12,
                      ),
                  ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _textField(String hintText, TextEditingController controller, Size screen, double height) {
    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: TextField(
          controller: controller,
          expands: true,
          maxLines: null,
          textAlignVertical: TextAlignVertical.top,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontFamily: "Inter",
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.w300
            ),
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
    );
  }

  Widget _title() {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "TwoFile",
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 40,
            fontWeight: FontWeight.w700
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 8, left: 8),
          child: Text(
            "because one wasn't enough",
            style: TextStyle(
              fontFamily: "Inter",
              fontSize: 16,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.italic,
              color: Colors.grey
            ),
          ),
        )
      ],
    );
  }
}