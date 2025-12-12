import 'package:flutter_riverpod/legacy.dart';

import 'package:my_portfolio/domain/entities/project.dart';

final projectProvider = StateProvider.autoDispose<Project?>((_) => null);