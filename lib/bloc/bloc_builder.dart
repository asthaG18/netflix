import 'package:flutter/widgets.dart';

import 'bloc.dart';

class BlocBuilder extends StatelessWidget {
  final Widget Function() builder;
  final Bloc bloc;

  const BlocBuilder({
    Key? key,
    required this.builder,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.strem,
      initialData: bloc.strem,
      builder: (context, snapshot) {
        return builder();
      },
    );
  }
}
