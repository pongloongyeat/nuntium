part of '../pages.dart';

enum _LandingPageCarousel { item1, item2, item3 }

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool _hasReachedEnd = false;

  final _controller = CarouselSliderController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Expanded(
              flex: 4,
              child: CarouselSlider.autoSlide(
                slideAfter: const Duration(seconds: 7),
                controller: _controller,
                onPageChanged: (index) => setState(
                  () => _hasReachedEnd = _hasReachedEnd ||
                      index == _LandingPageCarousel.values.last.index,
                ),
                children: _LandingPageCarousel.values
                    .map(
                      (e) => CarouselCard(
                        child: Container(
                          color: switch (e) {
                            _LandingPageCarousel.item1 => Colors.red,
                            _LandingPageCarousel.item2 => Colors.yellow,
                            _LandingPageCarousel.item3 => Colors.green,
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 40),
            CarouselSliderIndicator(
              length: _LandingPageCarousel.values.length,
              currentIndex: _controller.index,
            ),
            const SizedBox(height: 32),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 80),
              child: Text('First to know', style: AppTextStyles.heading1),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 80),
              child: Text(
                'All news in one place, be the first to know last news',
                style: AppTextStyles.caption,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20)
                  .copyWith(bottom: 16),
              child: AppButton.text(
                _hasReachedEnd ? 'Get Started' : 'Next',
                style: AppButtonStyle.primary,
                onPressed: () {
                  if (!_hasReachedEnd) {
                    _controller.nextPage(
                      duration: CarouselSlider.defaultSlideDuration,
                      curve: CarouselSlider.defaultSlideCurve,
                    );
                    return;
                  }

                  // TODO: push to login
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
