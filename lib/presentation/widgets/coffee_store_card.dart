// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:text_marquee/text_marquee.dart';
import 'package:wonk_app/application/constants/weekdays.dart';

import 'package:wonk_app/domain/models/cafes.dart';
import 'package:wonk_app/domain/models/hours.dart';
import 'package:wonk_app/domain/services/storage_service.dart';



class CoffeeStoreCard extends StatefulWidget {
  final Cafes cafe;

  const CoffeeStoreCard({
    super.key,
    required this.cafe,
  });

  @override
  State<CoffeeStoreCard> createState() => _CoffeeStoreCardState();
}

class _CoffeeStoreCardState extends State<CoffeeStoreCard> with AutomaticKeepAliveClientMixin {
  final List<String> images = [];

  Future<List<String>> getImages() async {
    final result = await GetIt.I<StorageService>().getFilesFromStore(BigInt.from(1));

    return result.fold(
      (l) => [],
      (r) => r,
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      images.addAll(await getImages());
      if (mounted) setState(() {});
    });
    super.initState();
  }

  Hours currentHour() {
    final now = DateTime.now();
    final day = weekdays[now.weekday];
    try {
      return (widget.cafe.openingHours ?? []).firstWhere((element) => element.day == day);
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = ShadTheme.of(context);

    return ShadCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      width: 350,
      height: 250,
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
            Hero(
              tag: "${widget.cafe.id}-name",
              child: TextMarquee(
                widget.cafe.name,
                spaceSize: 72,
                style: theme.textTheme.h4,
              ),
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
                    widget.cafe.address,
                    style: theme.textTheme.muted,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
