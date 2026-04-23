import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ==================== LANGUAGE ENUMS & MANAGER ====================
enum AppLanguage { english, arabic }

class LanguageManager {
  static AppLanguage currentLanguage = AppLanguage.english;
  
  static void switchLanguage(AppLanguage newLanguage) {
    currentLanguage = newLanguage;
  }
  
  static bool get isEnglish => currentLanguage == AppLanguage.english;
  static bool get isArabic => currentLanguage == AppLanguage.arabic;
}

// ==================== TRANSLATION SERVICE ====================
class TranslationService {
  // Navigation items
  static String get home => LanguageManager.isEnglish ? 'Home' : 'الرئيسية';
  static String get tours => LanguageManager.isEnglish ? 'Tours' : 'الجولات';
  static String get about => LanguageManager.isEnglish ? 'About' : 'عنا';
  static String get contact => LanguageManager.isEnglish ? 'Contact' : 'اتصل بنا';
  static String get faqs => LanguageManager.isEnglish ? 'FAQs' : 'الأسئلة الشائعة';
  static String get bookNow => LanguageManager.isEnglish ? 'Book Now' : 'احجز الآن';
  
  // App title
  static String get appTitle => LanguageManager.isEnglish 
      ? 'Abu Dhabi Desert Safari Adventures'
      : 'مغامرات سفاري صحراء أبوظبي';
  
  // Common strings
  static String get viewDetails => LanguageManager.isEnglish ? 'View details →' : 'عرض التفاصيل →';
  static String get perPerson => LanguageManager.isEnglish ? 'Per person' : 'لكل شخص';
  static String get perGroupUpTo2 => LanguageManager.isEnglish ? 'Per group (up to 2)' : 'لكل مجموعة (حتى 2)';
  static String get perGroupUpTo4 => LanguageManager.isEnglish ? 'Per group (up to 4)' : 'لكل مجموعة (حتى 4)';
  static String get perGroupUpTo6 => LanguageManager.isEnglish ? 'Per group (up to 6)' : 'لكل مجموعة (حتى 6)';
  
  // Section titles
  static String get duration => LanguageManager.isEnglish ? 'DURATION' : 'المدة';
  static String get bookNowSection => LanguageManager.isEnglish ? 'Book Now' : 'احجز الآن';
  static String get whatGuestsSay => LanguageManager.isEnglish ? 'What Guests Say' : 'ما يقوله الضيوف';
  static String get planYourExperience => LanguageManager.isEnglish 
      ? 'Plan your desert experience today' 
      : 'خطط لتجربتك الصحراوية اليوم';
  static String get aboutUs => LanguageManager.isEnglish ? 'About us' : 'من نحن';
  static String get siteLinks => LanguageManager.isEnglish ? 'Site links' : 'روابط الموقع';
  
  // Buttons
  static String get contactButton => LanguageManager.isEnglish ? 'Contact' : 'اتصل';
  static String get whatsappButton => LanguageManager.isEnglish ? 'WhatsApp' : 'واتساب';
  
  // About section
  static String get aboutUsDescription => LanguageManager.isEnglish
      ? 'We\'re a local Abu Dhabi team offering premium desert adventures 4×4 dune bashing, VIP camps, live shows and BBQ dinner. Safe drivers and honest pricing.'
      : 'نحن فريق محلي في أبوظبي نقدم مغامرات صحراوية فاخرة تشمل تسلق الكثبان بسيارات 4×4، معسكرات VIP، عروض حية وعشاء شواء. سائقون آمنون وأسعار صادقة.';
  static String get phoneLabel => LanguageManager.isEnglish ? 'Phone:' : 'الهاتف:';
  static String get emailLabel => LanguageManager.isEnglish ? 'Email:' : 'البريد الإلكتروني:';
  
  // VAT info
  static String get vatInfo => LanguageManager.isEnglish 
      ? 'On card payment: 5% VAT and 5% bank charges.' 
      : 'عند الدفع بالبطاقة: 5% ضريبة القيمة المضافة و5% رسوم بنكية.';
}

// ==================== DATA MODELS ====================
class TourPackage {
  final String id;
  final String titleEn;
  final String titleAr;
  final String imagePath;
  final String price;
  final String priceTypeEn;
  final String priceTypeAr;
  final String descriptionEn;
  final String descriptionAr;

  TourPackage({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.imagePath,
    required this.price,
    required this.priceTypeEn,
    required this.priceTypeAr,
    required this.descriptionEn,
    required this.descriptionAr,
  });

  String get title => LanguageManager.isEnglish ? titleEn : titleAr;
  String get priceType => LanguageManager.isEnglish ? priceTypeEn : priceTypeAr;
  String get description => LanguageManager.isEnglish ? descriptionEn : descriptionAr;

  // Create a copy with updated price
  TourPackage copyWith({String? price}) {
    return TourPackage(
      id: id,
      titleEn: titleEn,
      titleAr: titleAr,
      imagePath: imagePath,
      price: price ?? this.price,
      priceTypeEn: priceTypeEn,
      priceTypeAr: priceTypeAr,
      descriptionEn: descriptionEn,
      descriptionAr: descriptionAr,
    );
  }
}

class FeatureItem {
  final String titleEn;
  final String titleAr;
  final String descriptionEn;
  final String descriptionAr;

  FeatureItem({
    required this.titleEn,
    required this.titleAr,
    required this.descriptionEn,
    required this.descriptionAr,
  });

  String get title => LanguageManager.isEnglish ? titleEn : titleAr;
  String get description => LanguageManager.isEnglish ? descriptionEn : descriptionAr;
}

class Testimonial {
  final String textEn;
  final String textAr;
  final String authorEn;
  final String authorAr;

  Testimonial({
    required this.textEn,
    required this.textAr,
    required this.authorEn,
    required this.authorAr,
  });

  String get text => LanguageManager.isEnglish ? textEn : textAr;
  String get author => LanguageManager.isEnglish ? authorEn : authorAr;
}

// ==================== DATA SOURCE ====================
class AppData {
  static List<TourPackage> tourPackages = [
    TourPackage(
      id: '1',
      titleEn: 'Abu Dhabi Desert Safari',
      titleAr: 'سفاري صحراء أبوظبي',
      imagePath: 'assets/des.jpg',
      price: 'AED 150',
      priceTypeEn: 'Per person',
      priceTypeAr: 'لكل شخص',
      descriptionEn: 'Standard desert safari experience',
      descriptionAr: 'تجربة سفاري صحراوية قياسية',
    ),
    TourPackage(
      id: '2',
      titleEn: 'VIP Desert Safari',
      titleAr: 'سفاري صحراوي VIP',
      imagePath: 'assets/vip_des.webp',
      price: 'AED 200',
      priceTypeEn: 'Per person',
      priceTypeAr: 'لكل شخص',
      descriptionEn: 'Premium VIP desert safari',
      descriptionAr: 'سفاري صحراوي VIP فاخر',
    ),
    TourPackage(
      id: '3',
      titleEn: 'Desert Safari With Quad Bike',
      titleAr: 'سفاري صحراوي مع دراجة رباعية',
      imagePath: 'assets/quad.jpg',
      price: 'AED 250',
      priceTypeEn: 'Per person',
      priceTypeAr: 'لكل شخص',
      descriptionEn: 'Safari with quad bike adventure',
      descriptionAr: 'سفاري مع مغامرة الدراجة الرباعية',
    ),
    TourPackage(
      id: '4',
      titleEn: 'VIP Desert Safari + Quad Bike',
      titleAr: 'سفاري صحراوي VIP + دراجة رباعية',
      imagePath: 'assets/safar_quad.jpg',
      price: 'AED 350',
      priceTypeEn: 'Per person',
      priceTypeAr: 'لكل شخص',
      descriptionEn: 'VIP safari with quad bike',
      descriptionAr: 'سفاري VIP مع دراجة رباعية',
    ),
    TourPackage(
      id: '5',
      titleEn: 'Overnight Desert Safari',
      titleAr: 'سفاري صحراوي ليلي',
      imagePath: 'assets/overnight.jpg',
      price: 'AED 400',
      priceTypeEn: 'Per person',
      priceTypeAr: 'لكل شخص',
      descriptionEn: 'Overnight camping experience',
      descriptionAr: 'تجربة تخييم ليلية',
    ),
    TourPackage(
      id: '6',
      titleEn: '1 Seater Dune Buggy',
      titleAr: 'عربة الكثبان لمقعد واحد',
      imagePath: 'assets/1_dune.webp',
      price: 'AED 600',
      priceTypeEn: 'Per person',
      priceTypeAr: 'لكل شخص',
      descriptionEn: 'Single person dune buggy ride',
      descriptionAr: 'ركوب عربة الكثبان لشخص واحد',
    ),
    TourPackage(
      id: '7',
      titleEn: '2 Seater Dune Buggy',
      titleAr: 'عربة الكثبان لمقعدين',
      imagePath: 'assets/2_dune.jpg',
      price: 'AED 1000',
      priceTypeEn: 'Per group (up to 2)',
      priceTypeAr: 'لكل مجموعة (حتى 2)',
      descriptionEn: 'Two-seater dune buggy adventure',
      descriptionAr: 'مغامرة عربة الكثبان لمقعدين',
    ),
    TourPackage(
      id: '8',
      titleEn: '4 Seater Dune Buggy',
      titleAr: 'عربة الكثبان لأربعة مقاعد',
      imagePath: 'assets/4_dune.jpg',
      price: 'AED 1400',
      priceTypeEn: 'Per group (up to 4)',
      priceTypeAr: 'لكل مجموعة (حتى 4)',
      descriptionEn: 'Four-seater dune buggy ride',
      descriptionAr: 'ركوب عربة الكثبان لأربعة مقاعد',
    ),
    TourPackage(
      id: '9',
      titleEn: 'Private Desert Safari',
      titleAr: 'سفاري صحراوي خاص',
      imagePath: 'assets/private_saf.jpg',
      price: 'AED 1000',
      priceTypeEn: 'Per group (up to 6)',
      priceTypeAr: 'لكل مجموعة (حتى 6)',
      descriptionEn: 'Private safari for groups',
      descriptionAr: 'سفاري خاص للمجموعات',
    ),
    TourPackage(
      id: '10',
      titleEn: 'Morning Desert Safari',
      titleAr: 'سفاري صحراوي صباحي',
      imagePath: 'assets/morning.jpg',
      price: 'AED 300',
      priceTypeEn: 'Per person',
      priceTypeAr: 'لكل شخص',
      descriptionEn: 'Morning safari experience',
      descriptionAr: 'تجربة سفاري صباحية',
    ),
    TourPackage(
      id: '11',
      titleEn: 'Morning Safari + Quad Bike',
      titleAr: 'سفاري صباحي + دراجة رباعية',
      imagePath: 'assets/morning_quad.jpg',
      price: 'AED 400',
      priceTypeEn: 'Per person',
      priceTypeAr: 'لكل شخص',
      descriptionEn: 'Morning safari with quad bike',
      descriptionAr: 'سفاري صباحي مع دراجة رباعية',
    ),
    TourPackage(
      id: '12',
      titleEn: 'Private Morning Safari',
      titleAr: 'سفاري صباحي خاص',
      imagePath: 'assets/private_morning.webp',
      price: 'AED 1500',
      priceTypeEn: 'Per group (up to 6)',
      priceTypeAr: 'لكل مجموعة (حتى 6)',
      descriptionEn: 'Private morning safari',
      descriptionAr: 'سفاري صباحي خاص',
    ),
  ];

  // Feature items data
  static List<FeatureItem> featureItems = [
    FeatureItem(
      titleEn: 'PICK & DROP FROM',
      titleAr: 'الالتقاء والإعادة من',
      descriptionEn: 'Meeting Points / Hotel / Residence',
      descriptionAr: 'نقاط الالتقاء / الفندق / السكن',
    ),
    FeatureItem(
      titleEn: 'SERVICE',
      titleAr: 'الخدمة',
      descriptionEn: 'Afternoon departure',
      descriptionAr: 'انطلاق بعد الظهر',
    ),
    FeatureItem(
      titleEn: 'REFRESHMENT',
      titleAr: 'المرطبات',
      descriptionEn: 'Water, cold drinks, soft juice',
      descriptionAr: 'ماء، مشروبات باردة، عصائر طازجة',
    ),
    FeatureItem(
      titleEn: 'PICK-UP',
      titleAr: 'الالتقاء',
      descriptionEn: '02:30 – 03:00 PM (pickup window)',
      descriptionAr: '02:30 – 03:00 مساءً (نافذة الالتقاء)',
    ),
    FeatureItem(
      titleEn: 'MEAL',
      titleAr: 'الوجبة',
      descriptionEn: 'Live BBQ, Fresh Buffet Dinner',
      descriptionAr: 'شواء حي، بوفيه عشاء طازج',
    ),
    FeatureItem(
      titleEn: 'DROP-OFF',
      titleAr: 'الإعادة',
      descriptionEn: '09:30 – 10:00 PM (return window)',
      descriptionAr: '09:30 – 10:00 مساءً (نافذة الإعادة)',
    ),
    FeatureItem(
      titleEn: 'VEHICLE',
      titleAr: 'المركبة',
      descriptionEn: 'Air-conditioned, Non-smoking',
      descriptionAr: 'مكيفة، ممنوع التدخين',
    ),
  ];

  // Testimonials data
  static List<Testimonial> testimonials = [
    Testimonial(
      textEn: 'Amazing dune bashing and lovely camp dinner. Highly recommended!',
      textAr: 'تسلق الكثبان رائع وعشاء المخيم لطيف. موصى به بشدة!',
      authorEn: 'Matthew K.',
      authorAr: 'ماثيو ك.',
    ),
    Testimonial(
      textEn: 'Professional guides and safe rides. The fire show was incredible.',
      textAr: 'مرشدون محترفون ورحلات آمنة. عرض النار كان رائعًا.',
      authorEn: 'Daniel P.',
      authorAr: 'دانيال ب.',
    ),
    Testimonial(
      textEn: 'VIP seating was worth it. Smooth pickup and great service.',
      textAr: 'مقاعد VIP تستحق العناء. الالتقاء سلس وخدمة رائعة.',
      authorEn: 'John R.',
      authorAr: 'جون ر.',
    ),
  ];

  // Other configurable data
  static String durationTextEn = 'upto 6 Hours — Daily available';
  static String durationTextAr = 'حتى 6 ساعات — متاح يوميًا';
  
  static String get durationText => LanguageManager.isEnglish ? durationTextEn : durationTextAr;
  
  static String whatsappNumber = 'WhatsApp';
  static String phoneNumber = '+971 567530535';
  static String email = 'booking@abudhahideeertsafarii.com';
  static String addressEn = 'Abu Dhabi, UAE';
  static String addressAr = 'أبوظبي، الإمارات العربية المتحدة';
  
  static String get address => LanguageManager.isEnglish ? addressEn : addressAr;
  
  // VAT info - ADDED THE MISSING GETTER
  static String get vatInfo => TranslationService.vatInfo;

  // Helper method to update tour package price
  static void updateTourPrice(String tourId, String newPrice) {
    final index = tourPackages.indexWhere((tour) => tour.id == tourId);
    if (index != -1) {
      tourPackages[index] = tourPackages[index].copyWith(price: newPrice);
    }
  }

  // Helper method to update any text data
  static void updateDurationText(String newTextEn, String newTextAr) {
    durationTextEn = newTextEn;
    durationTextAr = newTextAr;
  }

  // Add more update methods as needed...
}

// ==================== LANGUAGE SWITCHER DIALOG ====================
class LanguageSwitcherDialog extends StatelessWidget {
  const LanguageSwitcherDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      title: Text(
        'Select Language',
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.language, color: Colors.orange),
            title: Text('English', style: TextStyle(color: Colors.white)),
            trailing: LanguageManager.isEnglish 
                ? Icon(Icons.check_circle, color: Colors.green)
                : null,
            onTap: () {
              LanguageManager.switchLanguage(AppLanguage.english);
              Navigator.of(context).pop();
            },
          ),
          Divider(color: Colors.grey[700]),
          ListTile(
            leading: Icon(Icons.language, color: Colors.orange),
            title: Text('العربية', style: TextStyle(color: Colors.white)),
            trailing: LanguageManager.isArabic 
                ? Icon(Icons.check_circle, color: Colors.green)
                : null,
            onTap: () {
              LanguageManager.switchLanguage(AppLanguage.arabic);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Close', style: TextStyle(color: Colors.orange)),
        ),
      ],
    );
  }
}

// ==================== MAIN WIDGET ====================
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return Text(
                TranslationService.appTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              );
            } else {
              return Row(
                children: [
                  const Icon(Icons.terrain, color: Colors.orange),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      TranslationService.appTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              );
            }
          },
        ),
        actions: [
          if (MediaQuery.of(context).size.width > 900)
            ..._buildDesktopNavButtons(),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.language, color: Colors.white70),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const LanguageSwitcherDialog(),
              ).then((_) {
                setState(() {});
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.nights_stay, color: Colors.white70),
            onPressed: () {},
          ),
          if (MediaQuery.of(context).size.width <= 900)
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white70),
              onPressed: () {
                _showMobileMenu(context);
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildTourCardsSection(),
              const SizedBox(height: 40),
              _buildDetailedContentSection(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDesktopNavButtons() {
    return [
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
    ];
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.home, color: Colors.orange),
                title: Text(TranslationService.home, 
                  style: const TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  context.go('/');
                },
              ),
              ListTile(
                leading: const Icon(Icons.explore, color: Colors.orange),
                title: Text(TranslationService.tours, 
                  style: const TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  context.go('/tour');
                },
              ),
              ListTile(
                leading: const Icon(Icons.info, color: Colors.orange),
                title: Text(TranslationService.about, 
                  style: const TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  context.go('/about');
                },
              ),
              ListTile(
                leading: const Icon(Icons.contact_page, color: Colors.orange),
                title: Text(TranslationService.contact, 
                  style: const TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  context.go('/contact');
                },
              ),
              ListTile(
                leading: const Icon(Icons.question_answer, color: Colors.orange),
                title: Text(TranslationService.faqs, 
                  style: const TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.book_online, color: Colors.orange),
                title: Text(TranslationService.bookNow, 
                  style: const TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  context.go('/book_now');
                },
              ),
              const SizedBox(height: 20),
              const Divider(color: Colors.grey),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close', 
                  style: TextStyle(color: Colors.orange)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTourCardsSection() {
  return Directionality(
    textDirection: LanguageManager.isArabic ? TextDirection.rtl : TextDirection.ltr,
    child: LayoutBuilder(
      builder: (context, constraints) {
        final double screenWidth = constraints.maxWidth;
        int crossAxisCount;
        
        if (screenWidth >= 1200) {
          crossAxisCount = 3;
        } else if (screenWidth >= 800) {
          crossAxisCount = 3;
        } else if (screenWidth >= 600) {
          crossAxisCount = 2;
        } else {
          crossAxisCount = 2;
        }
        
        // Use a much smaller aspect ratio to accommodate both languages
        double childAspectRatio = 0.6; // Reduced to 0.5
        
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 12,
            mainAxisSpacing: 16,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: AppData.tourPackages.length,
          itemBuilder: (context, index) {
            return _buildTourCard(AppData.tourPackages[index]);
          },
        );
      },
    ),
  );
}
Widget _buildTourCard(TourPackage tour) {
  return Card(
    color: const Color(0xFF1a1a1a),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Image - Further reduced aspect ratio
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          child: AspectRatio(
            aspectRatio: 16 / 13, // Even more reduced to give maximum vertical space
            child: Image.asset(
              tour.imagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[800],
                  child: const Center(
                    child: Icon(Icons.image, color: Colors.grey, size: 40),
                  ),
                );
              },
            ),
          ),
        ),
        
        // Content - Using Expanded to prevent overflow
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title - More compact
                Text(
                  tour.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15, // Further reduced
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: 2),
                
                // Price type - More compact
                Text(
                  tour.priceType,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 10, // Further reduced
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 3),
                
                // Price - More compact
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), // Further reduced
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    tour.price,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12, // Further reduced
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                
                const SizedBox(height: 1),
                
                // View details button - More compact
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      String detailId = _mapTourIdToDetailId(tour.id);
                      context.go('/tour/$detailId');
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.orange),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 3), // Further reduced
                    ),
                    child: Text(
                      TranslationService.viewDetails,
                      style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 12, // Further reduced
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
  String _mapTourIdToDetailId(String tourId) {
    Map<String, String> idMapping = {
      '1': 'abu_dhabi_desert_safari',
      '2': 'vip_desert_safari',
      '3': 'desert_safari_with_quad_bike',
      '4': 'vip_desert_safari_quad_bike',
      '5': 'overnight_desert_safari',
      '6': '1_seater_dune_buggy',
      '7': '2_seater_dune_buggy',
      '8': 'private_desert_safari',
      '9': 'private_safari_premium',
      '10': 'morning_desert_safari',
      '11': 'morning_desert_safari_quad_bike',
      '12': 'private_morning_desert_safari',
    };
    return idMapping[tourId] ?? 'abu_dhabi_desert_safari';
  }

  Widget _buildDetailedContentSection() {
    return Directionality(
      textDirection: LanguageManager.isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF1a1a1a),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TranslationService.duration,
                  style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppData.durationText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount;
                if (constraints.maxWidth > 900) {
                  crossAxisCount = 4;
                } else if (constraints.maxWidth > 600) {
                  crossAxisCount = 2;
                } else {
                  crossAxisCount = 1;
                }
                
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: constraints.maxWidth > 600 ? 3.5 : 2.5,
                  ),
                  itemCount: AppData.featureItems.length,
                  itemBuilder: (context, index) {
                    final feature = AppData.featureItems[index];
                    return _buildFeatureItem(feature.title, feature.description);
                  },
                );
              },
            ),
            
            const SizedBox(height: 30),
            const Divider(color: Colors.grey),
            const SizedBox(height: 30),
            
            Center(
              child: Column(
                children: [
                  Text(
                    TranslationService.bookNowSection,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppData.whatsappNumber,
                    style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            const Divider(color: Colors.grey),
            const SizedBox(height: 30),
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TranslationService.whatGuestsSay,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: AppData.testimonials.map((testimonial) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildTestimonial(testimonial.text, testimonial.author),
                    );
                  }).toList(),
                ),
              ],
            ),
            
            const SizedBox(height: 30),
            const Divider(color: Colors.grey),
            const SizedBox(height: 30),
            
            Center(
              child: Column(
                children: [
                  Text(
                    TranslationService.planYourExperience,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth > 600) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.orange),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                TranslationService.contactButton,
                                style: const TextStyle(
                                  color: Colors.orange,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.orange),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                TranslationService.whatsappButton,
                                style: const TextStyle(
                                  color: Colors.orange,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                TranslationService.bookNow,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Colors.orange),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  TranslationService.contactButton,
                                  style: const TextStyle(
                                    color: Colors.orange,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Colors.orange),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  TranslationService.whatsappButton,
                                  style: const TextStyle(
                                    color: Colors.orange,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  TranslationService.bookNow,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            const Divider(color: Colors.grey),
            const SizedBox(height: 30),
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TranslationService.aboutUs,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  TranslationService.aboutUsDescription,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${TranslationService.phoneLabel} ${AppData.phoneNumber}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${TranslationService.emailLabel} ${AppData.email}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      AppData.address,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 12,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.camera_alt, color: Colors.orange, size: 24),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.message, color: Colors.orange, size: 24),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.play_arrow, color: Colors.orange, size: 24),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.facebook, color: Colors.orange, size: 24),
                    ),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 30),
            const Divider(color: Colors.grey),
            const SizedBox(height: 30),
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TranslationService.siteLinks,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(TranslationService.home, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(TranslationService.tours, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(TranslationService.about, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(TranslationService.contact, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(TranslationService.faqs, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Terms', style: TextStyle(color: Colors.grey, fontSize: 14)),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Privacy', style: TextStyle(color: Colors.grey, fontSize: 14)),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Payment', style: TextStyle(color: Colors.grey, fontSize: 14)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  AppData.vatInfo,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.orange,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Widget _buildTestimonial(String text, String author) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2a2a2a),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '"$text"',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '— $author',
            style: const TextStyle(
              color: Colors.orange,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      )
    );
  }
}