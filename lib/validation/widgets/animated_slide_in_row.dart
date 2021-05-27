import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:livi_bank_test/common/widgets/circle_button.dart';
import 'package:livi_bank_test/common/model/phone_validation_result.dart';

class AnimatedSlideInRow extends StatefulWidget {
  final Key key;
  final int index;
  final PhoneValidationResult phoneValidationResult;
  final Function(int) onTapRemove;

  AnimatedSlideInRow(
      this.key, this.index, this.phoneValidationResult, this.onTapRemove)
      : super(key: key);
  @override
  _AnimatedSlideInRowState createState() => _AnimatedSlideInRowState();
}

class _AnimatedSlideInRowState extends State<AnimatedSlideInRow>
    with TickerProviderStateMixin {
  late Animation<Offset> _animation;
  late Animation<Offset> _animation2;
  late AnimationController _controller;
  late AnimationController _controller2;

  final double _height = 50.0;
  bool _isOnLeft = false;

  String _dateFormatter({required DateTime date}) {
    final DateFormat formatter = DateFormat('dd MMMM, yyyy');
    return formatter.format(date).toUpperCase();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  Widget _bodyTextStyle({required String title}) {
    return Expanded(
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w400),
      ),
    );
  }

  Animation<Offset> _tweenOffset({
    required Offset begin,
    required Offset end,
    required AnimationController controller,
  }) {
    return Tween<Offset>(
      begin: begin,
      end: end,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.linearToEaseOut,
    ));
  }

  AnimationController _controllerInit() {
    return AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  Decoration _borderDecoration({Color color = Colors.grey}) {
    return BoxDecoration(
      color: color.withOpacity(0.25),
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = _controllerInit()..forward();
    _animation = _tweenOffset(
      begin: Offset(1.0, 0.0),
      end: Offset(0.0, 0.0),
      controller: _controller,
    );

    _controller2 = _controllerInit();
    _animation2 = _tweenOffset(
      begin: Offset(2.0, 0.0),
      end: Offset(2.0, 0.0),
      controller: _controller2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          SlideTransition(
            position: _animation,
            transformHitTests: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Container(
                height: _height,
                decoration: _borderDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _bodyTextStyle(
                      title: _dateFormatter(
                        date: widget.phoneValidationResult.createdDate!,
                      ),
                    ),
                    _bodyTextStyle(
                      title: widget.phoneValidationResult.code!,
                    ),
                    _bodyTextStyle(
                      title: widget.phoneValidationResult.dialCode!,
                    ),
                    _bodyTextStyle(
                      title: widget.phoneValidationResult.phoneNumber == null
                          ? ""
                          : widget.phoneValidationResult.phoneNumber!,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: CircleButton(
                            size: Size(50, 50),
                            bgColor: Colors.white,
                            iconData: widget.phoneValidationResult.isValid
                                ? Icons.check
                                : Icons.close_rounded,
                            iconColor: widget.phoneValidationResult.isValid
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SlideTransition(
            position: _animation2,
            transformHitTests: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: GestureDetector(
                onTap: () => widget.onTapRemove(widget.index),
                child: Container(
                  decoration: _borderDecoration(color: Colors.red),
                  width: MediaQuery.of(context).size.width / 2,
                  height: _height,
                  child: Center(
                    child: Text(
                      "Remove",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                if (mounted) {
                  if (details.primaryDelta!.isNegative) {
                    setState(() {
                      _controller.forward();
                      _animation = _tweenOffset(
                        begin: Offset(0.0, 0.0),
                        end: Offset(-0.5, 0.0),
                        controller: _controller,
                      );

                      _controller2.forward();
                      _animation2 = _tweenOffset(
                        begin: Offset(2.0, 0.0),
                        end: Offset(1.0, 0.0),
                        controller: _controller2,
                      );
                      _isOnLeft = true;
                    });
                  } else {
                    setState(
                      () {
                        _controller.forward();
                        _animation = _tweenOffset(
                          begin: Offset(-0.5, 0.0),
                          end: Offset(0.0, 0.0),
                          controller: _controller,
                        );

                        if (_isOnLeft) {
                          _controller2.forward();
                          _animation2 = _tweenOffset(
                            begin: Offset(1.0, 0.0),
                            end: Offset(2.0, 0.0),
                            controller: _controller2,
                          );
                        }
                      },
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
