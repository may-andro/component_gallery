import 'package:component_gallery/model/component.dart';
import 'package:component_gallery/model/component_group.dart';
import 'package:component_gallery/model/component_category.dart';
import 'package:component_gallery/pages/component_group_list/component_group_list_page.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum ComponentSearchListType { expandableList, staggeredList }
enum ComponentSortType { asc, desc }

class _ViewModel {
  List<ComponentGroup> _selectedComponentGroupList = [];
  ComponentSortType _componentSortType = ComponentSortType.asc;

  final List<ComponentGroup> _componentGroupList;

  final _selectedComponentGroupListSubject = BehaviorSubject<List<ComponentGroup>>();

  Stream<List<ComponentGroup>> get selectedComponentGroupListStream => _selectedComponentGroupListSubject.stream;

  Sink<List<ComponentGroup>> get selectedComponentGroupListSink => _selectedComponentGroupListSubject.sink;

  final _selectedComponentSortTypeSubject = BehaviorSubject<ComponentSortType>();

  Stream<ComponentSortType> get selectedComponentSortTypeStream => _selectedComponentSortTypeSubject.stream;

  Sink<ComponentSortType> get selectedComponentSortTypeSink => _selectedComponentSortTypeSubject.sink;

  final _selectedComponentGroupSubject = BehaviorSubject<ComponentGroup>();

  Stream<ComponentGroup> get selectedComponentGroupStream => _selectedComponentGroupSubject.stream;

  Sink<ComponentGroup> get selectedComponentGroupTypeSink => _selectedComponentGroupSubject.sink;

  _ViewModel(this._componentGroupList) {
    selectedComponentSortTypeSink.add(_componentSortType);
    onSearchApplied('');
  }

  void onSearchApplied(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      _selectedComponentGroupList = _componentGroupList;
    } else {
      _selectedComponentGroupList = _componentGroupList.where((componentGroup) {
        return componentGroup.title.toLowerCase().contains(enteredKeyword.toLowerCase()) ||
            componentGroup.category.displayTitle().toLowerCase().contains(enteredKeyword.toLowerCase());
      }).toList();
    }
    _applySort();
  }

  void onSortApplied() {
    if (_componentSortType == ComponentSortType.desc) {
      _componentSortType = ComponentSortType.asc;
    } else {
      _componentSortType = ComponentSortType.desc;
    }
    selectedComponentSortTypeSink.add(_componentSortType);
    _applySort();
  }

  void _applySort() {
    _selectedComponentGroupList.sort((item1, item2) {
      return item1.title.toLowerCase().compareTo(item1.title.toLowerCase());
    });

    if (_componentSortType == ComponentSortType.desc) {
      _selectedComponentGroupList = _selectedComponentGroupList.reversed.toList();
    }

    selectedComponentGroupListSink.add(_selectedComponentGroupList);
  }

  dispose() {
    _selectedComponentGroupListSubject.close();
    _selectedComponentSortTypeSubject.close();
    _selectedComponentGroupSubject.close();
  }
}

class ComponentSearchListWidget extends StatefulWidget {
  const ComponentSearchListWidget({
    Key? key,
    required this.componentGroupList,
    required this.onComponentClick,
    required this.componentSearchListType,
    this.onComponentGroupClick,
  }) : super(key: key);

  final List<ComponentGroup> componentGroupList;
  final Function(Component)? onComponentClick;
  final Function(ComponentGroup)? onComponentGroupClick;
  final ComponentSearchListType componentSearchListType;

  @override
  _ComponentSearchListWidgetState createState() => _ComponentSearchListWidgetState();
}

class _ComponentSearchListWidgetState extends State<ComponentSearchListWidget> {
  late _ViewModel _viewModel;

  @override
  void initState() {
    _viewModel = _ViewModel(widget.componentGroupList);
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
      child: Column(
        children: [
          SizedBox(height: 16.0),
          _buildSearchBar(context),
          SizedBox(height: 16.0),
          _buildFilterBar(context),
          SizedBox(height: 16.0),
          Expanded(child: _buildListView(context)),
        ],
      ),
    );
  }

  Widget _buildListView(BuildContext context) {
    return StreamBuilder<List<ComponentGroup>>(
        stream: _viewModel.selectedComponentGroupListStream,
        builder: (context, snapshot) {
          print('snapshot $snapshot');

          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError || snapshot.data == null) {
            return Container(
              color: Colors.red,
            );
          }

          if (snapshot.hasData && snapshot.data?.isEmpty == true) {
            return Container(
              color: Colors.blueGrey,
            );
          }

          switch (widget.componentSearchListType) {
            case ComponentSearchListType.staggeredList:
              return ComponentGroupListPage.staggeredList(
                componentGroupList: snapshot.data ?? widget.componentGroupList,
                onComponentClick: widget.onComponentClick,
              );
            case ComponentSearchListType.expandableList:
              return ComponentGroupListPage.expandableList(
                componentGroupList: snapshot.data ?? widget.componentGroupList,
                onComponentClick: widget.onComponentClick,
                onComponentGroupClick: widget.onComponentGroupClick,
              );
            default:
              throw UnimplementedError();
          }
        });
  }

  Widget _buildSearchBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        onChanged: (value) {
          _viewModel.onSearchApplied(value);
        },
        style: Theme.of(context).textTheme.headline5?.apply(
              color: colorScheme.onSurface,
            ),
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: Theme.of(context).textTheme.headline5?.apply(
                color: colorScheme.onSurface,
              ),
          fillColor: colorScheme.surface,
          filled: true,
          suffixIcon: Padding(
            padding: const EdgeInsets.all(16), //15
            child: Icon(
              Icons.search,
              color: colorScheme.onSurface,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return StreamBuilder<ComponentSortType>(
        stream: _viewModel.selectedComponentSortTypeStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError || snapshot.data == null) {
            return Container(
              color: Colors.red,
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(
                  snapshot.data == ComponentSortType.asc ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                  color: colorScheme.onSurface,
                ),
                SizedBox(width: 5),
                Text(
                  "Sort by name",
                  style: Theme.of(context).textTheme.overline?.apply(
                        color: colorScheme.onSurface,
                      ),
                ),
                Spacer(),
                MaterialButton(
                  minWidth: 20,
                  onPressed: _viewModel.onSortApplied,
                  child: Icon(
                    snapshot.data == ComponentSortType.asc
                        ? FontAwesomeIcons.sortAlphaDown
                        : FontAwesomeIcons.sortAlphaUp,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
