void main() {
  String date = "['2023-12-17 07:33:26.880','2023-12-17 07:33:26.880']";
  List<DateTime> collectedDate = [];

  List<String> dateStrings =
      date.replaceAll("[", "").replaceAll("]", "").split(",");

  for (String dateString in dateStrings) {
    String trimmedDateString = dateString.trim().replaceAll("'", "");
    DateTime dateTime = DateTime.parse(trimmedDateString);
    collectedDate.add(dateTime);
  }
  print(collectedDate);
}
