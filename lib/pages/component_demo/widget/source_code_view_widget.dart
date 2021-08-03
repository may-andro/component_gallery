import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'syntax_highlighter.dart';

class SourceCodeView extends StatefulWidget {
  final String filePath;
  final String? codeLinkPrefix;
  final bool showLabelText;
  final Color? iconBackgroundColor;
  final Color? iconForegroundColor;
  final Color? labelBackgroundColor;
  final TextStyle? labelTextStyle;
  final SyntaxHighlighterStyle? syntaxHighlighterStyle;

  const SourceCodeView({
    Key? key,
    required this.filePath,
    this.codeLinkPrefix,
    this.showLabelText = false,
    this.iconBackgroundColor,
    this.iconForegroundColor,
    this.labelBackgroundColor,
    this.labelTextStyle,
    this.syntaxHighlighterStyle,
  }) : super(key: key);

  String? get codeLink => this.codeLinkPrefix == null ? null : '${this.codeLinkPrefix}/${this.filePath}';

  @override
  _SourceCodeViewState createState() {
    return _SourceCodeViewState();
  }
}

class _SourceCodeViewState extends State<SourceCodeView> {
  double _textScaleFactor = 1.0;

  Widget _getCodeView(String codeContent, BuildContext context) {
    codeContent = codeContent.replaceAll('\r\n', '\n');
    final SyntaxHighlighterStyle style = widget.syntaxHighlighterStyle ??
        (Theme.of(context).brightness == Brightness.dark
            ? SyntaxHighlighterStyle.darkThemeStyle()
            : SyntaxHighlighterStyle.lightThemeStyle());
    return Container(
      constraints: BoxConstraints.expand(),
      child: Scrollbar(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SelectableText.rich(
            TextSpan(
              style: GoogleFonts.droidSansMono(fontSize: 12).apply(fontSizeFactor: this._textScaleFactor),
              children: <TextSpan>[DartSyntaxHighlighter(style).format(codeContent)],
            ),
            style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: this._textScaleFactor),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
	  print('_SourceCodeViewState.build ${widget.filePath}');
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString(widget.filePath),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.all(4.0),
              child: _getCodeView(snapshot.data!, context),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
