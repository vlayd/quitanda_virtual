import 'package:flutter/material.dart';
import 'package:quitanda_virtual/src/config/custom_colors.dart';

class OrderStatusWidget extends StatelessWidget {
  final String status;
  final bool isOverdue;
  final Map<String, int> allStatus = <String, int>{
    'pending_payment': 0,
    'refunded': 1,
    'paid': 2,
    'preparing_purchase': 3,
    'shipping': 4,
    'delivered': 5,
  };

  int get currentStatus => allStatus[status]!;

  OrderStatusWidget({
    Key? key,
    required this.status,
    required this.isOverdue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _StatusDot(
          isActive: true,
          title: "Pedido Confirmado",
        ),
        const _CustomDivider(),
        //TODO ...[] significa que está sendo adicionado um item a lista
        if (currentStatus == 1) ...[
          const _StatusDot(
            isActive: true,
            title: "Pix estornado",
            backgroundColor: Colors.orange,
          )
        ] else if (isOverdue) ...[
          const _StatusDot(
            isActive: true,
            title: "Pagamento Pix vencido",
            backgroundColor: Colors.red,
          )
        ] else ...[
          //TODO será true se o currentStatus for o número mostrado
          _StatusDot(isActive: currentStatus>=2, title: "Pagamento"),
          const _CustomDivider(),
          _StatusDot(isActive: currentStatus>=3, title: "Preparando"),
          const _CustomDivider(),
          _StatusDot(isActive: currentStatus>=4, title: "Envio"),
          const _CustomDivider(),
          _StatusDot(isActive: currentStatus==5, title: "Entregue"),
        ],
      ],
    );
  }
}

class _CustomDivider extends StatelessWidget {
  const _CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      height: 10,
      width: 2,
      color: Colors.grey.shade300,
    );
  }
}

class _StatusDot extends StatelessWidget {
  final bool isActive;
  final String title;
  final Color? backgroundColor;

  const _StatusDot({
    Key? key,
    required this.isActive,
    required this.title,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //Dot
        Container(
          alignment: Alignment.center,
          height: 20,
          width: 20,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: CustomColors.customSwatchColor,
              ),
              //TODO caso o bg seja nulo, aí vai ser a colorCustom
              color: isActive
                  ? backgroundColor ?? CustomColors.customSwatchColor
                  : Colors.transparent),
          //shrink é o sizedbox sem largura e altura específica
          child: isActive
              ? const Icon(
                  Icons.check,
                  size: 13,
                  color: Colors.white,
                )
              : const SizedBox.shrink(),
        ),
        const SizedBox(
          width: 5,
        ),
        //Texto TODO o expanded evita que o layout quebre
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
