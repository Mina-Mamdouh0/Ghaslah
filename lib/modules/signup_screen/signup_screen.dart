import 'package:flutter/cupertino.dart';

import '../../shared/colors.dart';
import '../../shared/compoents/components.dart';
import '../../shared/compoents/responsive.dart';
import 'compontens/signup_form.dart';
import 'compontens/signup_screen_top_image.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Responsive(
        mobile: const MobileSignupScreen(),
        desktop: Row(
          children: [
            const Expanded(
              child: SignUpScreenTopImage(),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  const [
                  SizedBox(
                    width: 450,
                    child: SignUpForm(),
                  ),
                  SizedBox(height: defaultPadding / 2),
                  // SocalSignUp()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MobileSignupScreen extends StatelessWidget {
  const MobileSignupScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SignUpScreenTopImage(),
        Row(
          children:  [
            const Spacer(),
            Expanded(
              flex: 8,
              child: SignUpForm(),
            ),
            const Spacer(),
          ],
        ),
        // const SocalSignUp()
      ],
    );
  }

}
