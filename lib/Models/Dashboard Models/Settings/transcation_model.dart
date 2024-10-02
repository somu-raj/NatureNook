class TransactionModel {
  TransactionModel({
    required this.error,
    required this.message,
    required this.total,
    required this.balance,
    required this.data,
  });

  final bool? error;
  final String? message;
  final String? total;
  final String? balance;
  final List<TransactionList> data;

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      error: json["error"],
      message: json["message"],
      total: json["total"],
      balance: json["balance"],
      data: json["data"] == null
          ? []
          : List<TransactionList>.from(
              json["data"]!.map((x) => TransactionList.fromJson(x))),
    );
  }
}

class TransactionList {
  TransactionList({
    required this.id,
    required this.transactionType,
    required this.userId,
    required this.orderId,
    required this.orderItemId,
    required this.type,
    required this.txnId,
    required this.payuTxnId,
    required this.amount,
    required this.status,
    required this.currencyCode,
    required this.payerEmail,
    required this.message,
    required this.transactionDate,
    required this.dateCreated,
    required this.isRefund,
  });

  final String? id;
  final String? transactionType;
  final String? userId;
  final String? orderId;
  final String? orderItemId;
  final String? type;
  final String? txnId;
  final String? payuTxnId;
  final String? amount;
  final String? status;
  final String? currencyCode;
  final String? payerEmail;
  final String? message;
  final DateTime? transactionDate;
  final DateTime? dateCreated;
  final String? isRefund;

  factory TransactionList.fromJson(Map<String, dynamic> json) {
    return TransactionList(
      id: json["id"],
      transactionType: json["transaction_type"],
      userId: json["user_id"],
      orderId: json["order_id"],
      orderItemId: json["order_item_id"],
      type: json["type"],
      txnId: json["txn_id"],
      payuTxnId: json["payu_txn_id"],
      amount: json["amount"],
      status: json["status"],
      currencyCode: json["currency_code"],
      payerEmail: json["payer_email"],
      message: json["message"],
      transactionDate: DateTime.tryParse(json["transaction_date"] ?? ""),
      dateCreated: DateTime.tryParse(json["date_created"] ?? ""),
      isRefund: json["is_refund"],
    );
  }
}
