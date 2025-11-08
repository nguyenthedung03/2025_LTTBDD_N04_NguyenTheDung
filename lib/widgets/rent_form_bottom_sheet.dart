import 'package:flutter/material.dart';

class RentFormBottomSheet extends StatefulWidget {
  @override
  _RentFormBottomSheetState createState() =>
      _RentFormBottomSheetState();
}

class _RentFormBottomSheetState
    extends State<RentFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController =
      TextEditingController();
  final _phoneController =
      TextEditingController();
  final _daysController =
      TextEditingController(text: '1');

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _daysController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ??
        false) {
      // In a real app you'd send this to a backend or payment flow.
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(
        content: Text(
            'Thanh toán thành công — Cảm ơn bạn!'),
      ));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Padding(
      padding: EdgeInsets.only(
          bottom: mq.viewInsets.bottom,
          left: 16,
          right: 16,
          top: 12),
      child: Container(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context)
                    .size
                    .height *
                0.75),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(16)),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 8),
              Center(
                child: Container(
                  width: 60,
                  height: 4,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius:
                          BorderRadius.circular(
                              2)),
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Thông tin thuê xe',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(
                        vertical: 12.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller:
                            _nameController,
                        decoration:
                            InputDecoration(
                          labelText: 'Họ và tên',
                          border:
                              OutlineInputBorder(),
                        ),
                        validator: (v) => (v ==
                                    null ||
                                v.trim().isEmpty)
                            ? 'Vui lòng nhập họ tên'
                            : null,
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        controller:
                            _emailController,
                        decoration:
                            InputDecoration(
                          labelText: 'Email',
                          border:
                              OutlineInputBorder(),
                        ),
                        validator: (v) {
                          if (v == null ||
                              v.trim().isEmpty)
                            return 'Vui lòng nhập email';
                          final emailReg = RegExp(
                              r"^[^@\s]+@[^@\s]+\.[^@\s]+$");
                          if (!emailReg
                              .hasMatch(v))
                            return 'Email không hợp lệ';
                          return null;
                        },
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        controller:
                            _phoneController,
                        keyboardType:
                            TextInputType.phone,
                        decoration:
                            InputDecoration(
                          labelText:
                              'Số điện thoại',
                          border:
                              OutlineInputBorder(),
                        ),
                        validator: (v) => (v ==
                                    null ||
                                v.trim().isEmpty)
                            ? 'Vui lòng nhập số điện thoại'
                            : null,
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        controller:
                            _daysController,
                        keyboardType:
                            TextInputType.number,
                        decoration:
                            InputDecoration(
                          labelText:
                              'Số ngày thuê',
                          border:
                              OutlineInputBorder(),
                        ),
                        validator: (v) {
                          if (v == null ||
                              v.trim().isEmpty)
                            return 'Vui lòng nhập số ngày';
                          final n =
                              int.tryParse(v);
                          if (n == null || n <= 0)
                            return 'Số ngày không hợp lệ';
                          return null;
                        },
                      ),
                      SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton
                              .styleFrom(
                            backgroundColor:
                                Colors.deepPurple,
                            padding: EdgeInsets
                                .symmetric(
                                    vertical: 14),
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                          10),
                            ),
                          ),
                          onPressed: _submit,
                          child: Text(
                            'Thanh toán',
                            style: TextStyle(
                                fontSize: 16,
                                color:
                                    Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 18),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
