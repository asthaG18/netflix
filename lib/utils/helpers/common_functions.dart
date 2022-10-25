class CommonFunctions {
  String getYearFromDate(String date) {
    if (date != '') {
      DateTime parseDt = DateTime.parse(date);
      return (parseDt.year).toString();
    } else {
      return '';
    }
  }

  String durationToString(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')} hrs ${parts[1].padLeft(2, '0')} mins';
  }
}
