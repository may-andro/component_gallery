import 'package:component_gallery/model/component.dart';
import 'package:component_gallery/model/component_group.dart';
import 'package:component_gallery/pages/dashboard/widget/component_search_list_widget.dart';
import 'package:component_gallery/widgets/mobile_phone_widget.dart';
import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rxdart/rxdart.dart';

const _componentWidgetFlex = 3;
const _previewWidgetFlex = 6;
const _dividerThickness = 2.0;
const _screenPadding = 16.0;

class _ViewModel {
  _ViewModel(this._selectedComponentGroup) {
    _selectedComponentGroupSink.add(this._selectedComponentGroup);
  }

  ComponentGroup _selectedComponentGroup;

  final _selectedComponentGroupSubject = BehaviorSubject<ComponentGroup>();

  Stream<ComponentGroup> get selectedComponentGroupStream => _selectedComponentGroupSubject.stream;

  Sink<ComponentGroup> get _selectedComponentGroupSink => _selectedComponentGroupSubject.sink;

  ComponentGroup get selectedComponentGroup => _selectedComponentGroup;

  setSelectedComponentGroup(ComponentGroup componentGroup) {
    if (componentGroup.category != _selectedComponentGroup.category) {
      _selectedComponentGroup = componentGroup;
      _selectedComponentGroupSink.add(componentGroup);
    }
  }

  bool isSelected(ComponentGroup componentGroup) {
    return componentGroup.category == _selectedComponentGroup.category;
  }

  dispose() {
    _selectedComponentGroupSubject.close();
  }
}

class DesktopDashboardWidget extends StatefulWidget {
  const DesktopDashboardWidget({
    Key? key,
    required this.componentGroupList,
    required this.onComponentClick,
  }) : super(key: key);

  final List<ComponentGroup> componentGroupList;
  final Function(Component)? onComponentClick;

  @override
  _DesktopDashboardWidgetState createState() => _DesktopDashboardWidgetState();
}

class _DesktopDashboardWidgetState extends State<DesktopDashboardWidget> {
  late _ViewModel _viewModel;

  @override
  void initState() {
    _viewModel = _ViewModel(widget.componentGroupList[0]);
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      right: false,
      child: StreamBuilder<ComponentGroup>(
          stream: _viewModel.selectedComponentGroupStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            if (snapshot.hasError || snapshot.data == null) {
              return Container(
                color: Colors.red,
              );
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: _componentWidgetFlex,
                  child: _buildComponentGroupList(),
                ),
                Expanded(
                  flex: _previewWidgetFlex,
                  child: _buildPreviewView(context, snapshot.data ?? _viewModel.selectedComponentGroup),
                ),
              ],
            );
          }),
    );
  }

  Widget _buildPreviewView(BuildContext context, ComponentGroup componentGroup) {
    return _ComponentPreview(
      componentGroup: componentGroup,
    );
  }

  Widget _buildComponentGroupList() {
    return ComponentSearchListWidget(
      componentGroupList: widget.componentGroupList,
      onComponentClick: widget.onComponentClick,
      componentSearchListType: ComponentSearchListType.expandableList,
      onComponentGroupClick: _viewModel.setSelectedComponentGroup,
    );
  }
}

class _ComponentPreview extends StatelessWidget {
  const _ComponentPreview({
    Key? key,
    required this.componentGroup,
  }) : super(key: key);

  final ComponentGroup componentGroup;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _ConfigurationHeader(),
          Divider(thickness: _dividerThickness),
          Expanded(child: _buildMobileView()),
        ],
      ),
    );
  }

  Widget _buildMobileView() {
    return Center(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: ScaffoldMessenger(
              child: MobilePhoneWidget(
                previewWidget: componentGroup.componentPreviewWidget,
                appBarTitle: componentGroup.title,
                deviceInfo: Devices.ios.iPhone11,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: ScaffoldMessenger(
              child: MobilePhoneWidget(
                previewWidget: componentGroup.componentPreviewWidget,
                appBarTitle: componentGroup.title,
                deviceInfo: Devices.android.pixel3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConfigurationHeader extends StatelessWidget {
  const _ConfigurationHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(_screenPadding),
      child: Row(
        children: [
          Spacer(),
          IconButton(
            icon: Icon(
              FontAwesomeIcons.moon,
              color: colorScheme.onSurface,
            ),
            onPressed: () {},
          ),
          SizedBox(width: _screenPadding),
          IconButton(
            icon: Icon(
              FontAwesomeIcons.appStoreIos,
              color: colorScheme.onSurface,
            ),
            onPressed: () {},
          ),
          SizedBox(width: _screenPadding),
          IconButton(
            icon: Icon(
              FontAwesomeIcons.font,
              color: colorScheme.onSurface,
            ),
            onPressed: () {},
          ),
          SizedBox(width: _screenPadding),
          IconButton(
            icon: Icon(
              FontAwesomeIcons.themeco,
              color: colorScheme.onSurface,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
