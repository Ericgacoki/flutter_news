import 'package:flutter_test/flutter_test.dart';
import 'package:news_api/util/date.dart';

void main() {
  test('formatRelativeDate returns correct relative date strings', () {
    final testDate = DateTime.parse("2023-12-10T00:00:00Z");

    expect(formatRelativeDate("2023-12-10T00:00:00Z", currentDate: testDate),
        'just now');
    expect(formatRelativeDate("2023-12-09T00:00:00Z", currentDate: testDate),
        'yesterday');
    expect(formatRelativeDate("2023-12-03T00:00:00Z", currentDate: testDate),
        'last week');
    expect(formatRelativeDate("2023-11-10T00:00:00Z", currentDate: testDate),
        'last month');
    expect(formatRelativeDate("2023-10-10T00:00:00Z", currentDate: testDate),
        '2 months ago');
    expect(formatRelativeDate("2022-12-10T00:00:00Z", currentDate: testDate),
        'last year');
    expect(formatRelativeDate("2021-12-10T00:00:00Z", currentDate: testDate),
        '2 years ago');
  });
}
