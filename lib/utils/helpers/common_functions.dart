class CommonFunctions {
  String getYearFromDate(String date) {
    if (date != '') {
      DateTime parseDt = DateTime.parse(date);
      return (parseDt.year).toString();
    } else {
      return '';
    }
  }
}
