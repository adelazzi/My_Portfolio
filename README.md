# Flutter Portfolio

An attractive, modern portfolio website built with Flutter for Web showcasing HPC and Fullstack development skills.

## Features

- Responsive design for all devices (mobile, tablet, desktop)
- Modern UI with smooth animations
- Dark/Light theme support
- Interactive particle background
- Showcase for education, work experience, skills, and projects
- Contact form for potential clients and employers

## Tech Stack

- Flutter for Web
- Dart programming language

## Sections

1. **Home** - Introduction and call to action
2. **About** - Education, work experience, and personal background
3. **Skills** - Technical abilities with visual indicators of proficiency
4. **Projects** - Showcase of work with filterable categories
5. **Contact** - Contact form and social media links

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- A code editor (VS Code, Android Studio, etc.)

### Installation

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/yourusername/portfolio.git
   cd portfolio
   ```

2. Get the dependencies:

   ```bash
   flutter pub get
   ```

3. Run the app in development mode:

   ```bash
   flutter run -d chrome
   ```

### Building for Production

To build the website for production:

```bash
flutter build web
```

The built files will be available in the `build/web` directory. You can deploy these files to any web hosting service.

## Customization

To personalize this portfolio:

1. Update personal information in the respective files:
   - Edit profile information in `lib/screens/about_screen.dart`
   - Update skills in `lib/screens/skills_screen.dart`
   - Add your projects in `lib/screens/projects_screen.dart`
   - Update contact information in `lib/screens/contact_screen.dart`

2. Replace placeholder images with your own in the `assets/images/` directory

3. Adjust colors and theme in `lib/utils/theme.dart`

## License

This project is licensed under the MIT License

## Acknowledgements

- Flutter team for the amazing framework
- All open-source libraries used in this project
