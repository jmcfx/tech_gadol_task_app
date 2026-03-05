# Tech Gadol Task App (Product Catalog Interview Task)
A Flutter mini-app that showcases a list of products with search, category filtering, and detail screens.  
Built using **Clean Architecture**, **BLoC** for state management, **Dio/Retrofit** for networking, and **Freezed** for immutable models and union states.  
Includes a reusable, composable `ProductCard` widget, designed for flexibility and adaptability across different screen sizes.  
The app is fully offline-capable, testable, and structured with maintainability in mind.


## Product List Page & Detail Page

## 📌 Snippet



https://github.com/user-attachments/assets/a4da8b2e-00ef-428e-96d7-783689b0a327




## 📌 Demo Video

The full video is too large to upload here.  
Copy the link below into your browser to watch the full demo video:

```bash
https://drive.google.com/file/d/161QQmuloFwjQE5Ss-bcJlEzBK3MgJHJh/view?usp=sharing
```

In the demo, I showcased:
- Offline mode test (pull-to-refresh when online)
- Real-time product search with 500ms debouncing
- Smooth navigation to detail screen with Hero animations
- Master-detail responsive layout on tablet/desktop sizes
- Pagination
- Light and Dark mode toggling with instant design system updates

## 🚀 Getting Started

### 📦 Installation

**Clone the Repository**

```bash
git clone git@github.com:jmcfx/tech_gadol_task_app.git
cd tech_gadol_task_app
```

### 🚀 Steps to Run

#### 1. 🔧 Set Up Dependencies and Generate Code ‼️

Run the following to clean the project, install dependencies, and generate `build_runner` outputs (`freezed`, `json_serializable`, `retrofit`):
```bash
make fresh
``` 
This will run the following commands:
- `flutter clean` – Resets the build directory
- `flutter pub get` – Fetches dependencies
- `dart run build_runner build -d` – Generates `freezed` & `json_serializable`

#### 2. 🚀 Run the app on a connected device or emulator ‼️

```bash
flutter run
```

#### 3. 🔄 Regenerate Code Only

If you just need to regenerate code (e.g., after editing models or annotations):
```bash
make runner
```
> Runs `dart run build_runner build -d`

#### 4. 👀 Watch for File Changes

Automatically regenerates code on file changes during development:
```bash
make watch
```
> Runs `dart run build_runner watch -d`

### 5. 📦 Build Android APK :
```bash
make apk
```

This command will:

- Run `flutter pub get` to ensure dependencies are installed

- Run `build_runner` to generate required code (`freezed`, `retrofit`, `json_serializable`)

- Build the `Android APK` using `flutter build apk`

## Folder Structure :open_file_folder:

```text
lib/
├── app/                  # Theme, routing (GoRouter), and app entry
├── core/                 # Shared utilities, DI, errors, and Enums
│   ├── di/
│   ├── enums/
│   ├── errors/
│   ├── networks/
│   └── use_case/
├── features/
│   └── products/
│       ├── data/         # Retrofit clients, models, remote/local data sources, repo impl
│       ├── domain/       # Entities, repo contracts, use cases
│       └── presentation/ # BLoC/Cubit, screens, layouts
└── shared/
    └── widgets/          # Custom Design System components (ProductCard, RatingBar, etc.)
```

## ✨ Features

- 🧼 **Clean Architecture** — clear separation between Domain, Data, and Presentation.
- 🔎 **Real-time Search & Filtering** — debounced search (500ms) and category filtering.
- 📝 **Product Detail Page** — view full product gallery, stock info, and pricing.
- 🧩 **Design System & Reusable Widgets** — 9 reusable widgets (like `ProductCard`, `PriceTag`) driven entirely by a custom `ThemeExtension`, ensuring no hardcoded colors in UI code.
- 💾 **Local persistence / Offline support** — Hive-backed caching layer (15-min TTL) ensuring products remain visible even without an internet connection.
- ⚡ **Explicit UI States** — clear idle, loading, success, and error states with a retry mechanism.
- 🛠 **Resilient JSON Parsing** — `@Default` fallbacks on models and domain-level validation (clamping prices, bounding ratings) to prevent crashes from missing API fields.
- 📱 **Responsive UI** — handles mobile views natively, and snaps into a master-detail split-view on tablet/desktop sizes (≥768px).
- 🔗 **Deep Linking** — `GoRouter` setup allows direct URL navigation to specific products (`/products/:id`).
- 🔄 **Testable Architecture** — 32 unit and widget tests covering BLoC transitions, JSON parsing resilience, and UI component rendering.

## 🎨 What I'd Improve With More Time

If I had more time, I would focus heavily on **UI polish and UX micro-interactions**:
1. **Staggered entry animations**: List items fading and sliding up sequentially on first load instead of appearing instantly.
2. **Shared element transitions**: A custom `PageRouteBuilder` to seamlessly morph the `ProductCard` into the `ProductDetailScreen` (animating the title and price along with the image Hero).
3. **Micro-interactions**: Subtle scale/elevation bumps when hovering or pressing down on cards/buttons.
4. **Parallax image gallery**: A subtle scroll parallax effect on the product detail image horizontally.
5. **Component showcase route**: A dedicated `/showcase` developer route displaying all components (cards, chips, error states) in all variants (light/dark, selected/disabled).
6. **Pull-to-refresh**: Wrap the `CustomScrollView` in a `RefreshIndicator` for intuitive manual retries, especially crucial for the offline recovery flow.

## 📦 Dependencies

- **flutter** – Core SDK
- **dartz** – Functional programming tools (`Either`, `Option`) used for clean failure handling.
- **equatable** – Value equality for BLoC states.
- **dio** – Powerful HTTP client with custom logging interceptors.
- **retrofit** – Type-safe REST client generator.
- **go_router** – Declarative routing and deep linking.
- **get_it** – Service locator for dependency injection.
- **hive_flutter** – Fast, pure-Dart local key-value database for offline caching.
- **connectivity_plus** – Network state detection.
- **cached_network_image** – Image fetching and disk caching.
- **shimmer** – Skeleton loaders.
- **flutter_bloc** – State management and predictable UI states.

### Dev Dependencies

- **flutter_test** – Built-in testing framework.
- **build_runner** – Runs code generators.
- **freezed** – Generates immutable data classes, unions, and `@Default` constructors.
- **json_serializable** – Generates JSON parsing logic.
- **retrofit_generator** – Generates Retrofit networking code.
