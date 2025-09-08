import 'product.dart';

/// Represents an order in the system
class Order {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final double totalAmount;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime? completedAt;
  final String? notes;

  Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    this.completedAt,
    this.notes,
  });

  // Convert Order to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
      'status': status.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'notes': notes,
    };
  }

  // Create Order from JSON
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      userId: json['userId'],
      items: (json['items'] as List)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      totalAmount: json['totalAmount'].toDouble(),
      status: OrderStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => OrderStatus.pending,
      ),
      createdAt: DateTime.parse(json['createdAt']),
      completedAt: json['completedAt'] != null 
          ? DateTime.parse(json['completedAt']) 
          : null,
      notes: json['notes'],
    );
  }
}

/// Represents an item within an order
class OrderItem {
  final String productId;
  final String productName;
  final double unitPrice;
  final int quantity;
  final double totalPrice;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.unitPrice,
    required this.quantity,
    required this.totalPrice,
  });

  // Convert OrderItem to JSON
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'unitPrice': unitPrice,
      'quantity': quantity,
      'totalPrice': totalPrice,
    };
  }

  // Create OrderItem from JSON
  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId'],
      productName: json['productName'],
      unitPrice: json['unitPrice'].toDouble(),
      quantity: json['quantity'],
      totalPrice: json['totalPrice'].toDouble(),
    );
  }

  // Create OrderItem from Product and quantity
  factory OrderItem.fromProduct(Product product, int quantity) {
    return OrderItem(
      productId: product.id,
      productName: product.name,
      unitPrice: product.price,
      quantity: quantity,
      totalPrice: product.price * quantity,
    );
  }
}

enum OrderStatus {
  pending,
  preparing,
  ready,
  delivered,
  cancelled,
}
