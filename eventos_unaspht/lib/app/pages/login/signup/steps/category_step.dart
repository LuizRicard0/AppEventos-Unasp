import 'package:eventos_unaspht/app/pages/login/signup/components/card_gender.dart';
import 'package:eventos_unaspht/app/pages/login/signup/enums/category_enum.dart';
import 'package:eventos_unaspht/app/pages/login/signup/login_module.dart';
import 'package:eventos_unaspht/app/pages/login/signup/signup_bloc.dart';
import 'package:eventos_unaspht/app/shared/components/button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class CategoryStep extends StatefulWidget {
  @override
  _CategoryStepState createState() => _CategoryStepState();
}

class _CategoryStepState extends State<CategoryStep> {
  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    Color orange = Theme.of(context).secondaryHeaderColor;
    SignupBloc signupBloc = LoginModule.to.getBloc<SignupBloc>();

    selectMainCategory(CategoryEnum c) {
      signupBloc.mainCategoryController.add(c);
    }
    selectSecondaryCategory(CategoryEnum c) {
      signupBloc.secondaryCategoryController.add(c);
    }

    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.all(30),
          child: StreamBuilder<CategoryEnum>(
            stream: signupBloc.mainCategoryController,
            builder: (c, s) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                      "Selecione a categoria principal na qual você se encaixa, lembrando que as informações serão verificadas"
                          .toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Theme.of(context).primaryColor)),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => selectMainCategory(CategoryEnum.Church),
                        child: CardGender(
                            horizontal: true,
                            icon: FontAwesomeIcons.church,
                            title: "Comunidade",
                            isSelected:
                                s.hasData && s.data == CategoryEnum.Church),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () =>
                            selectMainCategory(CategoryEnum.Internship),
                        child: CardGender(
                          horizontal: true,
                          icon: FontAwesomeIcons.bed,
                          title: "Internato",
                          isSelected:
                              s.hasData && s.data == CategoryEnum.Internship,
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => selectMainCategory(CategoryEnum.External),
                        child: CardGender(
                          horizontal: true,
                          icon: FontAwesomeIcons.home,
                          title: "Externato",
                          isSelected:
                              s.hasData && s.data == CategoryEnum.External,
                        ),
                      ),
                    ],
                  ),
                  s.hasData && s.data != CategoryEnum.Church
                      ? Column(
                          children: <Widget>[
                            SizedBox(height: 30),
                            Text("Selecione agora a subcategoria".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor)),
                            SizedBox(height: 20),
                            StreamBuilder<CategoryEnum>(
                                stream: signupBloc.secondaryCategoryController,
                                builder: (_, snapshot) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () => selectSecondaryCategory(
                                            CategoryEnum.College),
                                        child: CardGender(
                                          icon: FontAwesomeIcons.graduationCap,
                                          title: "Ensino superior",
                                          isSelected: snapshot.hasData &&
                                              snapshot.data ==
                                                  CategoryEnum.College,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () => selectSecondaryCategory(
                                            CategoryEnum.HighSchool),
                                        child: CardGender(
                                          icon: FontAwesomeIcons.bookOpen,
                                          title: "Ensino Básico",
                                          isSelected: snapshot.hasData &&
                                              snapshot.data ==
                                                  CategoryEnum.HighSchool,
                                        ),
                                      ),
                                    ],
                                  );
                                })
                          ],
                        )
                      : Container(),
                  SizedBox(height: 20),
                  StreamBuilder<bool>(
                      stream: signupBloc.isValidCategoryController,
                      builder: (_, snapshot) {
                        return Button(
                          enabled: snapshot.hasData && snapshot.data,
                          color: orange,
                          onTap: () => signupBloc.onTap(context),
                          context: context,
                          text: "Continuar",
                        );
                      })
                ],
              );
            },
          )),
    );
  }
}
