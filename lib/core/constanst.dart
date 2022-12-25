import 'package:flutter/material.dart';

const String baseUrl = 'http://127.0.0.1:8000';

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

const String emailRegex =
    r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$";
