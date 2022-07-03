import 'package:airplane/cubit/auth_cubit.dart';
import 'package:airplane/cubit/page_cubit.dart';
import 'package:airplane/shared/theme.dart';
import 'package:airplane/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: kRedColor,
              content: Text(state.error),
            ),
          );
        } else if (state is AuthInitial) {
          context.read<PageCubit>().setPage(0);
          Navigator.pushNamedAndRemoveUntil(
              context, '/sign-in', (route) => false);
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        // return Center(
        //   child: CustomButton(
        //     title: 'Sign Out',
        //     onPressed: () {
        //       context.read<AuthCubit>().signOut();
        //     },
        //     width: 220,
        //   ),
        // );
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 328,
            ),
            child: Column(
              children: [
                CustomButton(
                  title: 'Sign Out',
                  onPressed: () {
                    context.read<AuthCubit>().signOut();
                  },
                  width: 220,
                ),
                helpButton()
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget helpButton() {
  return Center(
    child: Container(
      width: 220,
      height: 55,
      margin: EdgeInsets.only(top: 10),
      child: TextButton(
        onPressed:  () {
          launchUrl(
            Uri.parse('https://versed-handstand-1c4.notion.site/Help-5906aa13ae174fd29565004ba8909e26')
          );
          
        },
        style: TextButton.styleFrom(
          backgroundColor: kAvailableColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              defaultRadius,
            ),
          ),
        ),
        child: Text(
          'Help',
          style: purpleTextStyle.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
      ),
    ),
  );
}
// _launchURL(String url) async {
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

// Widget helpBtn() {
//   return Center(
//     child: Container(
//       width: 220,
//       height: 55,
//       decoration: BoxDecoration(
//         color: kBackgroundColor,
//         border: Border.all(
//           color: kPrimaryColor,
//           width: 2.0,
//           style: BorderStyle.solid,
//         ),
//         borderRadius: BorderRadius.circular(
//           defaultRadius,
//         ),
//       ),
//       child: Center(
//         child: Text(
//           'Help',
//           style: purpleTextStyle.copyWith(
//             fontSize: 18,
//             fontWeight: semiBold,
//           ),
//         ),
//       ),
//     ),
//   );
// }
