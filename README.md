# flutterfire

Flutter Firebase example project.

## Commands

```bash
# Generate codes
flutter packages pub run build_runner build --delete-conflicting-outputs
flutter packages pub run build_runner watch

# Install coverage tool
brew install lcov

# Test Coverage
flutter test --coverage
lcov --remove coverage/lcov.info 'lib/**/*.g.dart' -o coverage/lcov.info
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```
