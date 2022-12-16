import 'package:civil_defense_app/pages/public/home.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperProfileSection extends StatelessWidget {
  final String photoPath;
  final String name;
  final String description;
  final String phoneNumber;
  final String telegramUrl;

  const DeveloperProfileSection(
      {super.key,
      required this.name,
      required this.description,
      required this.phoneNumber,
      required this.telegramUrl,
      required this.photoPath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: [
            Text(name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Image(
              image: AssetImage(photoPath),
              height: 200,
            ),
            SizedBox(height: 20),
            Text(description),
            SizedBox(height: 10),
            IconButton(
              onPressed: () async {
                Uri uri = Uri.parse(telegramUrl);
                if (!await launchUrl(uri,
                    mode: LaunchMode.externalApplication)) {
                  throw 'Could not launch $uri';
                }
              },
              icon: const Icon(Icons.telegram),
            ),
            SizedBox(height: 10),
            IconButton(
              onPressed: () async {
                Uri uri = Uri.parse('tel:$phoneNumber');
                if (!await launchUrl(uri)) {
                  throw 'Could not launch $uri';
                }
              },
              icon: const Icon(Icons.phone),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sobre nosotros'),
          backgroundColor: Color(0xfffd6c00),
        ),
        drawer: DrawerWithoutLogin(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: const [
              Text(
                'Desarrolladores',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              DeveloperProfileSection(
                  photoPath: 'assets/images/photo_profile_d1.jpg',
                  name: 'Pedro Procter',
                  description:
                      """Lorem Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.""",
                  phoneNumber: '+18299386415',
                  telegramUrl: 'https://telegram.me/pedroprocter'),
              DeveloperProfileSection(
                  photoPath: 'assets/images/photo_profile_d2.jpeg',
                  name: 'Miguel Higuera',
                  description:
                      """Lorem Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.""",
                  phoneNumber: '+18092495784',
                  telegramUrl: 'https://telegram.me/miguelhiguera'),
            ],
          ),
        ),
      ),
    );
  }
}
