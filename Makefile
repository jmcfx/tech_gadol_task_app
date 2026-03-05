
# ------------------------------------------
# Makefile for Flutter project automation
# ------------------------------------------

# Variables (can be reused)
BUILD_RUNNER = dart run build_runner
FLAGS = --delete-conflicting-outputs

#  Run the app
run:
	flutter run

#  Clean & reinstall dependencies
clean:
	flutter clean
	flutter pub get

# Full reset: clean, pub get, build_runner, 
fresh:
	flutter clean
	flutter pub get
	$(BUILD_RUNNER) build $(FLAGS)
	dart fix --apply
	

#  Code generation (build_runner)
runner:
	$(BUILD_RUNNER) build $(FLAGS)

#  Watch mode for codeGen
watch:
	$(BUILD_RUNNER) watch $(FLAGS)

#  Build APK 
apk:
	flutter pub get
	$(BUILD_RUNNER) build $(FLAGS)
	flutter build apk 

#  Build iOS 
ios:
	flutter pub get
	$(BUILD_RUNNER) build $(FLAGS)
	flutter build ios --debug

#  Run unit/widget tests
test:
	flutter test

#  Lint the project
lint:
	flutter analyze

#  Format code
format:
	dart format lib test

#  Check everything before commit
check: clean lint test format