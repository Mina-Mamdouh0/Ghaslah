import 'package:flutter/cupertino.dart';

import '../../../shared/colors.dart';

class SignUpScreenTopImage extends StatelessWidget {
  const SignUpScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Sign Up".toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: defaultPadding),
        Row(
          children: const [
            Spacer(),
            /*Expanded(
              flex: 8,
              child: SvgPicture.asset("assets/icons/signup.svg"),
            ),*/
            Spacer(),
          ],
        ),
        SizedBox(height: defaultPadding),
      ],
    );
  }
}
