import 'package:flutter/material.dart';
import 'package:rijksbook/constants.dart';
import 'package:rijksbook/domain.dart';

class ArtMakerItem extends ListTile {
  ArtMakerItem({Key? key, required ArtMaker maker})
      : super(
          key: key,
          leading: CircleAvatar(maxRadius: 32, child: Text(maker.initials)),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(maker.name, maxLines: 2, overflow: TextOverflow.ellipsis),
              AppSpacing.v2,
              if (maker.nationality != null) Text(maker.nationality!),
            ],
          ),
          trailing: const Icon(Icons.description),
          isThreeLine: maker.nationality != null,
          onTap: () {
            // TODO
          },
          horizontalTitleGap: 8,
          subtitle: Text(maker.roles.join(', ')),
          contentPadding: EdgeInsets.zero,
          minVerticalPadding: 0,
        );
}
