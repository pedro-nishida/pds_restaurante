import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/cart_provider.dart';
import '../../utils/app_theme.dart';
import '../../widgets/base_scaffold.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _selectedPayment = 'pix';
  final _cardNumberController = TextEditingController();
  final _cardNameController = TextEditingController();
  final _cardExpiryController = TextEditingController();
  final _cardCvvController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardNameController.dispose();
    _cardExpiryController.dispose();
    _cardCvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Checkout',
      showCartIcon: false,
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {
            return const Center(
              child: Text('Seu carrinho está vazio.'),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Resumo do Pedido', style: Theme.of(context).textTheme.displayMedium),
                const SizedBox(height: AppDimensions.paddingM),
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return ListTile(
                        title: Text(item.product.name),
                        subtitle: Text('Qtd: ${item.quantity} x \$${item.product.price.toStringAsFixed(2)}'),
                        trailing: Text(
                          '\$${(item.product.price * item.quantity).toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.priceGreen,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total:', style: Theme.of(context).textTheme.displaySmall),
                    Text(
                      '\$${cart.totalPrice.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.priceGreen,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.paddingL),
                // Meio de pagamento
                Text('Meio de pagamento:', style: Theme.of(context).textTheme.displaySmall),
                const SizedBox(height: AppDimensions.paddingS),
                Column(
                  children: [
                    RadioListTile<String>(
                      title: const Text('Pix'),
                      value: 'pix',
                      groupValue: _selectedPayment,
                      onChanged: (value) {
                        setState(() {
                          _selectedPayment = value!;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text('Crédito'),
                      value: 'credito',
                      groupValue: _selectedPayment,
                      onChanged: (value) {
                        setState(() {
                          _selectedPayment = value!;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text('Débito'),
                      value: 'debito',
                      groupValue: _selectedPayment,
                      onChanged: (value) {
                        setState(() {
                          _selectedPayment = value!;
                        });
                      },
                    ),
                  ],
                ),
                if (_selectedPayment == 'credito' || _selectedPayment == 'debito') ...[
                  const SizedBox(height: AppDimensions.paddingM),
                  Text('Dados do Cartão', style: Theme.of(context).textTheme.displaySmall),
                  const SizedBox(height: AppDimensions.paddingS),
                  TextFormField(
                    controller: _cardNumberController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Número do Cartão',
                      prefixIcon: Icon(Icons.credit_card),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingS),
                  TextFormField(
                    controller: _cardNameController,
                    decoration: const InputDecoration(
                      labelText: 'Nome impresso',
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingS),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _cardExpiryController,
                          decoration: const InputDecoration(
                            labelText: 'Validade',
                            hintText: 'MM/AA',
                            prefixIcon: Icon(Icons.date_range),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppDimensions.paddingS),
                      Expanded(
                        child: TextFormField(
                          controller: _cardCvvController,
                          decoration: const InputDecoration(
                            labelText: 'CVV',
                            prefixIcon: Icon(Icons.lock),
                          ),
                          obscureText: true,
                        ),
                      ),
                    ],
                  ),
                ],
                if (_selectedPayment == 'pix') ...[
                  const SizedBox(height: AppDimensions.paddingM),
                  Text('Pague com Pix', style: Theme.of(context).textTheme.displaySmall),
                  const SizedBox(height: AppDimensions.paddingS),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(AppDimensions.paddingM),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                      ),
                      child: Icon(
                        Icons.qr_code,
                        size: 120,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingXS),
                  Center(
                    child: Text(
                      'Escaneie o QR Code para pagar com Pix',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
                const SizedBox(height: AppDimensions.paddingL),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Aqui você pode implementar a lógica de finalização
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Pedido finalizado via ${_selectedPayment == 'pix' ? 'Pix' : _selectedPayment == 'credito' ? 'Crédito' : 'Débito'}!'),
                        ),
                      );
                      cart.clearCart();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Finalizar Pedido'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
