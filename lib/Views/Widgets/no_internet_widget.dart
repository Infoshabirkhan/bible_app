import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NoInternetWidget extends StatelessWidget {
  final VoidCallback onRetry;
  const NoInternetWidget({Key? key, required this.onRetry,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 0.3.sh,
        child: Column(
          children: [
            Expanded(
              child: Icon(
                Icons.wifi_off_outlined,
                color: Colors.red,
                size: 80.sp,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        'No Internet Connection\nConnect to Internet \n&',
                        style: GoogleFonts.raleway(
                            fontSize: 18.sp, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onRetry,
                      child: const Text('Try Again'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
