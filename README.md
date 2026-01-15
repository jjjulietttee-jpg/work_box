# WorkBox

A Flutter utility app combining essential productivity tools: Notes, Calculator, and Unit Converter in a single, beautifully designed interface.

## 🎮 Main Functionality

**WorkBox** is a comprehensive utility application that provides essential productivity tools in one place. The app includes:

- **Home Screen**: Main dashboard with card-based navigation to all available tools:
  - Notes
  - Calculator
  - Converter
  - Settings
- **Notes Screen**: Note-taking application with:
  - Create, edit, and delete notes
  - Search functionality
  - Automatic date tracking
  - Local storage persistence
  - Clean, minimal interface
- **Calculator Screen**: Full-featured calculator with:
  - Basic arithmetic operations (addition, subtraction, multiplication, division)
  - Clear and delete functions
  - Large, touch-friendly buttons
  - Glass morphism design with soft glow effects
- **Converter Screen**: Unit conversion tool supporting:
  - **Length**: meters, kilometers, centimeters, millimeters, inches, feet, yards, miles
  - **Weight**: kilograms, grams, milligrams, pounds, ounces
  - **Temperature**: Celsius, Fahrenheit, Kelvin
  - Real-time conversion with swap functionality
  - Type selector for easy switching between conversion types
- **Settings Screen**: App configuration and preferences:
  - Theme switcher (Light/Dark mode)
  - App information
  - Clear data option

## 🏗️ Architecture

The project follows **Clean Architecture** principles with clear separation of concerns:

- **Presentation Layer**: UI components, screens, widgets, and state management using BLoC/Cubit pattern
- **Domain Layer**: Business logic, entities (e.g., `Note`), repository interfaces, and use cases (e.g., `GetNotes`, `SaveNote`, `DeleteNote`, `SearchNotes`)
- **Data Layer**: Local data sources, repository implementations, and models (e.g., `NoteModel`)

### Key Architectural Features

- **State Management**: BLoC/Cubit pattern for notes, calculator, converter, and settings
- **Dependency Injection**: GetIt service locator for managing dependencies
- **Navigation**: GoRouter with ShellRoute for bottom navigation and nested routing
- **Reusable Components**: Shared widgets library including glass cards, custom dialogs, and animated components
- **Service Layer**: Modular services for storage management, calculator operations, and unit conversions
- **Theme System**: Centralized theming with support for light/dark modes, custom colors, fonts, and glass morphism effects
- **Data Persistence**: Local storage using SharedPreferences for notes and settings

## 🛠️ Tech Stack

- **Flutter** with Dart
- **flutter_bloc** for state management
- **go_router** for navigation
- **get_it** for dependency injection
- **shared_preferences** for local data storage
- **equatable** for value equality
- **liquid_glass_renderer** for glass morphism UI effects
- **intl** for internationalization and formatting
- **talker_flutter** & **talker_bloc_logger** for logging and debugging

## 📱 Features

- Multi-tool utility app (Notes, Calculator, Converter)
- Clean, modern UI with glass morphism design
- Dark/Light theme support
- Local data persistence
- Search functionality for notes
- Real-time unit conversion
- Smooth animations and transitions
- Professional utility-focused design

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK**: 3.24.x or higher
- **Dart SDK**: 3.10.4 or higher (as specified in `pubspec.yaml`)

### Installation

1. Extract the project archive to your desired location

2. Navigate to the project directory:
   ```bash
   cd work_box
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

### Building for Release

**Android:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

## 📝 Notes

- The app uses local storage (SharedPreferences) for notes and settings
- All notes are stored locally and persist across app restarts
- Theme preference is saved and restored automatically
- Calculator and converter operate entirely offline
- The app features a professional utility design with glass morphism effects
