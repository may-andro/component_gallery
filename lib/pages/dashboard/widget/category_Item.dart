import 'package:component_gallery/model/component.dart';
import 'package:component_gallery/pages/component_demo/component_demo_page.dart';
import 'package:component_gallery/utils/adaptive.dart';
import 'package:flutter/material.dart';

class CategoryDemoItem extends StatelessWidget {
  const CategoryDemoItem({Key? key, required this.component}) : super(key: key);

  final Component component;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: Theme.of(context).colorScheme.surface,
      child: InkWell(
        onTap: () {
	        print('CategoryDemoItem.build component ${component.title}');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ComponentDemoPage(
                component: component,
              ),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: 32,
            top: 20,
            end: isDisplayDesktop(context) ? 16 : 8,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                component.icon,
                color: colorScheme.primary,
              ),
              const SizedBox(width: 40),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      component.title,
                      style: textTheme.subtitle1?.apply(color: colorScheme.onSurface),
                    ),
                    Text(
                      component.subtitle,
                      style: textTheme.overline?.apply(
                        color: colorScheme.onSurface.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Divider(
                      thickness: 1,
                      height: 1,
                      color: Theme.of(context).colorScheme.background,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
