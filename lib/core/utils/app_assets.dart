class AppAssets {
  static String? getCampaignImage(String title) {
    final Map<String, String> imageMap = {
      // Organizations
      'Misr El Kheir': 'assets/images/Misr El Kheir.png',
      'Bayt Al Zakat and Al Sadaqat': 'assets/images/bait_al_zakat.png',
      'Resala Charity Organization': 'assets/images/resala.png',
      'Al Orman Association': 'assets/images/orman.png',
      // Campaigns
      'Medical Camp in Aswan': 'assets/images/aswan_medical_camp.png',
      'School Supplies for Orphans': 'assets/images/orphan_school_bag.png',
      'Emergency Flood Relief': 'assets/images/flood_relief.png',
      'Clean Water for Rural Villages': 'assets/images/egypt_water_well.png',
      'Ramadan Food Baskets': 'assets/images/ramadan_food_box.png',
      'Sponsor an Orphan': 'assets/images/sponsor_orphan.png',
      'Winter Clothes for the Poor': 'assets/images/winter_clothes.png',
      'Care for People with Disabilities': 'assets/images/disabled_care.png',
      'Support for the Elderly': 'assets/images/elderly_support.png',
    };
    return imageMap[title];
  }
}
