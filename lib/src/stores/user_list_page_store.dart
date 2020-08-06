import 'dart:async';
import 'package:flutterfire/src/services/repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import '../models/user.dart';
import '../services/query_repository.dart';

part 'user_list_page_store.g.dart';

@injectable
class UserListPageStore = _UserListPageStoreBase with _$UserListPageStore;

abstract class _UserListPageStoreBase with Store {
  final QueryRepository _queryRepository;
  final Repository _repository;

  StreamSubscription<List<User>> _userListSub;

  @observable
  ObservableList<User> users = ObservableList<User>();

  @action
  Future delete(String id) async {
    await _repository.delete<User>(id);
    await loadData();
  }

  _UserListPageStoreBase(this._queryRepository, this._repository);

  Future loadData() {
    final completer = new Completer();

    _userListSub?.cancel();
    _userListSub = _queryRepository.getStream<User>(orderBy: 'name').listen((data) {
      users.clear();
      users.addAll(data);
      if (!completer.isCompleted) {
        completer.complete();
      }
    });

    return completer.future;
  }
}
