import 'home.dart';
import 'description.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class TourDetailScreen extends StatefulWidget {
  final String tourId;
  
  const TourDetailScreen({required this.tourId, Key? key}) : super(key: key);

  @override
  State<TourDetailScreen> createState() => _TourDetailScreenState();
}

class _TourDetailScreenState extends State<TourDetailScreen> {
  Future<void> _launchWhatsApp() async {
    final whatsappNumber = '+971567530535';
    final message = 'Hello! I\'m interested in booking a desert safari tour.';
    final whatsappUrl = 'https://wa.me/$whatsappNumber?text=${Uri.encodeFull(message)}';
    
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      final fallbackUrl = 'https://api.whatsapp.com/send?phone=$whatsappNumber&text=${Uri.encodeFull(message)}';
      if (await canLaunch(fallbackUrl)) {
        await launch(fallbackUrl);
      } else {
        throw 'Could not launch WhatsApp';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isTablet = MediaQuery.of(context).size.width >= 600 && MediaQuery.of(context).size.width < 900;
    
    final tour = desertSafaris.firstWhere(
      (t) => t["id"] == widget.tourId,
      orElse: () => desertSafaris.first,
    );

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(context, isMobile),
      drawer: isMobile ? _buildDrawer(context) : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroImage(tour, isMobile),
            _buildPriceSection(tour, isMobile),
            _buildDescriptionSection(tour, isMobile),
            _buildInclusionsSection(tour, isMobile, isTablet),
            _buildActionButtons(context, isMobile),
            SizedBox(height: isMobile ? 16 : 20),
            _buildFeaturesSection(isMobile, isTablet),
            SizedBox(height: isMobile ? 24 : 40),
            _buildFooterSection(isMobile),
            SizedBox(height: isMobile ? 24 : 40),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, bool isMobile) {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      title: Text(
        TranslationService.appTitle,
        style: TextStyle(
          color: Colors.white,
          fontSize: isMobile ? 14 : 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: isMobile ? [
        IconButton(
          icon: const Icon(Icons.language, color: Colors.white70),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const LanguageSwitcherDialog(),
            ).then((_) => setState(() {}));
          },
        ),
      ] : [
        TextButton(
          onPressed: () => context.go('/'),
          child: Text(TranslationService.home, 
            style: const TextStyle(color: Colors.white70)
          ),
        ),
        TextButton(
          onPressed: () => context.go('/tour'),
          child: Text(TranslationService.tours, 
            style: const TextStyle(color: Colors.white)
          ),
        ),
        TextButton(
          onPressed: () => context.go('/about'),
          child: Text(TranslationService.about, 
            style: const TextStyle(color: Colors.white70)
          ),
        ),
        TextButton(
          onPressed: () => context.go('/contact'),
          child: Text(TranslationService.contact, 
            style: const TextStyle(color: Colors.white70)
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(TranslationService.faqs, 
            style: const TextStyle(color: Colors.white70)
          ),
        ),
        TextButton(
          onPressed: () => context.go('/book_now'),
          child: Text(TranslationService.bookNow, 
            style: const TextStyle(color: Colors.white)
          ),
        ),
        const SizedBox(width: 20),
        IconButton(
          icon: const Icon(Icons.language, color: Colors.white70), 
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const LanguageSwitcherDialog(),
            ).then((_) => setState(() {}));
          }
        ),
      ],
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.black),
            child: Text(
              TranslationService.appTitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.orange),
            title: Text(TranslationService.home, style: const TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              context.go('/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.tour, color: Colors.orange),
            title: Text(TranslationService.tours, style: const TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              context.go('/tour');
            },
          ),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.orange),
            title: Text(TranslationService.about, style: const TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              context.go('/about');
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_mail, color: Colors.orange),
            title: Text(TranslationService.contact, style: const TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              context.go('/contact');
            },
          ),
          ListTile(
            leading: const Icon(Icons.help, color: Colors.orange),
            title: Text(TranslationService.faqs, style: const TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.book_online, color: Colors.orange),
            title: Text(TranslationService.bookNow, style: const TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              context.go('/book_now');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeroImage(Map<String, dynamic> tour, bool isMobile) {
    return Container(
      height: isMobile ? 250 : 300,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(tour["image"] ?? 'assets/des.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withOpacity(0.8),
              Colors.transparent,
            ],
          ),
        ),
        padding: EdgeInsets.all(isMobile ? 16 : 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tour["title"] ?? "Desert Safari",
              style: TextStyle(
                color: Colors.white,
                fontSize: isMobile ? 24 : 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: isMobile ? 6 : 10),
            Row(
              children: [
                Icon(Icons.schedule, color: Colors.orange, size: isMobile ? 16 : 18),
                SizedBox(width: isMobile ? 6 : 8),
                Flexible(
                  child: Text(
                    "${tour["availability"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 14 : 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceSection(Map<String, dynamic> tour, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 20),
      color: Color(0xFF1a1a1a),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: isMobile ? 12 : 16,
            runSpacing: isMobile ? 8 : 12,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.timer, color: Colors.orange, size: isMobile ? 16 : 18),
                  SizedBox(width: isMobile ? 6 : 8),
                  Text(
                    "${tour["duration"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 14 : 16,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.group, color: Colors.orange, size: isMobile ? 16 : 18),
                  SizedBox(width: isMobile ? 6 : 8),
                  Text(
                    tour["price_type"] ?? "per person",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 14 : 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: isMobile ? 8 : 12),
          Wrap(
            spacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Icon(Icons.attach_money, color: Colors.orange, size: isMobile ? 16 : 18),
              Text(
                "${tour["currency"]} ${tour["price"]}",
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: isMobile ? 18 : 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (tour["group_capacity"] != null)
                Text(
                  "(up to ${tour["group_capacity"]})",
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: isMobile ? 14 : 16,
                  ),
                ),
            ],
          ),
          SizedBox(height: isMobile ? 16 : 20),
          const Divider(color: Colors.grey, thickness: 1, height: 1),
          SizedBox(height: isMobile ? 16 : 20),
          Text(
            "Description & What's Included",
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? 18 : 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection(Map<String, dynamic> tour, bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 20,
        vertical: isMobile ? 12 : 16,
      ),
      color: Color(0xFF1a1a1a),
      child: Text(
        tour["description"] ?? "",
        style: TextStyle(
          color: Colors.grey,
          fontSize: isMobile ? 14 : 16,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildInclusionsSection(Map<String, dynamic> tour, bool isMobile, bool isTablet) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 20,
        vertical: isMobile ? 12 : 16,
      ),
      color: Color(0xFF1a1a1a),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(color: Colors.grey, thickness: 1, height: 20),
          SizedBox(height: isMobile ? 8 : 0),
          ..._buildBulletedInclusions(tour["inclusions"], isMobile, isTablet),
          SizedBox(height: isMobile ? 8 : 0),
          const Divider(color: Colors.grey, thickness: 1, height: 30),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 20),
      color: Color(0xFF1a1a1a),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: isMobile ? 12 : 16,
        runSpacing: isMobile ? 12 : 16,
        children: [
          ElevatedButton(
            onPressed: () {
              context.go('/book_now');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 32,
                vertical: isMobile ? 12 : 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              TranslationService.bookNow,
              style: TextStyle(
                color: Colors.black,
                fontSize: isMobile ? 14 : 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          OutlinedButton(
            onPressed: () {
              _launchWhatsApp();
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.orange),
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 32,
                vertical: isMobile ? 12 : 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              TranslationService.whatsappButton,
              style: TextStyle(
                color: Colors.orange,
                fontSize: isMobile ? 14 : 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection(bool isMobile, bool isTablet) {
    return Directionality(
      textDirection: LanguageManager.isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 20),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(isMobile ? 16 : 24),
          decoration: BoxDecoration(
            color: const Color(0xFF1a1a1a),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: isMobile ? 1 : 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: isMobile ? 4 : 2.5,
                children: AppData.featureItems.map((feature) {
                  return _buildFeatureItem(feature.title, feature.description, isMobile);
                }).toList(),
              ),
              
              SizedBox(height: isMobile ? 20 : 30),
              const Divider(color: Colors.grey),
              SizedBox(height: isMobile ? 20 : 30),
              
              Text(
                TranslationService.whatGuestsSay,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isMobile ? 20 : 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: isMobile ? 12 : 20),
              ...AppData.testimonials.map((testimonial) {
                return Column(
                  children: [
                    _buildTestimonial(testimonial.text, testimonial.author, isMobile),
                    if (AppData.testimonials.indexOf(testimonial) < AppData.testimonials.length - 1) 
                      SizedBox(height: isMobile ? 12 : 16),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooterSection(bool isMobile) {
    return Directionality(
      textDirection: LanguageManager.isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 20),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(isMobile ? 16 : 24),
          decoration: BoxDecoration(
            color: const Color(0xFF1a1a1a),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TranslationService.aboutUs,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isMobile ? 18 : 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: isMobile ? 8 : 12),
              Text(
                TranslationService.aboutUsDescription,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: isMobile ? 14 : 16,
                ),
              ),
              SizedBox(height: isMobile ? 12 : 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${TranslationService.phoneLabel} ${AppData.phoneNumber}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 14 : 16,
                    ),
                  ),
                  SizedBox(height: isMobile ? 6 : 8),
                  Text(
                    '${TranslationService.emailLabel} ${AppData.email}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 14 : 16,
                    ),
                  ),
                  SizedBox(height: isMobile ? 6 : 8),
                  Text(
                    AppData.address,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 14 : 16,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: isMobile ? 20 : 30),
              const Divider(color: Colors.grey),
              SizedBox(height: isMobile ? 20 : 30),
              
              Text(
                TranslationService.siteLinks,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isMobile ? 18 : 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: isMobile ? 12 : 16),
              Text(
                AppData.vatInfo,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: isMobile ? 12 : 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBulletedInclusions(List<dynamic> inclusions, bool isMobile, bool isTablet) {
    List<Widget> widgets = [];
    
    if (isMobile) {
      // Single column on mobile
      for (var inclusion in inclusions) {
        widgets.add(_buildBulletItem(inclusion.toString(), isMobile));
        if (inclusion != inclusions.last) {
          widgets.add(const SizedBox(height: 8));
        }
      }
    } else {
      // Two columns on tablet/desktop
      for (int i = 0; i < inclusions.length; i += 2) {
        widgets.add(
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildBulletItem(inclusions[i].toString(), isMobile),
              ),
              if (i + 1 < inclusions.length)
                Expanded(
                  child: _buildBulletItem(inclusions[i + 1].toString(), isMobile),
                ),
            ],
          ),
        );
        
        if (i + 1 < inclusions.length) {
          widgets.add(const SizedBox(height: 12));
        }
      }
    }
    
    return widgets;
  }

  Widget _buildBulletItem(String text, bool isMobile) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: isMobile ? 5 : 6, right: isMobile ? 6 : 8),
          width: isMobile ? 5 : 6,
          height: isMobile ? 5 : 6,
          decoration: BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey,
              fontSize: isMobile ? 14 : 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureItem(String title, String description, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.orange,
            fontSize: isMobile ? 12 : 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(
            color: Colors.white,
            fontSize: isMobile ? 13 : 16,
          ),
        ),
      ],
    );
  }

  Widget _buildTestimonial(String text, String author, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 12 : 16),
      decoration: BoxDecoration(
        color: const Color(0xFF2a2a2a),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '"$text"',
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? 14 : 16,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: isMobile ? 6 : 8),
          Text(
            '— $author',
            style: TextStyle(
              color: Colors.orange,
              fontSize: isMobile ? 12 : 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}