class ProductRating {
  final double averageRating;
  final double? userRating;
  final List<Map<String, dynamic>> ratings;

  ProductRating({
    required this.averageRating,
    this.userRating,
    required this.ratings,
  });

  factory ProductRating.fromJson(Map<String, dynamic> json) {
    return ProductRating(
      averageRating: json['average_rating'] ?? 0.0,
      userRating: json['user_rating'] ?? 0.0,
      ratings: List<Map<String, dynamic>>.from(
          json['ratings'].map((rating) => Map<String, dynamic>.from(rating))),
    );
  }
}
