// Helper function to format date string
String formatDate(String? dateStr) {
  if (dateStr == null || dateStr.isEmpty) return '';

  try {
    DateTime dateTime = DateTime.parse(dateStr);
    // Return date formatted as 'yyyy-MM-dd'
    return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
  } catch (e) {
    return ''; // Return empty string if date parsing fails
  }
}
