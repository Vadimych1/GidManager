import 'package:flutter/material.dart';
import '../classes/cl_homepage_data.dart';
import 'package:url_launcher/url_launcher.dart';

class FormInputName {
  static String? _default(String? s) {
    return null;
  }

  FormInputName({
    required this.placeholder,
    required this.label,
    required this.name,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator = _default,
  });

  final String placeholder;
  final String label;
  final String name;
  final bool obscureText;
  final TextInputType keyboardType;
  String? Function(String?) validator;
}

class CustomForm extends StatefulWidget {
  const CustomForm({
    super.key,
    required this.inputs,
    required this.popOnSubmit,
    required this.validChanged,
  });

  final bool popOnSubmit;
  final List<FormInputName> inputs;
  final Function(bool) validChanged;

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final Map<String, dynamic> _data = {};
  List<Widget> inputs = [];

  @override
  void initState() {
    super.initState();

    for (var inp in widget.inputs) {
      _data[inp.name] = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    inputs = [];

    for (var inp in widget.inputs) {
      if (_data[inp.name] == null) {
        _data[inp.name] = TextEditingController();
      }

      inputs.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              inp.label,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            TextFormField(
              validator: inp.validator,
              controller: _data[inp.name],
              obscureText: inp.obscureText,
              keyboardType: inp.keyboardType,
              cursorHeight: 0,
              decoration: InputDecoration(
                errorStyle: const TextStyle(fontSize: 0),
                hintText: inp.placeholder,
                contentPadding: const EdgeInsets.only(left: 10),
                filled: true,
                fillColor: const Color(0xFFFFFFFF),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                hintStyle: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      );
    }
    return Form(
      canPop: widget.popOnSubmit,
      autovalidateMode: AutovalidateMode.always,
      onChanged: () {
        bool r = true;
        for (var inp in widget.inputs) {
          r = r && inp.validator(_data[inp.name].text) == null;
        }
        widget.validChanged(r);
      },
      child: Column(
        children: inputs,
      ),
    );
  }
}

class TownBlock extends StatefulWidget {
  const TownBlock(this.town, {super.key});

  final Town town;

  @override
  State<TownBlock> createState() => TownBlockState();
}

class TownBlockState extends State<TownBlock> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: open tour select
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        margin: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: const Color(0xffeeeeee),
          border: Border.all(
            color: const Color(0xFFdddddd),
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFFFFFFFF)),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: NetworkImage(widget.town.imagePath),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  widget.town.description.title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
                for (String e in widget.town.description.paragraphs)
                  Text(
                    e,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                for (String e in widget.town.description.links)
                  InkWell(
                    onTap: () {
                      launchUrl(Uri.parse(e));
                    },
                    child: Text(
                      e.length > 30 ? '${e.substring(0, 30)}...' : e,
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
              ],
            ),
            Positioned(
              right: 5,
              top: 5,
              child: Container(
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: const Color(0xaaFFFFFF),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.favorite_border_outlined, color: Colors.red),
                  onPressed: () {
                    // TODO: Add to favorite
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
