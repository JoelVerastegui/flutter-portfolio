import 'dart:async';

import 'package:my_portfolio/config/constants/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class ContactView extends StatelessWidget {

  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: size.height,
      ),
      child: Container(
        width: size.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/mt-fuji.jpeg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.srcOver),
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 15.0,
          children: [

            Text(
              '¿Tienes algo en mente?', 
              style: textStyle.displayMedium?.copyWith(color: AppColors.blank)
            ),

            Text(
              'Envíame un mensaje en LinkedIn o un correo directo y conversemos sobre tu proyecto.', 
              style: textStyle.headlineSmall?.copyWith(color: AppColors.blank)
            ),

            _ContactButtons(),

          ],
        ),
      ),
    );
  }

}

class _ContactButtons extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 15.0,
      children: [

        FilledButton.icon(
          onPressed: () => launch(
            'https://www.linkedin.com/in/joelverastegui/',
          ),
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Color(0xFF007AB5)),
          ),
          label: Text('LinkedIn', style: textStyle.titleMedium?.copyWith(color: AppColors.blank)),
          icon: SvgPicture.asset(
            'assets/icons/linkedin.svg',
            width: 30.0,
            height: 30.0,
            colorMapper: _LinkedinColorMapper(),
          ),
        ),

        _EmailButton(),

      ],
    );
  }

  Future<void> launch(String url, {bool isNewTab = true}) async {
    await launchUrl(
      Uri.parse(url),
      webOnlyWindowName: isNewTab ? '_blank' : '_self',
    );
  }

}

class _LinkedinColorMapper extends ColorMapper {

  @override
  Color substitute(String? id, String elementName, String attributeName, Color color) {
    if (color == const Color(0xFFE8EAED)) {
      return Colors.transparent;
    }

    if (color == const Color(0xFF272822)) {
      return Color(0xFFE8EAED);
    }

    return color;
  }

}

class _EmailButton extends StatefulWidget {

  @override
  State<_EmailButton> createState() => _EmailButtonState();

}

class _EmailButtonState extends State<_EmailButton> {

  bool isCopied = false;
  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(20.0),
      child: MaterialButton(
        onPressed: () {},
        padding: EdgeInsets.zero,
        color: AppColors.dark,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
                          
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 15.0, vertical: 4.0),
              child: Row(
                spacing: 10.0,
                children: [
              
                  Icon(Icons.email_outlined, color: AppColors.blank),
                            
                  Text('Enviar correo', style: textStyle.titleMedium?.copyWith(color: AppColors.blank)),
              
                ],
              ),
            ),
        
            Container(
              width: 2.0,
              height: 20.0,
              color: AppColors.blank,
            ),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: isCopied
                ? _CopyButton(
                  key: ValueKey<bool>(true),
                  icon: Icons.check,
                  iconColor: AppColors.dark,
                  bgColor: Colors.lightGreen,
                )
                : _CopyButton(
                  key: ValueKey<bool>(false),
                  icon: Icons.copy_outlined,
                  iconColor: AppColors.blank,
                  bgColor: Colors.transparent,
                  onPressed: () => copyEmail(context),
                ),
            ),
                          
          ],
        ),
      ),
    );
  }

  Future<void> copyEmail(BuildContext context) async {
    if (isCopied) return;

    setState(() => isCopied = true);

    await Clipboard.setData(ClipboardData(text: "jverasteguixyz@gmail.com"));

    if (!context.mounted) return;

    showSnackbar(context, 'Correo copiado!');

    timer?.cancel();

    timer = Timer(
      const Duration(seconds: 2), 
      () => setState(() => isCopied = false),
    );
  }

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, textAlign: TextAlign.center,),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Future<void> _launchMailto() async {
  //   final Uri emailLaunchUri = Uri(
  //     scheme: 'mailto',
  //     path: 'example@example.com',
  //     queryParameters: {
  //       'subject': 'Example Subject', // Email subject
  //       'body': 'Example Body' // Email body
  //     },
  //   );

  //   // Check if the URL can be launched and then launch it
  //   if (!await launchUrl(emailLaunchUri)) {
  //     // Handle error: e.g., show a snackbar or log an error message
  //     throw Exception('Could not launch $emailLaunchUri');
  //   }
  // }

}

class _CopyButton extends StatelessWidget {

  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final Function()? onPressed;

  const _CopyButton({
    super.key,
    required this.icon, 
    required this.iconColor, 
    required this.bgColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed ?? () {},
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      iconSize: 20.0,
      icon: Icon(icon, color: iconColor),
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(bgColor),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            )
          ),
        )
      )
    );
  }
  
}