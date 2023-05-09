
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical_1/style/color/color.dart';

class CommnQu extends StatefulWidget {
  const CommnQu({Key? key}) : super(key: key);

  @override
  State<CommnQu> createState() => _CommnQuState();
}

class _CommnQuState extends State<CommnQu> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
        colorSchemeSeed: tLPurple,
        useMaterial3: true,
    ),
    home: Scaffold(
    backgroundColor: tLPurple,
    appBar: AppBar(
    backgroundColor: tLPurple,
    title: Text("اسئلة شائعة"),
    leading: IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () => Navigator.pop(context, false),
    )),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [

            Text("١- كم مرة يجب أن افرش أسناني؟",style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold),textDirection: TextDirection.ltr,textAlign: TextAlign.right),
            Text(" يوصى بتفريش أسنانك بالفرشاة مرتين في اليوم على الأقل",
                textDirection: TextDirection.ltr,textAlign: TextAlign.right),
            Text("٢- هل يجب ان استخدم خيط الاسنان ؟",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),textDirection: TextDirection.ltr,textAlign: TextAlign.right),
            Text(" يعد استخدام خيط الاسنان احد العوامل المهمه التي تساعد في المحافظه على صحة الفم وايضًا نجاح علاج تقويم الأسنان . حيث يساعد خيط الاسنان بإزالة بقايا الطعام بين الاسنان التي يصعب إزالتها باستخدام فرشاة الاسنان فقط ",
                textDirection: TextDirection.ltr,textAlign: TextAlign.right,),
            Text("٣- كم مره يجب ان استخدم خيط الاسنان ؟",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),textDirection: TextDirection.ltr,textAlign: TextAlign.right),
            Text(" على الاقل مره في اليوم",
                textDirection: TextDirection.ltr,textAlign: TextAlign.right),
            Text("٤- فرشاة أسنان عادية أم فرشاة أسنان كهربائية؟",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),textDirection: TextDirection.ltr,textAlign: TextAlign.right),
            Text(" استخدم فرشاة الأسنان التي تناسبك. تأكد من تنظيف أسنانك لمدة دقيقتين في كل مرة تقوم فيها بالتفريش! قم بتغيير فرشاة الأسنان أو رأس فرشاة الأسنان الكهربائية على الأقل كل ثلاثة أشهر ",
                textDirection: TextDirection.ltr,textAlign: TextAlign.right),
            Text("٥- هل هناك أدوات أخرى يمكنني استخدامها للمساعدة في نظافة الفم؟",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),textDirection: TextDirection.ltr,textAlign: TextAlign.right),
            Text(": إليك ثلاث أدوات فعالة لنظافة الفم",
                textDirection: TextDirection.ltr,textAlign: TextAlign.right),
            Text(" تعتبر  فرشاة ما بين الاسنان   ممتازة في إزالة جزيئات الطعام العالقة بين الأسنان وعلى اطراف دعامات التقويم ",
                textDirection: TextDirection.ltr,textAlign: TextAlign.right),
            Text(" الخيط المائي لتنظيف مابين الاسنان ",
                textDirection: TextDirection.ltr,textAlign: TextAlign.right),
            Text(" غسول فم يحتوي على الفلورايد ",
                textDirection: TextDirection.ltr,textAlign: TextAlign.right),
            Text("٦-ما نوع معجون الأسنان الذي يجب أن استخدمه ؟",style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold),textDirection: TextDirection.ltr,textAlign: TextAlign.right),
            Text("- يوصى باستخدام معجون أسنان يحتوي على الفلورايد ، معتمدًا من جمعية طب الأسنان الأمريكية",
                textDirection: TextDirection.ltr,textAlign: TextAlign.right),
            Text("٧-متى يجب أن أخبر طبيب تقويم الأسنان أن هناك مشكلة في علاجي؟",style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold),textDirection: TextDirection.ltr,textAlign: TextAlign.right),
            Text("إذا لاحظت حركة اي جزء في جهاز التقويم فأبلغ أخصائي تقويم الأسنان على الفور",
                textDirection: TextDirection.ltr,textAlign: TextAlign.right),
            Text("٨- هل التقويم مؤلم؟",style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold),textDirection: TextDirection.ltr,textAlign: TextAlign.right),
            Text("يمكن أن يكون هناك بعض الانزعاج الأولي عند وضع تقويم الأسنان ، أو لفترة قصيرة بعد كل موعد عند طبيبك ، لكن هذا مؤقت. بشكل عام ، فإن الالم في تقويم الأسنان قصير الأمد ويمكن تخفيفه بسهولة",
                textDirection: TextDirection.ltr,textAlign: TextAlign.right),
          ],
        ),
      ),
    )
    )
    );
  }
}
