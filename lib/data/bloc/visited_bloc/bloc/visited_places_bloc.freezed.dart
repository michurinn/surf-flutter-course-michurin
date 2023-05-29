// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'visited_places_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$VisitedPlacesEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(PlaceVisited visitedPlace) remove,
    required TResult Function(PlaceVisited visitedPlace) add,
    required TResult Function(int draggedPlaceId, int targetPlaceId) swipe,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(PlaceVisited visitedPlace)? remove,
    TResult? Function(PlaceVisited visitedPlace)? add,
    TResult? Function(int draggedPlaceId, int targetPlaceId)? swipe,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(PlaceVisited visitedPlace)? remove,
    TResult Function(PlaceVisited visitedPlace)? add,
    TResult Function(int draggedPlaceId, int targetPlaceId)? swipe,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_Remove value) remove,
    required TResult Function(_Add value) add,
    required TResult Function(_Swipe value) swipe,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_Remove value)? remove,
    TResult? Function(_Add value)? add,
    TResult? Function(_Swipe value)? swipe,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_Remove value)? remove,
    TResult Function(_Add value)? add,
    TResult Function(_Swipe value)? swipe,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VisitedPlacesEventCopyWith<$Res> {
  factory $VisitedPlacesEventCopyWith(
          VisitedPlacesEvent value, $Res Function(VisitedPlacesEvent) then) =
      _$VisitedPlacesEventCopyWithImpl<$Res, VisitedPlacesEvent>;
}

/// @nodoc
class _$VisitedPlacesEventCopyWithImpl<$Res, $Val extends VisitedPlacesEvent>
    implements $VisitedPlacesEventCopyWith<$Res> {
  _$VisitedPlacesEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_LoadCopyWith<$Res> {
  factory _$$_LoadCopyWith(_$_Load value, $Res Function(_$_Load) then) =
      __$$_LoadCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_LoadCopyWithImpl<$Res>
    extends _$VisitedPlacesEventCopyWithImpl<$Res, _$_Load>
    implements _$$_LoadCopyWith<$Res> {
  __$$_LoadCopyWithImpl(_$_Load _value, $Res Function(_$_Load) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Load implements _Load {
  const _$_Load();

  @override
  String toString() {
    return 'VisitedPlacesEvent.load()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Load);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(PlaceVisited visitedPlace) remove,
    required TResult Function(PlaceVisited visitedPlace) add,
    required TResult Function(int draggedPlaceId, int targetPlaceId) swipe,
  }) {
    return load();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(PlaceVisited visitedPlace)? remove,
    TResult? Function(PlaceVisited visitedPlace)? add,
    TResult? Function(int draggedPlaceId, int targetPlaceId)? swipe,
  }) {
    return load?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(PlaceVisited visitedPlace)? remove,
    TResult Function(PlaceVisited visitedPlace)? add,
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
    required TResult Function(_Load value) load,
    required TResult Function(_Remove value) remove,
    required TResult Function(_Add value) add,
    required TResult Function(_Swipe value) swipe,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_Remove value)? remove,
    TResult? Function(_Add value)? add,
    TResult? Function(_Swipe value)? swipe,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
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

abstract class _Load implements VisitedPlacesEvent {
  const factory _Load() = _$_Load;
}

/// @nodoc
abstract class _$$_RemoveCopyWith<$Res> {
  factory _$$_RemoveCopyWith(_$_Remove value, $Res Function(_$_Remove) then) =
      __$$_RemoveCopyWithImpl<$Res>;
  @useResult
  $Res call({PlaceVisited visitedPlace});
}

/// @nodoc
class __$$_RemoveCopyWithImpl<$Res>
    extends _$VisitedPlacesEventCopyWithImpl<$Res, _$_Remove>
    implements _$$_RemoveCopyWith<$Res> {
  __$$_RemoveCopyWithImpl(_$_Remove _value, $Res Function(_$_Remove) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? visitedPlace = null,
  }) {
    return _then(_$_Remove(
      visitedPlace: null == visitedPlace
          ? _value.visitedPlace
          : visitedPlace // ignore: cast_nullable_to_non_nullable
              as PlaceVisited,
    ));
  }
}

/// @nodoc

class _$_Remove implements _Remove {
  const _$_Remove({required this.visitedPlace});

  @override
  final PlaceVisited visitedPlace;

  @override
  String toString() {
    return 'VisitedPlacesEvent.remove(visitedPlace: $visitedPlace)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Remove &&
            (identical(other.visitedPlace, visitedPlace) ||
                other.visitedPlace == visitedPlace));
  }

  @override
  int get hashCode => Object.hash(runtimeType, visitedPlace);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RemoveCopyWith<_$_Remove> get copyWith =>
      __$$_RemoveCopyWithImpl<_$_Remove>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(PlaceVisited visitedPlace) remove,
    required TResult Function(PlaceVisited visitedPlace) add,
    required TResult Function(int draggedPlaceId, int targetPlaceId) swipe,
  }) {
    return remove(visitedPlace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(PlaceVisited visitedPlace)? remove,
    TResult? Function(PlaceVisited visitedPlace)? add,
    TResult? Function(int draggedPlaceId, int targetPlaceId)? swipe,
  }) {
    return remove?.call(visitedPlace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(PlaceVisited visitedPlace)? remove,
    TResult Function(PlaceVisited visitedPlace)? add,
    TResult Function(int draggedPlaceId, int targetPlaceId)? swipe,
    required TResult orElse(),
  }) {
    if (remove != null) {
      return remove(visitedPlace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_Remove value) remove,
    required TResult Function(_Add value) add,
    required TResult Function(_Swipe value) swipe,
  }) {
    return remove(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_Remove value)? remove,
    TResult? Function(_Add value)? add,
    TResult? Function(_Swipe value)? swipe,
  }) {
    return remove?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
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

abstract class _Remove implements VisitedPlacesEvent {
  const factory _Remove({required final PlaceVisited visitedPlace}) = _$_Remove;

  PlaceVisited get visitedPlace;
  @JsonKey(ignore: true)
  _$$_RemoveCopyWith<_$_Remove> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_AddCopyWith<$Res> {
  factory _$$_AddCopyWith(_$_Add value, $Res Function(_$_Add) then) =
      __$$_AddCopyWithImpl<$Res>;
  @useResult
  $Res call({PlaceVisited visitedPlace});
}

/// @nodoc
class __$$_AddCopyWithImpl<$Res>
    extends _$VisitedPlacesEventCopyWithImpl<$Res, _$_Add>
    implements _$$_AddCopyWith<$Res> {
  __$$_AddCopyWithImpl(_$_Add _value, $Res Function(_$_Add) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? visitedPlace = null,
  }) {
    return _then(_$_Add(
      visitedPlace: null == visitedPlace
          ? _value.visitedPlace
          : visitedPlace // ignore: cast_nullable_to_non_nullable
              as PlaceVisited,
    ));
  }
}

/// @nodoc

class _$_Add implements _Add {
  const _$_Add({required this.visitedPlace});

  @override
  final PlaceVisited visitedPlace;

  @override
  String toString() {
    return 'VisitedPlacesEvent.add(visitedPlace: $visitedPlace)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Add &&
            (identical(other.visitedPlace, visitedPlace) ||
                other.visitedPlace == visitedPlace));
  }

  @override
  int get hashCode => Object.hash(runtimeType, visitedPlace);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AddCopyWith<_$_Add> get copyWith =>
      __$$_AddCopyWithImpl<_$_Add>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(PlaceVisited visitedPlace) remove,
    required TResult Function(PlaceVisited visitedPlace) add,
    required TResult Function(int draggedPlaceId, int targetPlaceId) swipe,
  }) {
    return add(visitedPlace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(PlaceVisited visitedPlace)? remove,
    TResult? Function(PlaceVisited visitedPlace)? add,
    TResult? Function(int draggedPlaceId, int targetPlaceId)? swipe,
  }) {
    return add?.call(visitedPlace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(PlaceVisited visitedPlace)? remove,
    TResult Function(PlaceVisited visitedPlace)? add,
    TResult Function(int draggedPlaceId, int targetPlaceId)? swipe,
    required TResult orElse(),
  }) {
    if (add != null) {
      return add(visitedPlace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_Remove value) remove,
    required TResult Function(_Add value) add,
    required TResult Function(_Swipe value) swipe,
  }) {
    return add(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_Remove value)? remove,
    TResult? Function(_Add value)? add,
    TResult? Function(_Swipe value)? swipe,
  }) {
    return add?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
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

abstract class _Add implements VisitedPlacesEvent {
  const factory _Add({required final PlaceVisited visitedPlace}) = _$_Add;

  PlaceVisited get visitedPlace;
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
    extends _$VisitedPlacesEventCopyWithImpl<$Res, _$_Swipe>
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
    return 'VisitedPlacesEvent.swipe(draggedPlaceId: $draggedPlaceId, targetPlaceId: $targetPlaceId)';
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
    required TResult Function(PlaceVisited visitedPlace) remove,
    required TResult Function(PlaceVisited visitedPlace) add,
    required TResult Function(int draggedPlaceId, int targetPlaceId) swipe,
  }) {
    return swipe(draggedPlaceId, targetPlaceId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(PlaceVisited visitedPlace)? remove,
    TResult? Function(PlaceVisited visitedPlace)? add,
    TResult? Function(int draggedPlaceId, int targetPlaceId)? swipe,
  }) {
    return swipe?.call(draggedPlaceId, targetPlaceId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(PlaceVisited visitedPlace)? remove,
    TResult Function(PlaceVisited visitedPlace)? add,
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
    required TResult Function(_Load value) load,
    required TResult Function(_Remove value) remove,
    required TResult Function(_Add value) add,
    required TResult Function(_Swipe value) swipe,
  }) {
    return swipe(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_Remove value)? remove,
    TResult? Function(_Add value)? add,
    TResult? Function(_Swipe value)? swipe,
  }) {
    return swipe?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
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

abstract class _Swipe implements VisitedPlacesEvent {
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
mixin _$VisitedPlacesState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<PlaceVisited> visitedPlaces) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<PlaceVisited> visitedPlaces)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<PlaceVisited> visitedPlaces)? loaded,
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
abstract class $VisitedPlacesStateCopyWith<$Res> {
  factory $VisitedPlacesStateCopyWith(
          VisitedPlacesState value, $Res Function(VisitedPlacesState) then) =
      _$VisitedPlacesStateCopyWithImpl<$Res, VisitedPlacesState>;
}

/// @nodoc
class _$VisitedPlacesStateCopyWithImpl<$Res, $Val extends VisitedPlacesState>
    implements $VisitedPlacesStateCopyWith<$Res> {
  _$VisitedPlacesStateCopyWithImpl(this._value, this._then);

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
    extends _$VisitedPlacesStateCopyWithImpl<$Res, _$_Loading>
    implements _$$_LoadingCopyWith<$Res> {
  __$$_LoadingCopyWithImpl(_$_Loading _value, $Res Function(_$_Loading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Loading implements _Loading {
  const _$_Loading();

  @override
  String toString() {
    return 'VisitedPlacesState.loading()';
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
    required TResult Function(List<PlaceVisited> visitedPlaces) loaded,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<PlaceVisited> visitedPlaces)? loaded,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<PlaceVisited> visitedPlaces)? loaded,
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

abstract class _Loading implements VisitedPlacesState {
  const factory _Loading() = _$_Loading;
}

/// @nodoc
abstract class _$$_LoadedCopyWith<$Res> {
  factory _$$_LoadedCopyWith(_$_Loaded value, $Res Function(_$_Loaded) then) =
      __$$_LoadedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<PlaceVisited> visitedPlaces});
}

/// @nodoc
class __$$_LoadedCopyWithImpl<$Res>
    extends _$VisitedPlacesStateCopyWithImpl<$Res, _$_Loaded>
    implements _$$_LoadedCopyWith<$Res> {
  __$$_LoadedCopyWithImpl(_$_Loaded _value, $Res Function(_$_Loaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? visitedPlaces = null,
  }) {
    return _then(_$_Loaded(
      visitedPlaces: null == visitedPlaces
          ? _value._visitedPlaces
          : visitedPlaces // ignore: cast_nullable_to_non_nullable
              as List<PlaceVisited>,
    ));
  }
}

/// @nodoc

class _$_Loaded implements _Loaded {
  const _$_Loaded({required final List<PlaceVisited> visitedPlaces})
      : _visitedPlaces = visitedPlaces;

  final List<PlaceVisited> _visitedPlaces;
  @override
  List<PlaceVisited> get visitedPlaces {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_visitedPlaces);
  }

  @override
  String toString() {
    return 'VisitedPlacesState.loaded(visitedPlaces: $visitedPlaces)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Loaded &&
            const DeepCollectionEquality()
                .equals(other._visitedPlaces, _visitedPlaces));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_visitedPlaces));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LoadedCopyWith<_$_Loaded> get copyWith =>
      __$$_LoadedCopyWithImpl<_$_Loaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<PlaceVisited> visitedPlaces) loaded,
  }) {
    return loaded(visitedPlaces);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<PlaceVisited> visitedPlaces)? loaded,
  }) {
    return loaded?.call(visitedPlaces);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<PlaceVisited> visitedPlaces)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(visitedPlaces);
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

abstract class _Loaded implements VisitedPlacesState {
  const factory _Loaded({required final List<PlaceVisited> visitedPlaces}) =
      _$_Loaded;

  List<PlaceVisited> get visitedPlaces;
  @JsonKey(ignore: true)
  _$$_LoadedCopyWith<_$_Loaded> get copyWith =>
      throw _privateConstructorUsedError;
}
