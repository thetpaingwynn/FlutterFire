import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../mxins/basic_page_feature.dart';
import '../stores/app_store.dart';
import '../stores/user_list_page_store.dart';

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> with BasicPageFeature {
  final _appStore = GetIt.instance.get<AppStore>();
  final _store = GetIt.instance.get<UserListPageStore>();

  @override
  void initState() {
    progressCall(() => _store.loadData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Users'),
          actions: <Widget>[
            IconButton(
              icon: Icon(MdiIcons.logout),
              onPressed: () => progressCall(() => _appStore.signOut()),
            )
          ],
        ),
        body: Observer(
          builder: (_) {
            return Scrollbar(
              child: ListView.separated(
                itemCount: _store.users.length,
                itemBuilder: (_, index) {
                  final user = _store.users[index];
                  return ListTile(
                    title: Text(user.name),
                    subtitle: Text(user.email),
                    trailing: IconButton(
                      icon: Icon(MdiIcons.closeCircle, color: Colors.red),
                      onPressed: () async {
                        if (await confirm('Are you sure you want to delete?')) {
                          progressCall(() => _store.delete(user.id));
                        }
                      },
                    ),
                  );
                },
                separatorBuilder: (_, index) => Divider(height: 1),
              ),
            );
          },
        ),
      ),
      inAsyncCall: inAsyncCall,
    );
  }
}
