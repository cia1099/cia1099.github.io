const langDict = {"en": "English", "zh_CN": "简体中文", "zh_TW": "繁體中文"};
const degreeEdu = ['master', 'bachelor'];
final coreTechnologies = Set<String>.from([
  'Flutter',
  'OpenCV',
  'Pytorch',
  'GraphQL',
  'Flame',
  'CMake',
  'SwiftUI',
  'UIKit',
  'FastAPI',
  'SqlAlchemy',
  'CloudFlare',
  'Git',
  'Docker',
  'Open3D',
  'ARKit'
]..sort((a, b) => a[0].compareTo(b[0])));

final kernelCompetence = [
  'Functional Programming',
  'OOP Design',
  'Documentation writing',
  'Test-Driven Development',
  'Responsive Design',
  'System Design',
  'Performance Optimization',
  // 'Accessibility auditing',
  'Build Automation',
  'UX Design/Strategy',
  'Cross-Platform Capability',
  'MVC/MVVM Pattern',
  'Clean Code',
  'International',
  'Multi-Theme',
]..sort((a, b) => a[0].compareTo(b[0]));
