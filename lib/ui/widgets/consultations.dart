import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedulerapp/constants/app_constants.dart';
import 'package:schedulerapp/domain/user.dart';
import 'package:schedulerapp/services/authentication_service.dart';
import 'package:schedulerapp/ui/views/base.widget.dart';
import 'package:schedulerapp/viewmodels/widgets/consultation_model.dart';

import 'consultationlist_item.dart';

class Consultations extends StatelessWidget {
  const Consultations({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ConsultationModel>(
        model: ConsultationModel(api: Provider.of(context)),
        onModelReady: (model) =>
            model.getConsultations(Provider.of<User>(context).name),
        builder: (context, model, child) => model.busy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: model.consultations.length,
                itemBuilder: (context, index) => ConsultationListItem(
                  consultation: model.consultations[index],
                  onTap: () {
                    Navigator.pushNamed(context, RoutePaths.Consultation,
                        arguments: model.consultations[index]);
                  },
                ),
              ));
  }
}
