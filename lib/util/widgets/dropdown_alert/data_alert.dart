class DataAlert {
  DataAlert(this.message, this.title, this.type, {this.payload});
  String message;
  String title;
  TypeAlert type;
  Map<String, dynamic>? payload;
}

// Type of alert
enum TypeAlert { success, error, warning }
