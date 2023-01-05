
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:vintedclone/bloc/internet_bloc/internet_bloc.dart';
import 'package:vintedclone/bloc/lang_bloc/lang_bloc.dart';
import 'package:vintedclone/data/service/shared_pref_service.dart';
import 'package:vintedclone/l10n/generated/app_localizations.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/router/route_names.dart';
import 'package:vintedclone/screens/router/router.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.initSharedPref();
  await Firebase.initializeApp();


  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory()
  );

  StreamChatClient client = StreamChatClient(getStreamKey());

  HydratedBlocOverrides.runZoned(
    () => runApp(MyApp(client)),
    storage: storage,
  );
}

class MyApp extends StatefulWidget {

  StreamChatClient client;

  MyApp(this.client);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => InternetBloc()
        ),
        BlocProvider(
          lazy: false,
          create: (context) => LangBloc()
        )
      ],
      child: BlocBuilder<LangBloc, Locale>(
        builder: (context, langState){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Vinted clone',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            locale: langState,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('lt'),
            ],
            initialRoute: RouteNames.splashScreen,
            onGenerateRoute: AppRouter().onGenerateRoute,
          );
        },
      )
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    AppRouter().disposeBlocs();
    super.dispose();
  }
}


