import 'package:hive/hive.dart';

part 'group.g.dart';

@HiveType(typeId: 1)
class Group extends HiveObject {
  // hivefield key 1 already has been used
  @HiveField(0)
  String name;

  Group({
    required this.name,
  });

}