import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:text_marquee/text_marquee.dart';
import 'package:wonk_app/application/constants/flags_types.dart';
import 'package:wonk_app/application/constants/weekdays.dart';
import 'package:wonk_app/application/extensions/separated_by.dart';
import 'package:wonk_app/domain/enums/enums.dart';
import 'package:wonk_app/domain/models/models.dart';
import 'package:wonk_app/domain/repositories/califications_repository.dart';
import 'package:wonk_app/domain/repositories/flags_repository.dart';
import 'package:wonk_app/domain/services/storage_service.dart';

class StoreModalSheet extends StatefulWidget {
  final Cafes store;

  const StoreModalSheet({super.key, required this.store});

  @override
  State<StoreModalSheet> createState() => _StoreModalSheetState();

  static void show(
    BuildContext context, {
    required Cafes store,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StoreModalSheet(
          store: store,
        );
      },
    );
  }
}

class _StoreModalSheetState extends State<StoreModalSheet> {
  final List<String> images = [];
  final List<Califications> califications = [];
  final List<Flags> flags = [];

  Future<List<String>> getImages() async {
    final result = await GetIt.I<StorageService>().getFilesFromStore(BigInt.from(1));

    return result.fold(
      (l) => [],
      (r) => r,
    );
  }

  Future<List<Califications>> getCalifications() async {
    final result = await GetIt.I<CalificationsRepository>().getCalifications(widget.store.id);

    return result.fold(
      (l) => [],
      (r) => r,
    );
  }

  Future<List<Flags>> getFlags() async {
    final result = await GetIt.I<FlagsRepository>().getFlags(widget.store.id);

    return result.fold(
      (l) => [],
      (r) => r,
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      images.addAll(await getImages());
      califications.addAll(await getCalifications());
      flags.addAll(await getFlags());
      if (mounted) setState(() {});
    });
    super.initState();
  }

  Hours currentHour() {
    final now = DateTime.now();
    final day = weekdays[now.weekday];
    try {
      return (widget.store.openingHours ?? []).firstWhere((element) => element.day == day);
    } catch (e) {
      return Hours(id: BigInt.from(0), day: day);
    }
  }

  bool isOpen() {
    final now = DateTime.now();
    final current = currentHour();
    if (current.openTime == null || current.closeTime == null) {
      return false;
    }
    return now.isAfter(current.openTime!) && now.isBefore(current.closeTime!);
  }

  final Map<CalificationsType, IconData> calificationsIcons = const {
    CalificationsType.coffe: PhosphorIconsRegular.coffeeBean,
    CalificationsType.connectivity: PhosphorIconsRegular.wifiHigh,
    CalificationsType.lights: PhosphorIconsRegular.lightbulb,
    CalificationsType.ambiental: PhosphorIconsRegular.storefront,
  };

  Map<CalificationsType, double> sumarizeCalifications() {
    Map<CalificationsType, double> total = {};

    for (final calification in califications) {
      total.update(
        CalificationsType.fromValue(calification.type),
        (value) => value + calification.rating,
        ifAbsent: () => calification.rating,
      );
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    bool consumition = flags.firstWhereOrNull((e) => e.flag == FlagsTypes.consumition.name) != null;
    bool checked = flags.firstWhereOrNull((e) => e.flag == FlagsTypes.checked.name) != null;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width,
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.textTheme.muted.color,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ShadCard(
                    backgroundColor: theme.cardTheme.border?.bottom.color,
                    title: Container(
                      width: 350,
                      height: 100,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: images.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: images.first,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextMarquee(
                            widget.store.name,
                            spaceSize: 72,
                            style: theme.textTheme.h4,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(PhosphorIconsRegular.mapPin, size: 16, color: theme.textTheme.muted.color),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  widget.store.address,
                                  style: theme.textTheme.muted,
                                ),
                              )
                            ],
                          ),
                          if (currentHour().openTime != null && currentHour().closeTime != null) ...[
                            const SizedBox(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(PhosphorIconsRegular.clock, size: 16, color: theme.textTheme.muted.color),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    '${isOpen() ? "Abierto" : "Cerrado"} ${DateFormat('HH:mm').format(currentHour().openTime!)} - ${DateFormat('HH:mm').format(currentHour().closeTime!)}',
                                    style: theme.textTheme.muted,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                          ]
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ShadCard(
                    width: double.infinity,
                    backgroundColor: theme.cardTheme.border?.bottom.color,
                    title: Text(
                      "Información",
                      style: theme.textTheme.h4,
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: theme.primaryButtonTheme.backgroundColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Icon((!consumition ? PhosphorIconsRegular.bowlFood : PhosphorIconsFill.bowlFood), size: 16, color: theme.primaryButtonTheme.foregroundColor),
                                const SizedBox(width: 8),
                                Text(
                                  consumition ? "Se debe consumir" : "No es necesario consumir",
                                  style: theme.textTheme.small.copyWith(
                                    color: theme.primaryButtonTheme.foregroundColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: theme.primaryButtonTheme.backgroundColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Icon((!checked ? PhosphorIconsRegular.xCircle : PhosphorIconsFill.checkCircle), size: 16, color: theme.primaryButtonTheme.foregroundColor),
                                const SizedBox(width: 8),
                                Text(
                                  checked ? "Verificado" : "No está verificado",
                                  style: theme.textTheme.small.copyWith(
                                    color: theme.primaryButtonTheme.foregroundColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ShadCard(
                    width: double.infinity,
                    title: Text(
                      "Calificaciones",
                      style: theme.textTheme.h4,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: sumarizeCalifications()
                            .entries
                            .map((e) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(calificationsIcons[e.key] ?? PhosphorIconsRegular.star, size: 16, color: theme.textTheme.muted.color),
                                      const SizedBox(width: 8),
                                      Text(
                                        e.key.name,
                                        style: theme.textTheme.muted,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  ShadProgress(value: e.value / califications.length)
                                ],
                              );
                            })
                            .toList()
                            .separatedBy(
                              const SizedBox(height: 18),
                            ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ShadButton(
                  mainAxisAlignment: MainAxisAlignment.start,
                  gap: 24,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(PhosphorIconsRegular.star),
                  child: Text("Calificar sucursal"),
                ),
              ),
              ShadButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(PhosphorIconsRegular.heart),
              ),
            ],
          )
        ],
      ),
    );
  }
}
