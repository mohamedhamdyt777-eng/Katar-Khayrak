import 'package:cloud_firestore/cloud_firestore.dart';

/// Seeds the Firestore `campaigns` collection with initial data on first app launch.
/// Only runs if the collection is empty — safe to leave in production.
class FirestoreSeeder {
  static final _firestore = FirebaseFirestore.instance;

  static Future<void> seedCampaignsIfEmpty() async {
    final snapshot =
        await _firestore.collection('campaigns').limit(1).get();

    if (snapshot.docs.isNotEmpty) return; // Already seeded, skip.

    final batch = _firestore.batch();
    final col = _firestore.collection('campaigns');

    for (final data in _seedCampaigns) {
      final ref = col.doc();
      batch.set(ref, {
        ...data,
        'createdAt': FieldValue.serverTimestamp(),
        'raisedAmount': 0,
        'galleryImagePaths': [],
        'organizationId': null,
        'coverImagePath': null,
      });
    }

    await batch.commit();
  }

  // ── Seed data (mirrors the original CampaignsCubit._initialCampaigns) ────
  static const List<Map<String, dynamic>> _seedCampaigns = [
    // Most Needed (categoryIndex: 1)
    {
      'title': 'Clean Water for Rural Villages',
      'date': '15 May',
      'imageColorValue': 0xFFB2EBF2, // Colors.cyan.shade100
      'location': 'Sinai, Egypt',
      'categoryIndex': 1,
      'targetAmount': 50000.0,
      'description':
          'Thousands of families in remote Sinai villages lack access to safe drinking water. '
          'This campaign funds the installation of water purification units and deep-well pumps '
          'so that entire communities have clean, reliable water year-round.',
    },
    {
      'title': 'Urgent Food Baskets – Ramadan Drive',
      'date': '18 May',
      'imageColorValue': 0xFFC8E6C9, // Colors.green.shade100
      'location': 'Cairo, Egypt',
      'categoryIndex': 1,
      'targetAmount': 30000.0,
      'description':
          'With rising food prices, many low-income families cannot afford basic nutrition. '
          'We are distributing monthly food baskets containing rice, oil, sugar, and canned '
          'goods to 1,000 families throughout Greater Cairo.',
    },

    // Most Donated (categoryIndex: 2)
    {
      'title': 'Build a School in Upper Egypt',
      'date': '10 Apr',
      'imageColorValue': 0xFFFFECB3, // Colors.amber.shade100
      'location': 'Luxor, Egypt',
      'categoryIndex': 2,
      'targetAmount': 200000.0,
      'description':
          'Our most-supported project of the year! We are constructing a modern 12-classroom '
          'school in a remote area of Luxor where children currently walk over 10 km each day '
          'to attend class. Over EGP 140,000 has already been raised!',
    },
    {
      'title': 'Mobile Clinic for Delta Villages',
      'date': '05 Mar',
      'imageColorValue': 0xFFE1BEE7, // Colors.purple.shade100
      'location': 'Nile Delta, Egypt',
      'categoryIndex': 2,
      'targetAmount': 80000.0,
      'description':
          'Our mobile medical unit has already served 3,200 patients in Nile Delta villages. '
          'Help us keep the wheels turning with medicines, diagnostic equipment, and fuel for '
          'monthly outreach trips.',
    },

    // Health (categoryIndex: 3)
    {
      'title': 'Medical Camp in Aswan',
      'date': '21 May',
      'imageColorValue': 0xFFB2DFDB, // Colors.teal.shade100
      'location': 'Aswan, Egypt',
      'categoryIndex': 3,
      'targetAmount': 25000.0,
      'description':
          'Join us for our upcoming medical camp in Aswan. We will be providing free health '
          'checkups, medicine, and specialised consultations to over 500 residents in need. '
          'Your contribution helps us cover the cost of supplies and travel for our volunteer doctors.',
    },
    {
      'title': 'Cancer Awareness & Early Detection',
      'date': '28 May',
      'imageColorValue': 0xFFF8BBD0, // Colors.pink.shade100
      'location': 'Alexandria, Egypt',
      'categoryIndex': 3,
      'targetAmount': 60000.0,
      'description':
          'Early detection saves lives. This campaign funds free mammograms, colonoscopies, '
          'and skin-cancer screenings at community health centres across Alexandria, reaching '
          'women and men who cannot afford private diagnostics.',
    },

    // Education (categoryIndex: 4)
    {
      'title': 'School Supplies for Orphans',
      'date': '22 May',
      'imageColorValue': 0xFFBBDEFB, // Colors.blue.shade100
      'location': 'Cairo, Egypt',
      'categoryIndex': 4,
      'targetAmount': 15000.0,
      'description':
          'Help us equip 200 orphaned children with the essential school supplies they need '
          'for the new academic year. Backpacks, notebooks, and stationery will be distributed '
          'at the local community centre.',
    },
    {
      'title': 'Digital Literacy for Girls',
      'date': '01 Jun',
      'imageColorValue': 0xFFC5CAE9, // Colors.indigo.shade100
      'location': 'Beni Suef, Egypt',
      'categoryIndex': 4,
      'targetAmount': 40000.0,
      'description':
          'Bridge the digital gender gap! We are establishing a computer lab in a girls\' '
          'secondary school in Beni Suef, offering coding bootcamps and digital-skills workshops '
          'to 300 students each semester.',
    },

    // Orphans (categoryIndex: 5)
    {
      'title': 'Eid Clothes for Orphan Children',
      'date': '12 May',
      'imageColorValue': 0xFFFFE0B2, // Colors.orange.shade100
      'location': 'Giza, Egypt',
      'categoryIndex': 5,
      'targetAmount': 20000.0,
      'description':
          'Every child deserves to celebrate Eid with a new outfit. We are providing 500 '
          'orphaned children across Giza governorate with new Eid clothing and a small gift, '
          'bringing joy to their special day.',
    },
    {
      'title': 'Orphan Sponsorship Programme',
      'date': '20 May',
      'imageColorValue': 0xFFFFCCBC, // Colors.deepOrange.shade100
      'location': 'Nationwide, Egypt',
      'categoryIndex': 5,
      'targetAmount': 120000.0,
      'description':
          'Sponsor an orphan\'s entire education, healthcare, and living expenses for one year. '
          'Monthly contributions go directly to vetted orphan-care homes across Egypt, with '
          'full transparency reports sent to every sponsor.',
    },

    // Disaster Relief (categoryIndex: 6)
    {
      'title': 'Emergency Flood Relief',
      'date': '23 May',
      'imageColorValue': 0xFFCFD8DC, // Colors.blueGrey.shade100
      'location': 'Alexandria, Egypt',
      'categoryIndex': 6,
      'targetAmount': 35000.0,
      'description':
          'Recent severe weather has displaced many families in Alexandria. We are collecting '
          'funds to provide emergency shelter kits, warm blankets, and hot meals. Act now to '
          'provide immediate assistance to those affected.',
    },
    {
      'title': 'Earthquake Recovery – Rebuild Homes',
      'date': '30 Apr',
      'imageColorValue': 0xFFD7CCC8, // Colors.brown.shade100
      'location': 'Matrouh, Egypt',
      'categoryIndex': 6,
      'targetAmount': 150000.0,
      'description':
          'A recent earthquake left over 300 families homeless in Matrouh. Your donation funds '
          'prefabricated shelter units, debris clearance, and the rebuilding of damaged structures '
          'so that displaced families can return home safely.',
    },
  ];
}
