// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'planned_places_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PlannedPlacesEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(Place placePlanned) remove,
    required TResult Function(Place placePlanned) add,
    required TResult Function(int draggedPlaceId, int targetPlaceId) swipe,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(Place placePlanned)? remove,
    TResult? Function(Place placePlanned)? add,
    TResult? Function(int draggedPlaceId, int targetPlaceId)? swipe,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(Place placePlanned)? remove,
    TResult Function(Place placePlanned)? add,
    TResult Function(int draggedPlaceId, int targetPlaceId)? swipe,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_load value) load,
    required TResult Function(_Remove value) remove,
    required TResult Function(_Add value) add,
    required TResult Function(_Swipe value) swipe,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_load value)? load,
    TResult? Function(_Remove value)? remove,
    TResult? Function(_Add value)? add,
    TResult? Function(_Swipe value)? swipe,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_load value)? load,
    TResult Function(_Remove value)? remove,
    TResult Function(_Add value)? add,
    TResult Function(_Swipe value)? swipe,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlannedPlacesEventCopyWith<$Res> {
  factory $PlannedPlacesEventCopyWith(
          PlannedPlacesEvent value, $Res Function(PlannedPlacesEvent) then) =
      _$PlannedPlacesEventCopyWithImpl<$Res, PlannedPlacesEvent>;
}

/// @nodoc
class _$PlannedPlacesEventCopyWithImpl<$Res, $Val extends PlannedPlacesEvent>
    implements $PlannedPlacesEventCopyWith<$Res> {
  _$PlannedPlacesEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_loadCopyWith<$Res> {
  factory _$$_loadCopyWith(_$_load value, $Res Function(_$_load) then) =
      __$$_loadCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_loadCopyWithImpl<$Res>
    extends _$PlannedPlacesEventCopyWithImpl<$Res, _$_load>
    implements _$$_loadCopyWith<$Res> {
  __$$_loadCopyWithImpl(_$_load _value, $Res Function(_$_load) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_load implements _load {
  const _$_load();

  @override
  String toString() {
    return 'PlannedPlacesEvent.load()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_load);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(Place placePlanned) remove,
    required TResult Function(Place placePlanned) add,
    required TResult Function(int draggedPlaceId, int targetPlaceId) swipe,
  }) {
    return load();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(Place placePlanned)? remove,
    TResult? Function(Place placePlanned)? add,
    TResult? Function(int draggedPlaceId, int targetPlaceId)? swipe,
  }) {
    return load?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(Place placePlanned)? remove,
    TResult Function(Place placePlanned)? add,
    TResult Function(int draggedPlaceId, int targetPlaceId)? swipe,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_load value) load,
    required TResult Function(_Remove value) remove,
    required TResult Function(_Add value) add,
    required TResult Function(_Swipe value) swipe,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_load value)? load,
    TResult? Function(_Remove value)? remove,
    TResult? Function(_Add value)? add,
    TResult? Function(_Swipe value)? swipe,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_load value)? load,
    TResult Function(_Remove value)? remove,
    TResult Function(_Add value)? add,
    TResult Function(_Swipe value)? swipe,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class _load implements PlannedPlacesEvent {
  const factory _load() = _$_load;
}

/// @nodoc
abstract class _$$_RemoveCopyWith<$Res> {
  factory _$$_RemoveCopyWith(_$_Remove value, $Res Function(_$_Remove) then) =
      __$$_RemoveCopyWithImpl<$Res>;
  @useResult
  $Res call({Place placePlanned});
}

/// @nodoc
class __$$_RemoveCopyWithImpl<$Res>
    extends _$PlannedPlacesEventCopyWithImpl<$Res, _$_Remove>
    implements _$$_RemoveCopyWith<$Res> {
  __$$_RemoveCopyWithImpl(_$_Remove _value, $Res Function(_$_Remove) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? placePlanned = null,
  }) {
    return _then(_$_Remove(
      placePlanned: null == placePlanned
          ? _value.placePlanned
          : placePlanned // ignore: cast_nullable_to_non_nullable
              as Place,
    ));
  }
}

/// @nodoc

class _$_Remove implements _Remove {
  const _$_Remove({required this.placePlanned});

  @override
  final Place placePlanned;

  @override
  String toString() {
    return 'PlannedPlacesEvent.remove(placePlanned: $placePlanned)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Remove &&
            (identical(other.placePlanned, placePlanned) ||
                other.placePlanned == placePlanned));
  }

  @override
  int get hashCode => Object.hash(runtimeType, placePlanned);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RemoveCopyWith<_$_Remove> get copyWith =>
      __$$_RemoveCopyWithImpl<_$_Remove>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(Place placePlanned) remove,
    required TResult Function(Place placePlanned) add,
    required TResult Function(int draggedPlaceId, int targetPlaceId) swipe,
  }) {
    return remove(placePlanned);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(Place placePlanned)? remove,
    TResult? Function(Place placePlanned)? add,
    TResult? Function(int draggedPlaceId, int targetPlaceId)? swipe,
  }) {
    return remove?.call(placePlanned);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(Place placePlanned)? remove,
    TResult Function(Place placePlanned)? add,
    TResult Function(int draggedPlaceId, int targetPlaceId)? swipe,
    required TResult orElse(),
  }) {
    if (remove != null) {
      return remove(placePlanned);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_load value) load,
    required TResult Function(_Remove value) remove,
    required TResult Function(_Add value) add,
    required TResult Function(_Swipe value) swipe,
  }) {
    return remove(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_load value)? load,
    TResult? Function(_Remove value)? remove,
    TResult? Function(_Add value)? add,
    TResult? Function(_Swipe value)? swipe,
  }) {
    return remove?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_load value)? load,
    TResult Function(_Remove value)? remove,
    TResult Function(_Add value)? add,
    TResult Function(_Swipe value)? swipe,
    required TResult orElse(),
  }) {
    if (remove != null) {
      return remove(this);
    }
    return orElse();
  }
}

abstract class _Remove implements PlannedPlacesEvent {
  const factory _Remove({required final Place placePlanned}) = _$_Remove;

  Place get placePlanned;
  @JsonKey(ignore: true)
  _$$_RemoveCopyWith<_$_Remove> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_AddCopyWith<$Res> {
  factory _$$_AddCopyWith(_$_Add value, $Res Function(_$_Add) then) =
      __$$_AddCopyWithImpl<$Res>;
  @useResult
  $Res call({Place placePlanned});
}

/// @nodoc
class __$$_AddCopyWithImpl<$Res>
    extends _$PlannedPlacesEventCopyWithImpl<$Res, _$_Add>
    implements _$$_AddCopyWith<$Res> {
  __$$_AddCopyWithImpl(_$_Add _value, $Res Function(_$_Add) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? placePlanned = null,
  }) {
    return _then(_$_Add(
      placePlanned: null == placePlanned
          ? _value.placePlanned
          : placePlanned // ignore: cast_nullable_to_non_nullable
              as Place,
    ));
  }
}

/// @nodoc

class _$_Add implements _Add {
  const _$_Add({required this.placePlanned});

  @override
  final Place placePlanned;

  @override
  String toString() {
    return 'PlannedPlacesEvent.add(placePlanned: $placePlanned)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Add &&
            (identical(other.placePlanned, placePlanned) ||
                other.placePlanned == placePlanned));
  }

  @override
  int get hashCode => Object.hash(runtimeType, placePlanned);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AddCopyWith<_$_Add> get copyWith =>
      __$$_AddCopyWithImpl<_$_Add>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(Place placePlanned) remove,
    required TResult Function(Place placePlanned) add,
    required TResult Function(int draggedPlaceId, int targetPlaceId) swipe,
  }) {
    return add(placePlanned);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(Place placePlanned)? remove,
    TResult? Function(Place placePlanned)? add,
    TResult? Function(int draggedPlaceId, int targetPlaceId)? swipe,
  }) {
    return add?.call(placePlanned);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(Place placePlanned)? remove,
    TResult Function(Place placePlanned)? add,
    TResult Function(int draggedPlaceId, int targetPlaceId)? swipe,
    required TResult orElse(),
  }) {
    if (add != null) {
      return add(placePlanned);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_load value) load,
    required TResult Function(_Remove value) remove,
    required TResult Function(_Add value) add,
    required TResult Function(_Swipe value) swipe,
  }) {
    return add(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_load value)? load,
    TResult? Function(_Remove value)? remove,
    TResult? Function(_Add value)? add,
    TResult? Function(_Swipe value)? swipe,
  }) {
    return add?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_load value)? load,
    TResult Function(_Remove value)? remove,
    TResult Function(_Add value)? add,
    TResult Function(_Swipe value)? swipe,
    required TResult orElse(),
  }) {
    if (add != null) {
      return add(this);
    }
    return orElse();
  }
}

abstract class _Add implements PlannedPlacesEvent {
  const factory _Add({required final Place placePlanned}) = _$_Add;

  Place get placePlanned;
  @JsonKey(ignore: true)
  _$$_AddCopyWith<_$_Add> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_SwipeCopyWith<$Res> {
  factory _$$_SwipeCopyWith(_$_Swipe value, $Res Function(_$_Swipe) then) =
      __$$_SwipeCopyWithImpl<$Res>;
  @useResult
  $Res call({int draggedPlaceId, int targetPlaceId});
}

/// @nodoc
class __$$_SwipeCopyWithImpl<$Res>
    extends _$PlannedPlacesEventCopyWithImpl<$Res, _$_Swipe>
    implements _$$_SwipeCopyWith<$Res> {
  __$$_SwipeCopyWithImpl(_$_Swipe _value, $Res Function(_$_Swipe) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? draggedPlaceId = null,
    Object? targetPlaceId = null,
  }) {
    return _then(_$_Swipe(
      draggedPlaceId: null == draggedPlaceId
          ? _value.draggedPlaceId
          : draggedPlaceId // ignore: cast_nullable_to_non_nullable
              as int,
      targetPlaceId: null == targetPlaceId
          ? _value.targetPlaceId
          : targetPlaceId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_Swipe implements _Swipe {
  const _$_Swipe({required this.draggedPlaceId, required this.targetPlaceId});

  @override
  final int draggedPlaceId;
  @override
  final int targetPlaceId;

  @override
  String toString() {
    return 'PlannedPlacesEvent.swipe(draggedPlaceId: $draggedPlaceId, targetPlaceId: $targetPlaceId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Swipe &&
            (identical(other.draggedPlaceId, draggedPlaceId) ||
                other.draggedPlaceId == draggedPlaceId) &&
            (identical(other.targetPlaceId, targetPlaceId) ||
                other.targetPlaceId == targetPlaceId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, draggedPlaceId, targetPlaceId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SwipeCopyWith<_$_Swipe> get copyWith =>
      __$$_SwipeCopyWithImpl<_$_Swipe>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(Place placePlanned) remove,
    required TResult Function(Place placePlanned) add,
    required TResult Function(int draggedPlaceId, int targetPlaceId) swipe,
  }) {
    return swipe(draggedPlaceId, targetPlaceId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(Place placePlanned)? remove,
    TResult? Function(Place placePlanned)? add,
    TResult? Function(int draggedPlaceId, int targetPlaceId)? swipe,
  }) {
    return swipe?.call(draggedPlaceId, targetPlaceId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(Place placePlanned)? remove,
    TResult Function(Place placePlanned)? add,
    TResult Function(int draggedPlaceId, int targetPlaceId)? swipe,
    required TResult orElse(),
  }) {
    if (swipe != null) {
      return swipe(draggedPlaceId, targetPlaceId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_load value) load,
    required TResult Function(_Remove value) remove,
    required TResult Function(_Add value) add,
    required TResult Function(_Swipe value) swipe,
  }) {
    return swipe(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_load value)? load,
    TResult? Function(_Remove value)? remove,
    TResult? Function(_Add value)? add,
    TResult? Function(_Swipe value)? swipe,
  }) {
    return swipe?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_load value)? load,
    TResult Function(_Remove value)? remove,
    TResult Function(_Add value)? add,
    TResult Function(_Swipe value)? swipe,
    required TResult orElse(),
  }) {
    if (swipe != null) {
      return swipe(this);
    }
    return orElse();
  }
}

abstract class _Swipe implements PlannedPlacesEvent {
  const factory _Swipe(
      {required final int draggedPlaceId,
      required final int targetPlaceId}) = _$_Swipe;

  int get draggedPlaceId;
  int get targetPlaceId;
  @JsonKey(ignore: true)
  _$$_SwipeCopyWith<_$_Swipe> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PlannedPlacesState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Place> favoritePlaces) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Place> favoritePlaces)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Place> favoritePlaces)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlannedPlacesStateCopyWith<$Res> {
  factory $PlannedPlacesStateCopyWith(
          PlannedPlacesState value, $Res Function(PlannedPlacesState) then) =
      _$PlannedPlacesStateCopyWithImpl<$Res, PlannedPlacesState>;
}

/// @nodoc
class _$PlannedPlacesStateCopyWithImpl<$Res, $Val extends PlannedPlacesState>
    implements $PlannedPlacesStateCopyWith<$Res> {
  _$PlannedPlacesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_LoadingCopyWith<$Res> {
  factory _$$_LoadingCopyWith(
          _$_Loading value, $Res Function(_$_Loading) then) =
      __$$_LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_LoadingCopyWithImpl<$Res>
    extends _$PlannedPlacesStateCopyWithImpl<$Res, _$_Loading>
    implements _$$_LoadingCopyWith<$Res> {
  __$$_LoadingCopyWithImpl(_$_Loading _value, $Res Function(_$_Loading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Loading extends _Loading {
  const _$_Loading() : super._();

  @override
  String toString() {
    return 'PlannedPlacesState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Place> favoritePlaces) loaded,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Place> favoritePlaces)? loaded,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Place> favoritePlaces)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading extends PlannedPlacesState {
  const factory _Loading() = _$_Loading;
  const _Loading._() : super._();
}

/// @nodoc
abstract class _$$_LoadedCopyWith<$Res> {
  factory _$$_LoadedCopyWith(_$_Loaded value, $Res Function(_$_Loaded) then) =
      __$$_LoadedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Place> favoritePlaces});
}

/// @nodoc
class __$$_LoadedCopyWithImpl<$Res>
    extends _$PlannedPlacesStateCopyWithImpl<$Res, _$_Loaded>
    implements _$$_LoadedCopyWith<$Res> {
  __$$_LoadedCopyWithImpl(_$_Loaded _value, $Res Function(_$_Loaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? favoritePlaces = null,
  }) {
    return _then(_$_Loaded(
      favoritePlaces: null == favoritePlaces
          ? _value._favoritePlaces
          : favoritePlaces // ignore: cast_nullable_to_non_nullable
              as List<Place>,
    ));
  }
}

/// @nodoc

class _$_Loaded extends _Loaded {
  const _$_Loaded({required final List<Place> favoritePlaces})
      : _favoritePlaces = favoritePlaces,
        super._();

  final List<Place> _favoritePlaces;
  @override
  List<Place> get favoritePlaces {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_favoritePlaces);
  }

  @override
  String toString() {
    return 'PlannedPlacesState.loaded(favoritePlaces: $favoritePlaces)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Loaded &&
            const DeepCollectionEquality()
                .equals(other._favoritePlaces, _favoritePlaces));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_favoritePlaces));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LoadedCopyWith<_$_Loaded> get copyWith =>
      __$$_LoadedCopyWithImpl<_$_Loaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Place> favoritePlaces) loaded,
  }) {
    return loaded(favoritePlaces);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Place> favoritePlaces)? loaded,
  }) {
    return loaded?.call(favoritePlaces);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Place> favoritePlaces)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(favoritePlaces);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded extends PlannedPlacesState {
  const factory _Loaded({required final List<Place> favoritePlaces}) =
      _$_Loaded;
  const _Loaded._() : super._();

  List<Place> get favoritePlaces;
  @JsonKey(ignore: true)
  _$$_LoadedCopyWith<_$_Loaded> get copyWith =>
      throw _privateConstructorUsedError;
}
