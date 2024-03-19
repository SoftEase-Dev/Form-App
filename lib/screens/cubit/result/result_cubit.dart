import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_app/data/model/answer.dart';
import 'package:form_app/data/model/result.dart';
import 'package:form_app/data/model/submit_form.dart';
import 'package:form_app/screens/cubit/result/result_state.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:form_app/utils/Constant.dart' as Constants;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ResultCubit extends Cubit<ResultState> {
  ResultCubit() : super(InitialResultState());

  void countResult(List<Answer> dataAnswer, SubmitFormModel dataUser) async {
    emit(InitialResultState());
    try {
      int a = 0,
          b = 0,
          c = 0,
          d = 0,
          e = 0,
          f = 0,
          aA = 0,
          aB = 0,
          aC = 0,
          aD = 0,
          aE = 0,
          aF = 0,
          res = 0;

      double scor = 0;

      String categoryRes = "";

      List<Answer> newAnswer = dataAnswer;

      print("result cubit");

      if (newAnswer[0].answer == true) {
        e++;
      }
      if (newAnswer[1].answer == true) {
        c++;
      }
      if (newAnswer[2].answer == false) {
        e++;
      }
      if (newAnswer[3].answer == false) {
        f++;
      }
      if (newAnswer[4].answer == true) {
        d++;
      }
      if (newAnswer[5].answer == true) {
        b++;
      }
      if (newAnswer[6].answer == false) {
        d++;
      }
      if (newAnswer[7].answer == false) {
        a++;
      }
      if (newAnswer[8].answer == false) {
        e++;
      }
      if (newAnswer[9].answer == false) {
        a++;
      }
      if (newAnswer[10].answer == true) {
        d++;
      }
      if (newAnswer[11].answer == true) {
        a++;
      }
      if (newAnswer[12].answer == true) {
        a++;
      }
      if (newAnswer[13].answer == true) {
        e++;
      }
      if (newAnswer[14].answer == false) {
        a++;
      }

      aA = int.parse(newAnswer[15].answer) * a;

      aB = int.parse(newAnswer[16].answer) * b;

      aC = int.parse(newAnswer[17].answer) * c;

      aD = int.parse(newAnswer[18].answer) * d;

      aE = int.parse(newAnswer[19].answer) * e;

      aF = int.parse(newAnswer[20].answer) * f;

      res = aA + aB + aC + aD + aE + aF;
      print(res / 15);
      var format = NumberFormat("0.00");
      scor = double.parse(format.format(res / 15));

      if (scor >= 0 && scor <= 38) {
        categoryRes = "Overload";
      } else if (scor > 38 && scor <= 54.66) {
        categoryRes = "Optimal-Load";
      } else if (scor > 54.66 && scor <= 100) {
        categoryRes = "Under-Load";
      } else {
        categoryRes = "Undifined";
      }

      var url = Uri.parse("${Constants.BASE_URL}/form-record-skor-nasa-tlxes/");

      var response = await http.post(
        url,
        body: json.encode(
          {
            "data": {
              "nama": dataUser.name,
              "umur": int.parse(dataUser.age),
              "beratBadan": int.parse(dataUser.weight),
              "tinggiBadan": int.parse(dataUser.height),
              "question1": dataAnswer[0].answer,
              "question2": dataAnswer[1].answer,
              "question3": dataAnswer[2].answer,
              "question4": dataAnswer[3].answer,
              "question5": dataAnswer[4].answer,
              "question6": dataAnswer[5].answer,
              "question7": dataAnswer[6].answer,
              "question8": dataAnswer[7].answer,
              "question9": dataAnswer[8].answer,
              "question10": dataAnswer[9].answer,
              "question11": dataAnswer[10].answer,
              "question12": dataAnswer[11].answer,
              "question13": dataAnswer[12].answer,
              "question14": dataAnswer[13].answer,
              "question15": dataAnswer[14].answer,
              "question16": int.parse(dataAnswer[15].answer),
              "question17": int.parse(dataAnswer[16].answer),
              "question18": int.parse(dataAnswer[17].answer),
              "question19": int.parse(dataAnswer[18].answer),
              "question20": int.parse(dataAnswer[19].answer),
              "question21": int.parse(dataAnswer[20].answer),
              "kategoriBebanKognitif": categoryRes,
              "skorNasaTLX": scor
            }
          },
        ),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${dotenv.env["API_KEY"]}"
        },
      );

      print("response :" + response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        emit(LoadedResultState(
            resultData: Result(scor: scor, category: categoryRes)));
      } else {
        throw 'Failed get data : ${json.decode(response.body)['message']}';
      }

      print(dataUser.name);
      print(dataUser.age);
      print(dataUser.height);
      print(dataUser.weight);
      for (Answer answer in dataAnswer) {
        print("Number: ${answer.number}, Answer: ${answer.answer}");
      }
    } catch (err) {
      emit(ErrorResultState(errorMessage: err.toString()));
    }
  }
}
