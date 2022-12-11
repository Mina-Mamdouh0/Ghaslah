import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Privacy extends StatelessWidget {
  const Privacy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: Text("This Statement went into effect on the Last Revised date noted near "
            "the top of this page. This Statement may be updated from time to time."
            " When this is the case, you will be notified of any modifications to this Statement "
            "that might materially affect your rights or the way that we use or disclose your personal"
            " data prior to the change becoming effective by means of a message e.g., on the Website."
            " We encourage you to look for updates"
            " and changes to this Statement by checking the Last Revised date "
              "when you access the Website and Application"

"      3.      Personal Data We Collect"

       " As you use our websites and mobile applications or visit one of our stores, we collect information about you and the services you use. The information we collect falls into three main"
            "  categories: (1) information you voluntarily provide us; (2) information we collect automatically;"
"          and (3) information we collect from other sources"

"    Some examples of when we collect this information include when you browse or make a "
"        purchase on one of our websites or mobile application; create a Starbucks account; use our website or mobile application to purchase, reload or redeem a Starbucks Card; use the order and pay functionality in our mobile applications; or participate in a survey or promotion."

          ),
        )),
    );
  }
}
