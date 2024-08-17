import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';



void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  const MyHomePage(title: 'Examen2 Repo - Rafael Morales'),
    );
  }
}

class MyHomePage extends StatefulWidget {
 const MyHomePage({super.key, required this.title});
  
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

final TextEditingController preguntaController = TextEditingController();
final TextEditingController _controller2 = TextEditingController();
  
  
   String? _imageUrl;
  
   

  Future<void> _fetchYesNoAnswer() async {
    final response = await http.get(Uri.parse('https://yesno.wtf/api'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
       
        _imageUrl = data['image'];
      });
    } else {
      throw Exception('Failed to load API');
    }
  }

  void _imagen() {
    final text = _controller2.text;
    if (text.isNotEmpty && text.endsWith('?')) {
      setState(() {
        _texto =
            text; 
      });
      _fetchYesNoAnswer();
      _controller2.clear();

    }
    else
    {
        setState(() {
        _texto =
            ''; 
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Debes escribir una pregunta que termine en "?"'),
        ),
      );
      
      _controller2.clear();
    }
  }
  String _texto = "";

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(

       
        
        title: Text(widget.title),
      ),
      
      body:  Center(
       
        child: SingleChildScrollView(
          
          child: Column(
          
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
               if (_imageUrl != null)
                Image.network(_imageUrl!)
              else
                Container(
                    height: 200,
                    color: Colors.grey[300]), // Espacio vacío para la imagen
              const SizedBox(height: 20),
          Text(
            ' Pregunta: $_texto',
            style: const TextStyle(fontSize: 24),
          ),
             const SizedBox(
          
              height: 200,
             ),
          
                TextField(
              controller: _controller2,

            
              decoration: InputDecoration(
                hintText: 'Escribe  una pregunta',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: _imagen,
                ),
                 ),
                    ),
            
                    
              
            ],
          ),
        ),
      ),
       
    );
  }
}