import 'package:credit_cards/credit_cards.dart';
import 'package:credit_cards/credit_cards_details.dart';
import 'package:flutter/material.dart';
import 'credit_card_widget.dart';

// ignore: must_be_immutable
class CreditCardConceptPage extends StatelessWidget {
  final pageNotifier = ValueNotifier(0);
  int _lastPage = 0;

  CreditCardConceptPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const padding = EdgeInsets.all(18.0);
    return Theme(
      data: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bank Cards',
                    style: textTheme.headlineMedium!.copyWith(
                      color: const Color.fromARGB(255, 255, 17, 0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Balance',
                    style: textTheme.titleSmall!.copyWith(
                      color: Colors.grey[350],
                    ),
                  ),
                  const SizedBox(height: 3),
                  ValueListenableBuilder<int>(
                    valueListenable: pageNotifier,
                    builder: (context, snapshot, _) {
                      final currentCard = creditCards[snapshot];
                      final lastCard = creditCards[_lastPage];
                      return TweenAnimationBuilder<double>(
                        tween: Tween<double>(
                          begin: lastCard.amount,
                          end: currentCard.amount,
                        ),
                        duration: const Duration(milliseconds: 500),
                        builder: (_, value, ___) => Text(
                          value.toStringAsFixed(2),
                          style: textTheme.titleLarge!.copyWith(
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                onPageChanged: (page) {
                  _lastPage = pageNotifier.value;
                  pageNotifier.value = page;
                },
                controller: PageController(
                  viewportFraction: 0.7,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: creditCards.length,
                itemBuilder: (_, index) => Align(
                  child: Transform.translate(
                    offset: const Offset(-30.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: CreditCardWidget(
                        onTap: () {
                          final page = CreditCardsConceptDetailPage(
                            card: creditCards[index],
                          );
                          Navigator.of(context).push(
                            PageRouteBuilder<Null>(
                              pageBuilder: (BuildContext context,
                                  Animation<double> animation, _) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: page,
                                );
                              },
                              transitionDuration:
                                  const Duration(milliseconds: 900),
                            ),
                          );
                        },
                        card: creditCards[index],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 150,
            ),
          ],
        ),
      ),
    );
  }
}
