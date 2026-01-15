class HowItWorksContent {
  HowItWorksContent._();

  static const List<InfoCard> cards = [
    InfoCard(
      title: 'What is Work Box',
      description:
          'Work Box is a utility application designed to help you stay productive with essential tools including calculator, unit converter, and notes manager. All features work offline and require no internet connection.',
      icon: '📦',
    ),
    InfoCard(
      title: 'Key Features',
      description:
          '• Calculator: Perform basic and advanced calculations\n• Unit Converter: Convert between different units of measurement\n• Notes: Create and manage your notes locally\n• Offline-first: All features work without internet',
      icon: '✨',
    ),
    InfoCard(
      title: 'Productivity Tips',
      description:
          '• Use notes to quickly capture ideas and thoughts\n• Keep frequently used conversions handy\n• Organize your notes with clear titles\n• All data is stored locally on your device',
      icon: '💡',
    ),
    InfoCard(
      title: 'Offline Usage',
      description:
          'Work Box is designed to work completely offline. All your data is stored locally on your device, ensuring privacy and availability even without internet connection.',
      icon: '📱',
    ),
    InfoCard(
      title: 'No Account Required',
      description:
          'Work Box respects your privacy. No account registration is needed. All features are available immediately with a local profile. Your data stays on your device.',
      icon: '🔒',
    ),
  ];
}

class InfoCard {
  final String title;
  final String description;
  final String icon;

  const InfoCard({
    required this.title,
    required this.description,
    required this.icon,
  });
}
